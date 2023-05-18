package com.sac.workoutservice.service.impl;

import com.sac.workoutservice.dao.LoginRequestDao;
import com.sac.workoutservice.enums.Response;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.model.User;
import com.sac.workoutservice.repository.UserRepository;
import com.sac.workoutservice.service.UserService;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * @author Sachith Harshamal
 * @created 2023-05-07
 */
@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public CommonResponse login(LoginRequestDao loginRequest) {
        Optional<User> user = userRepository.findByUsername(loginRequest.getUsername());
        return user.map(value -> value.getPassword().equals(loginRequest.getPassword()) ? new CommonResponse(Response.SUCCESS) : new CommonResponse(Response.UNAUTHORIZED))
                .orElseGet(() -> new CommonResponse(Response.NOT_FOUND));
    }
}
