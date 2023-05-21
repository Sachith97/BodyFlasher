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
    public Optional<User> findUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public CommonResponse login(LoginRequestDao loginRequest) {
        Optional<User> user = this.findUserByUsername(loginRequest.getUsername());
        return user.filter(value -> value.getPassword().equals(loginRequest.getPassword())).map(value ->
                new CommonResponse(Response.SUCCESS, user.get())).orElseGet(() ->
                CommonResponse.builder()
                        .isOk(Boolean.FALSE)
                        .responseCode(404)
                        .responseMessage("Incorrect username or password")
                        .responseObject(null)
                        .build()
        );
    }

    @Override
    public CommonResponse save(User user) {
        userRepository.save(user);
        return new CommonResponse(Response.SUCCESS);
    }
}
