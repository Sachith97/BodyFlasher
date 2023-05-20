package com.sac.workoutservice.service.impl;

import com.sac.workoutservice.dao.UserWorkoutDao;
import com.sac.workoutservice.dao.UserWorkoutDetailDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.enums.Response;
import com.sac.workoutservice.enums.WorkoutExperience;
import com.sac.workoutservice.enums.WorkoutGoal;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.model.User;
import com.sac.workoutservice.model.UserWorkout;
import com.sac.workoutservice.model.UserWorkoutDetail;
import com.sac.workoutservice.model.WorkoutPlan;
import com.sac.workoutservice.repository.UserWorkoutRepository;
import com.sac.workoutservice.repository.WorkoutPlanRepository;
import com.sac.workoutservice.service.UserService;
import com.sac.workoutservice.service.WorkoutService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Service
public class WorkoutServiceImpl implements WorkoutService {

    private final WorkoutPlanRepository workoutPlanRepository;
    private final UserWorkoutRepository userWorkoutRepository;

    private final UserService userService;

    public WorkoutServiceImpl(WorkoutPlanRepository workoutPlanRepository, UserWorkoutRepository userWorkoutRepository, UserService userService) {
        this.workoutPlanRepository = workoutPlanRepository;
        this.userWorkoutRepository = userWorkoutRepository;
        this.userService = userService;
    }

    @Override
    public List<WorkoutPlan> getWorkoutList() {
        return workoutPlanRepository.findAll();
    }

    @Override
    public CommonResponse saveWorkoutPlanRequest(WorkoutPlanRequestDao workoutPlanRequest) {
        Optional<User> user = userService.findUserByUsername(workoutPlanRequest.getUsername());
        if (user.isEmpty()) {
            return new CommonResponse(Response.NOT_FOUND);
        }
        UserWorkout userWorkout = UserWorkout.builder()
                .experience(WorkoutExperience.get(workoutPlanRequest.getExperience()))
                .workoutGoal(WorkoutGoal.get(workoutPlanRequest.getGoal()))
                .fkUser(user.get())
                .build();
        userWorkoutRepository.save(userWorkout);
        return null;
    }

    @Override
    public List<UserWorkoutDao> getUserWorkoutList(String username) {
        Optional<User> user = userService.findUserByUsername(username);
        if (user.isEmpty()) {
            return null;
        }
        List<UserWorkout> workoutList = userWorkoutRepository.findByFkUser(user.get());
        return workoutList.stream()
                .map(this::extractWorkoutInfo)
                .collect(Collectors.toList());
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
                .day(userWorkoutDetail.getFkWorkoutPlan().getDay())
                .allocatedSeconds(userWorkoutDetail.getFkWorkoutPlan().getAllocatedSeconds())
                .completedSeconds(userWorkoutDetail.getCompletedSeconds())
                .resourceURL(userWorkoutDetail.getFkWorkoutPlan().getResourceURL())
                .build();
    }
}
