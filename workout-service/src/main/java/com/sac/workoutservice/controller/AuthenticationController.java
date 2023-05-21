package com.sac.workoutservice.controller;

import com.sac.workoutservice.dao.AuthenticationRequestDao;
import com.sac.workoutservice.exception.CommonResponse;
import com.sac.workoutservice.service.AuthenticationService;
import org.springframework.web.bind.annotation.*;

/**
 * @author Sachith Harshamal
 * @created 2023-05-20
 */
@RestController
@CrossOrigin
@RequestMapping("/api/v1/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @PostMapping(value = "/login", produces = {"application/json"}, consumes = {"application/json"})
    public CommonResponse createAuthenticationToken(@RequestBody AuthenticationRequestDao authenticationRequest) {
        return authenticationService.authenticate(authenticationRequest);
    }
}
