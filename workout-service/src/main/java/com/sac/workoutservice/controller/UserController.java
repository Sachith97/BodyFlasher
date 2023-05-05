package com.sac.workoutservice.controller;

import com.sac.workoutservice.enums.Response;
import com.sac.workoutservice.exception.CommonResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Sachith Harshamal
 * @created 2023-03-15
 */
@RestController
@RequestMapping(path = "/api/v1/user")
public class UserController {

    @GetMapping(path = "/{id}", produces = {"application/json"})
    public CommonResponse getUser(@PathVariable("id") Long id) {
        return new CommonResponse(Response.SUCCESS);
    }
}
