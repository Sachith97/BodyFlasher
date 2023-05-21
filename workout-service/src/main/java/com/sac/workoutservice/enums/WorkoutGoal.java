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

    CARDIO("Cardio", "cardio-img"),
    SHOULDERS("Shoulders", "shoulders-img"),
    BICEPS("Biceps", "biceps-img"),
    CHEST("Chest", "chest-img"),
    ABS("Abs", "abs-img"),
    FOREARMS("Forearms", "forearms-img"),
    TRICEPS("Triceps", "triceps-img"),
    LOWER_BACK("Lower Back", "lowerback-img"),
    QUADS("Quads", "quads-img"),
    CALVES("Calves", "calves-img");

    private final String name;
    private final String imageName;

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
