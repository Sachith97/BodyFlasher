package com.sac.workoutservice.service;

import com.sac.workoutservice.dao.LoginRequestDao;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.model.User;

import java.util.Optional;

/**
 * @author Sachith Harshamal
 * @created 2023-05-18
 */
public interface UserService {

    Optional<User> getLoggedInUser();

    Optional<User> findUserByUsername(String username);

    CommonResponse login(LoginRequestDao loginRequest);

    CommonResponse save(User user);
}
