package com.sac.workoutservice.service;

import com.sac.workoutservice.dao.LoginRequestDao;
import com.sac.workoutservice.exception.CommonResponse;

/**
 * @author Sachith Harshamal
 * @created 2023-05-18
 */
public interface UserService {

    CommonResponse login(LoginRequestDao loginRequest);
}
