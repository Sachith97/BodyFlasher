package com.sac.workoutservice.service;

import com.sac.workoutservice.dao.CustomWorkoutPlanRequestDao;
import com.sac.workoutservice.dao.WorkoutDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.exception.CommonResponse;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
public interface WorkoutService {

    List<WorkoutDao> getWorkoutList();

    CommonResponse saveWorkoutPlanRequest(WorkoutPlanRequestDao workoutPlanRequest);

    CommonResponse saveCustomWorkoutPlanRequest(CustomWorkoutPlanRequestDao customWorkoutPlanRequest);

    List<WorkoutDao> getUserWorkoutList();
}
