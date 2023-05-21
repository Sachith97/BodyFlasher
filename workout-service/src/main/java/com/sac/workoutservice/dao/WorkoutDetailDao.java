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
public class WorkoutDetailDao {

    private Integer id;
    private String workoutName;
    private String instructions;
    private Integer day;
    private Integer allocatedSeconds;
    private Integer completedSeconds;
    private String imageName;
    private String resourceURL;
}
