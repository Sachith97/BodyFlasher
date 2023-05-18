package com.sac.workoutservice.controller;

import com.sac.workoutservice.dao.LoginRequestDao;
import com.sac.workoutservice.enums.Response;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.service.UserService;
import org.springframework.web.bind.annotation.*;

/**
 * @author Sachith Harshamal
 * @created 2023-03-15
 */
@RestController
@RequestMapping(path = "/api/v1/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping(path = "/{id}", produces = {"application/json"})
    public CommonResponse getUser(@PathVariable("id") Long id) {
        return new CommonResponse(Response.SUCCESS);
    }

    @PostMapping(path = "/login", produces = {"application/json"})
    public CommonResponse login(@RequestBody LoginRequestDao loginRequest) {
        return userService.login(loginRequest);
    }
}
