package com.sac.workoutservice.service.impl;

import com.sac.workoutservice.model.WorkoutPlan;
import com.sac.workoutservice.repository.WorkoutPlanRepository;
import com.sac.workoutservice.service.WorkoutService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Service
public class WorkoutServiceImpl implements WorkoutService {

    private final WorkoutPlanRepository workoutPlanRepository;

    public WorkoutServiceImpl(WorkoutPlanRepository workoutPlanRepository) {
        this.workoutPlanRepository = workoutPlanRepository;
    }

    @Override
    public List<WorkoutPlan> getWorkoutList() {
        return workoutPlanRepository.findAll();
    }
}
