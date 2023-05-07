package com.sac.workoutservice.repository;

import com.sac.workoutservice.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
}
