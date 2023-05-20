package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

/**
 * @author Sachith Harshamal
 * @created 2023-05-18
 */
@Data
@Builder
@AllArgsConstructor
public class UserWorkoutDetailDao {

    private String workoutName;
    private Integer day;
    private Integer allocatedSeconds;
    private Integer completedSeconds;
    private String resourceURL;
}
