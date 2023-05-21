package com.sac.workoutservice.model;

import com.sac.workoutservice.enums.WorkoutExperience;
import com.sac.workoutservice.enums.WorkoutGoal;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author Sachith Harshamal
 * @created 2023-05-06
 */
@Data
@Entity
@Builder
@AllArgsConstructor
@RequiredArgsConstructor
@Table(name = "WORKOUT_PLAN")
public class WorkoutPlan implements Serializable {

    protected static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "EXPERIENCE", nullable = false)
    private WorkoutExperience experience;

    @Enumerated(EnumType.STRING)
    @Column(name = "WORKOUT_GOAL", nullable = false)
    private WorkoutGoal workoutGoal;

    @Column(name = "WORKOUT_NAME", length = 100)
    private String workoutName;

    @Column(name = "ORDER_", length = 5)
    private Integer order;

    @Column(name = "DAY", length = 5)
    private Integer day;

    @Column(name = "PREFER_BMI_FROM")
    private Double preferBMIFrom;

    @Column(name = "PREFER_BMI_TO")
    private Double preferBMITo;

    @Column(name = "ALLOCATED_SECONDS")
    private Integer allocatedSeconds;

    @Column(name = "RESOURCE_URL", length = 500)
    private String resourceURL;

    @Override
    public boolean equals(Object object) {
        if (object == null) {
            return false;
        }
        WorkoutPlan other = (WorkoutPlan) object;
        return !((this.getId() == null && other.getId() != null) ||
                (this.getId() != null && !this.getId().equals(other.getId())));
    }
}
