package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author Sachith Harshamal
 * @created 2023-05-18
 */
@Data
@AllArgsConstructor
public class LoginRequestDao {

    private String username;
    private String password;
}
