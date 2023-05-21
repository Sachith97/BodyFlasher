package com.sac.workoutservice.repository;

import com.sac.workoutservice.enums.WorkoutGoal;
import com.sac.workoutservice.model.WorkoutPlan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Repository
public interface WorkoutPlanRepository extends JpaRepository<WorkoutPlan, Long> {

    List<WorkoutPlan> findByWorkoutGoalAndPreferBMIFromGreaterThanEqualAndPreferBMIToLessThanEqual(WorkoutGoal workoutGoal, double bmiFrom, double bmiTo);
}
