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
public enum WorkoutExperience {

    BEGINNER("BEGINNER"),
    INTERMEDIATE("INTERMEDIATE"),
    ADVANCED("ADVANCED");

    private final String name;

    private static final Map<String, WorkoutExperience> lookup = new HashMap<>();

    static {
        for (WorkoutExperience experience : WorkoutExperience.values()) {
            lookup.put(experience.getName(), experience);
        }
    }

    public static WorkoutExperience get(String name) {
        return lookup.get(name);
    }
}
