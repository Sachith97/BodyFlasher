package com.sac.workoutservice.service;

import com.sac.workoutservice.model.WorkoutPlan;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
public interface WorkoutService {

    List<WorkoutPlan> getWorkoutList();
}
