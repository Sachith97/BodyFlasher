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
public class UserDao {

    private String firstName;
    private String lastName;
    private String email;
    private String profession;
    private Integer age;
    private Integer weight;
    private Integer height;
    private Double bmiValue;
    private String username;
}
