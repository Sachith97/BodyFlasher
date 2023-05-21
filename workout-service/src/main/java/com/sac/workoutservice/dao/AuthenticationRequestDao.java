package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author Sachith Harshamal
 * @created 2023-05-20
 */
@Data
@AllArgsConstructor
public class AuthenticationRequestDao {

    private String username;
    private String password;
}
