package com.sac.workoutservice.controller;

import com.sac.workoutservice.dao.UserWorkoutDao;
import com.sac.workoutservice.dao.WorkoutPlanRequestDao;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.model.WorkoutPlan;
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
    public List<WorkoutPlan> findWorkouts() {
        return workoutService.getWorkoutList();
    }

    @PostMapping(path = "/request", produces = {"application/json"}, consumes = {"application/json"})
    public CommonResponse saveWorkoutPlanRequest(@RequestBody WorkoutPlanRequestDao workoutPlanRequest) {
        return workoutService.saveWorkoutPlanRequest(workoutPlanRequest);
    }

    @GetMapping(path = "/user/{username}", produces = {"application/json"}, consumes = {"application/json"})
    public List<UserWorkoutDao> saveWorkoutPlanRequest(@PathVariable("username") String username) {
        return workoutService.getUserWorkoutList(username);
    }
}
