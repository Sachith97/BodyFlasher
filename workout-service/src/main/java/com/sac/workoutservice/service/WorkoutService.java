package com.sac.workoutservice.service;

import com.sac.workoutservice.dao.UserWorkoutDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.model.WorkoutPlan;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
public interface WorkoutService {

    List<WorkoutPlan> getWorkoutList();

    CommonResponse saveWorkoutPlanRequest(WorkoutPlanRequestDao workoutPlanRequest);

    List<UserWorkoutDao> getUserWorkoutList(String username);
}
