package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

/**
 * @author Sachith Harshamal
 * @created 2023-05-20
 */
@Data
@Builder
@AllArgsConstructor
public class AuthenticationResponseDao {

    private String jwt;
    private UserDao user;
}
