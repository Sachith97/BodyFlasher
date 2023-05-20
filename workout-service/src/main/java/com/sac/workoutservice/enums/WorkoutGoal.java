package com.sac.workoutservice.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Sachith Harshamal
 * @created 2023-05-06
 */
@Getter
@AllArgsConstructor
public enum WorkoutGoal {

    ABS("ABS"),
    BACK("BACK"),
    BICEPS("BICEPS"),
    CHEST("CHEST"),
    TRICEPS("TRICEPS"),
    LEGS("LEGS");

    private final String name;

    private static final Map<String, WorkoutGoal> lookup = new HashMap<>();

    static {
        for (WorkoutGoal goal : WorkoutGoal.values()) {
            lookup.put(goal.getName(), goal);
        }
    }

    public static WorkoutGoal get(String name) {
        return lookup.get(name);
    }
}
