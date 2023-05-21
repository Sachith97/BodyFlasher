package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author Sachith Harshamal
 * @created 2023-05-22
 */
@Data
@AllArgsConstructor
public class CustomWorkoutPlanRequestDao {

    private Integer exerciseId;
    private Integer requestedSeconds;
}
