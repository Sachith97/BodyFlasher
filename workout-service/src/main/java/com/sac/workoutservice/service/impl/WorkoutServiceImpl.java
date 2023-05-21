package com.sac.workoutservice.service.impl;

import com.sac.workoutservice.dao.CustomWorkoutPlanRequestDao;
import com.sac.workoutservice.dao.WorkoutDao;
import com.sac.workoutservice.dao.WorkoutDetailDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.enums.Response;
import com.sac.workoutservice.enums.WorkoutCategory;
import com.sac.workoutservice.enums.WorkoutGoal;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.model.User;
import com.sac.workoutservice.model.UserWorkout;
import com.sac.workoutservice.model.UserWorkoutDetail;
import com.sac.workoutservice.model.WorkoutPlan;
import com.sac.workoutservice.repository.UserWorkoutDetailRepository;
import com.sac.workoutservice.repository.UserWorkoutRepository;
import com.sac.workoutservice.repository.WorkoutPlanRepository;
import com.sac.workoutservice.service.UserService;
import com.sac.workoutservice.service.WorkoutService;
import com.sac.workoutservice.util.DateUtil;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Service
public class WorkoutServiceImpl implements WorkoutService {

    private final WorkoutPlanRepository workoutPlanRepository;
    private final UserWorkoutRepository userWorkoutRepository;
    private final UserWorkoutDetailRepository userWorkoutDetailRepository;

    private final UserService userService;

    public WorkoutServiceImpl(WorkoutPlanRepository workoutPlanRepository, UserWorkoutRepository userWorkoutRepository, UserWorkoutDetailRepository userWorkoutDetailRepository, UserService userService) {
        this.workoutPlanRepository = workoutPlanRepository;
        this.userWorkoutRepository = userWorkoutRepository;
        this.userWorkoutDetailRepository = userWorkoutDetailRepository;
        this.userService = userService;
    }

    @Override
    public List<WorkoutDao> getWorkoutList() {
        Map<WorkoutGoal, List<WorkoutPlan>> planListMap =
                workoutPlanRepository.findAll()
                        .stream()
                        .collect(Collectors.groupingBy(WorkoutPlan::getWorkoutGoal));
        return extractMasterWorkoutInfo(planListMap);
    }

    @Override
    public CommonResponse saveWorkoutPlanRequest(WorkoutPlanRequestDao workoutPlanRequest) {
        Optional<User> user = userService.getLoggedInUser();
        if (!user.isPresent()) {
            return new CommonResponse(Response.UNAUTHORIZED);
        }
        // find previous workouts for selected goal and remove
        WorkoutGoal workoutGoal = WorkoutGoal.get(workoutPlanRequest.getGoal());
        List<UserWorkout> workoutList = userWorkoutRepository.findByFkUserAndWorkoutGoal(user.get(), workoutGoal);
        userWorkoutRepository.deleteAll(workoutList);
        // proceed with new request
        UserWorkout userWorkout = UserWorkout.builder()
                .workoutGoal(workoutGoal)
                .workoutCategory(WorkoutCategory.INSTRUCT)
                .fkUser(user.get())
                .build();
        userWorkoutRepository.save(userWorkout);
        // update user info
        user.get().setAge(calculateAge(workoutPlanRequest.getBirthdayTimestamp()));
        user.get().setHeight(workoutPlanRequest.getHeight());
        user.get().setWeight(workoutPlanRequest.getWeight());
        user.get().setBmiValue(
                calculateBMI(workoutPlanRequest.getHeight(), workoutPlanRequest.getWeight())
        );
        userService.save(user.get());
        // find matching workouts
        List<WorkoutPlan> workoutPlanList =
                workoutPlanRepository.findByWorkoutGoalAndPreferBMIFromGreaterThanEqualAndPreferBMIToLessThanEqual(
                        workoutGoal,
                        user.get().getBmiValue(),
                        user.get().getBmiValue()
                );
        workoutPlanList.forEach(plan -> this.saveWorkoutPlan(plan, userWorkout));
        return new CommonResponse(Response.SUCCESS);
    }

    @Override
    public CommonResponse saveCustomWorkoutPlanRequest(CustomWorkoutPlanRequestDao customWorkoutPlanRequest) {
        Optional<User> user = userService.getLoggedInUser();
        if (!user.isPresent()) {
            return new CommonResponse(Response.UNAUTHORIZED);
        }
        Optional<WorkoutPlan> workoutPlan = workoutPlanRepository.findById(customWorkoutPlanRequest.getExerciseId().longValue());
        if (!workoutPlan.isPresent()) {
            return new CommonResponse(Response.NOT_FOUND);
        }
        UserWorkout userWorkout = UserWorkout.builder()
                .workoutGoal(workoutPlan.get().getWorkoutGoal())
                .workoutCategory(WorkoutCategory.CUSTOM)
                .fkUser(user.get())
                .build();
        userWorkoutRepository.save(userWorkout);
        UserWorkoutDetail userWorkoutDetail = UserWorkoutDetail.builder()
                .requestedSeconds(customWorkoutPlanRequest.getRequestedSeconds())
                .fkUserWorkout(userWorkout)
                .fkWorkoutPlan(workoutPlan.get())
                .build();
        userWorkoutDetailRepository.save(userWorkoutDetail);
        return new CommonResponse(Response.SUCCESS);
    }

    @Override
    public List<WorkoutDao> getUserWorkoutList() {
        Optional<User> user = userService.getLoggedInUser();
        if (!user.isPresent()) {
            return null;
        }
        List<UserWorkout> workoutList = userWorkoutRepository.findByFkUser(user.get());
        return workoutList.stream()
                .map(this::extractUserWorkoutInfo)
                .collect(Collectors.toList());
    }

    private List<WorkoutDao> extractMasterWorkoutInfo(Map<WorkoutGoal, List<WorkoutPlan>> planListMap) {
        List<WorkoutDao> workoutDaoList = new ArrayList<>();
        planListMap.forEach((goal, planList) -> workoutDaoList.add(
                WorkoutDao.builder()
                        .goal(goal.getName())
                        .imageName(goal.getImageName())
                        .experience(null)
                        .workoutCategory(null)
                        .workoutList(
                                planList.stream()
                                        .map(this::extractMasterWorkoutDetailInfo)
                                        .collect(Collectors.toList())
                        )
                        .build()
        ));
        return workoutDaoList;
    }

    private WorkoutDetailDao extractMasterWorkoutDetailInfo(WorkoutPlan workoutPlan) {
        return WorkoutDetailDao.builder()
                .id(workoutPlan.getId().intValue())
                .workoutName(workoutPlan.getWorkoutName())
                .instructions(workoutPlan.getInstructions())
                .day(workoutPlan.getDay())
                .allocatedSeconds(workoutPlan.getAllocatedSeconds())
                .completedSeconds(0)
                .imageName(workoutPlan.getImageName())
                .resourceURL(workoutPlan.getResourceURL())
                .build();
    }

    private int calculateAge(int timeStamp) {
        // calculate age
        Instant instant = Instant.ofEpochSecond(timeStamp);
        return DateUtil.getYearsBetweenDates(Date.from(instant), new Date());
    }

    public double calculateBMI(double heightInCm, double weightInKg) {
        double heightInM = heightInCm / 100;
        return weightInKg / (heightInM * heightInM);
    }

    private void saveWorkoutPlan(WorkoutPlan workoutPlan, UserWorkout userWorkout) {
        UserWorkoutDetail userWorkoutDetail = UserWorkoutDetail.builder()
                .fkUserWorkout(userWorkout)
                .fkWorkoutPlan(workoutPlan)
                .build();
        userWorkoutDetailRepository.save(userWorkoutDetail);
    }

    private WorkoutDao extractUserWorkoutInfo(UserWorkout userWorkout) {
        return WorkoutDao.builder()
                .goal(userWorkout.getWorkoutGoal().getName())
                .experience(userWorkout.getExperience() != null ? userWorkout.getExperience().getName() : null)
                .workoutCategory(userWorkout.getWorkoutCategory().getName())
                .workoutList(
                        userWorkout.getWorkoutList().stream()
                                .map(this::extractUserWorkoutDetailInfo)
                                .collect(Collectors.toList())
                )
                .build();
    }

    private WorkoutDetailDao extractUserWorkoutDetailInfo(UserWorkoutDetail userWorkoutDetail) {
        return WorkoutDetailDao.builder()
                .id(userWorkoutDetail.getFkWorkoutPlan().getId().intValue())
                .workoutName(userWorkoutDetail.getFkWorkoutPlan().getWorkoutName())
                .instructions(userWorkoutDetail.getFkWorkoutPlan().getInstructions())
                .day(userWorkoutDetail.getFkWorkoutPlan().getDay())
                .allocatedSeconds(userWorkoutDetail.getFkWorkoutPlan().getAllocatedSeconds())
                .completedSeconds(userWorkoutDetail.getCompletedSeconds())
                .imageName(userWorkoutDetail.getFkWorkoutPlan().getImageName())
                .resourceURL(userWorkoutDetail.getFkWorkoutPlan().getResourceURL())
                .build();
    }
}
