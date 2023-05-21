package com.sac.workoutservice.controller;

import com.sac.workoutservice.dao.CustomWorkoutPlanRequestDao;
import com.sac.workoutservice.dao.WorkoutDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.service.WorkoutService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@RestController
@CrossOrigin
@RequestMapping(path = "/api/v1/workouts")
public class WorkoutController {

    private final WorkoutService workoutService;

    public WorkoutController(WorkoutService workoutService) {
        this.workoutService = workoutService;
    }

    @GetMapping(path = "/", produces = {"application/json"})
    public List<WorkoutDao> findWorkouts() {
        return workoutService.getWorkoutList();
    }

    @PostMapping(path = "/request", produces = {"application/json"}, consumes = {"application/json"})
    public CommonResponse saveWorkoutPlanRequest(@RequestBody WorkoutPlanRequestDao workoutPlanRequest) {
        return workoutService.saveWorkoutPlanRequest(workoutPlanRequest);
    }

    @PostMapping(path = "/request/custom", produces = {"application/json"}, consumes = {"application/json"})
    public CommonResponse saveCustomWorkoutPlanRequest(@RequestBody CustomWorkoutPlanRequestDao customWorkoutPlanRequest) {
        return workoutService.saveCustomWorkoutPlanRequest(customWorkoutPlanRequest);
    }

    @GetMapping(path = "/user/workouts", produces = {"application/json"}, consumes = {"application/json"})
    public List<WorkoutDao> getUserWorkoutPlans() {
        return workoutService.getUserWorkoutList();
    }
}
