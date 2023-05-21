package com.sac.workoutservice.repository;

import com.sac.workoutservice.enums.WorkoutGoal;
import com.sac.workoutservice.model.User;
import com.sac.workoutservice.model.UserWorkout;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Repository
public interface UserWorkoutRepository extends JpaRepository<UserWorkout, Long> {

    List<UserWorkout> findByFkUser(User user);

    List<UserWorkout> findByFkUserAndWorkoutGoal(User user, WorkoutGoal workoutGoal);
}
