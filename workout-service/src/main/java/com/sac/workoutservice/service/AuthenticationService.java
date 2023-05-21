package com.sac.workoutservice.service;

import com.sac.workoutservice.dao.AuthenticationRequestDao;
import com.sac.workoutservice.exception.CommonResponse;

/**
 * @author Sachith Harshamal
 * @created 2023-05-20
 */
public interface AuthenticationService {

    CommonResponse authenticate(AuthenticationRequestDao authenticationRequest);
}
