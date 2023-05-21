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

    CARDIO("Cardio"),
    SHOULDERS("Shoulders"),
    BICEPS("Biceps"),
    CHEST("Chest"),
    ABS("Abs"),
    FOREARMS("Forearms"),
    TRICEPS("Triceps"),
    LOWER_BACK("Lower Back"),
    QUADS("Quads"),
    CALVES("Calves");

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
