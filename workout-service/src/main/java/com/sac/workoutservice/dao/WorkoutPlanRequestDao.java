package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author Sachith Harshamal
 * @created 2023-05-17
 */
@Data
@AllArgsConstructor
public class WorkoutPlanRequestDao {

    private Integer birthdayTimestamp;
    private String gender;
    private Integer height;
    private Integer weight;
    private String goal;
    private String experience;
    private String username;
}
