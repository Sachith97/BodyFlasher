package com.sac.workoutservice.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Sachith Harshamal
 * @created 2023-05-22
 */
@Getter
@AllArgsConstructor
public enum WorkoutCategory {

    INSTRUCT("INSTRUCT"),
    CUSTOM("CUSTOM");

    private final String name;

    private static final Map<String, WorkoutCategory> lookup = new HashMap<>();

    static {
        for (WorkoutCategory goal : WorkoutCategory.values()) {
            lookup.put(goal.getName(), goal);
        }
    }

    public static WorkoutCategory get(String name) {
        return lookup.get(name);
    }
}
