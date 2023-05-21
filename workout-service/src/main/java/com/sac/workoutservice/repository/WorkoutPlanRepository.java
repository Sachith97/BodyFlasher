package com.sac.workoutservice.repository;

import com.sac.workoutservice.enums.WorkoutGoal;
import com.sac.workoutservice.model.WorkoutPlan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Repository
public interface WorkoutPlanRepository extends JpaRepository<WorkoutPlan, Long> {

    @Query("SELECT T FROM WorkoutPlan T WHERE T.workoutGoal = :workoutGoal AND T.preferBMIFrom <= :bmi AND T.preferBMITo >= :bmi")
    List<WorkoutPlan> findByWorkoutGoalAndBMI(WorkoutGoal workoutGoal, double bmi);
}
