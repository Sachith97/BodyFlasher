package com.sac.workoutservice.controller;

import com.sac.workoutservice.model.WorkoutPlan;
import com.sac.workoutservice.service.WorkoutService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@RestController
@RequestMapping(path = "/api/v1/workouts")
public class WorkoutController {

    private final WorkoutService workoutService;

    public WorkoutController(WorkoutService workoutService) {
        this.workoutService = workoutService;
    }

    @GetMapping(path = "/", produces = {"application/json"})
    public List<WorkoutPlan> findWorkouts() {
        return workoutService.getWorkoutList();
    }
}
