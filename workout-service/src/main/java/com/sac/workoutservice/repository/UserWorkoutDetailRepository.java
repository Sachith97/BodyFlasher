package com.sac.workoutservice.repository;

import com.sac.workoutservice.model.UserWorkout;
import com.sac.workoutservice.model.UserWorkoutDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Repository
public interface UserWorkoutDetailRepository extends JpaRepository<UserWorkoutDetail, Long> {

    List<UserWorkoutDetail> findByFkUserWorkout(UserWorkout userWorkout);
}
