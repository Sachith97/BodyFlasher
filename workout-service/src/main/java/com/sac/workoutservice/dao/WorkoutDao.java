package com.sac.workoutservice.dao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-18
 */
@Data
@Builder
@AllArgsConstructor
public class WorkoutDao {

    private String goal;
    private String experience;
    private List<WorkoutDetailDao> workoutList;
}
