package com.sac.workoutservice.service.impl;

import com.sac.workoutservice.dao.UserWorkoutDao;
import com.sac.workoutservice.dao.UserWorkoutDetailDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.enums.Response;
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
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
    public List<WorkoutPlan> getWorkoutList() {
        return workoutPlanRepository.findAll();
    }

    @Override
    public CommonResponse saveWorkoutPlanRequest(WorkoutPlanRequestDao workoutPlanRequest) {
        Optional<User> user = userService.getLoggedInUser();
        if (!user.isPresent()) {
            return new CommonResponse(Response.NOT_FOUND);
        }
        // find previous workouts for selected goal and remove
        WorkoutGoal workoutGoal = WorkoutGoal.get(workoutPlanRequest.getGoal());
        List<UserWorkout> workoutList = userWorkoutRepository.findByFkUserAndWorkoutGoal(user.get(), workoutGoal);
        userWorkoutRepository.deleteAll(workoutList);
        // proceed with new request
        UserWorkout userWorkout = UserWorkout.builder()
                .workoutGoal(workoutGoal)
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
    public List<UserWorkoutDao> getUserWorkoutList(String username) {
        Optional<User> user = userService.findUserByUsername(username);
        if (!user.isPresent()) {
            return null;
        }
        List<UserWorkout> workoutList = userWorkoutRepository.findByFkUser(user.get());
        return workoutList.stream()
                .map(this::extractWorkoutInfo)
                .collect(Collectors.toList());
    }

    @Override
    public List<String> getGoalList() {
        return Stream.of(WorkoutGoal.values()).map(WorkoutGoal::getName).collect(Collectors.toList());
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

    private UserWorkoutDao extractWorkoutInfo(UserWorkout userWorkout) {
        return UserWorkoutDao.builder()
                .goal(userWorkout.getWorkoutGoal().getName())
                .experience(userWorkout.getExperience().getName())
                .workoutList(
                        userWorkout.getWorkoutList().stream()
                                .map(this::extractWorkoutDetailInfo)
                                .collect(Collectors.toList())
                )
                .build();
    }

    private UserWorkoutDetailDao extractWorkoutDetailInfo(UserWorkoutDetail userWorkoutDetail) {
        return UserWorkoutDetailDao.builder()
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
