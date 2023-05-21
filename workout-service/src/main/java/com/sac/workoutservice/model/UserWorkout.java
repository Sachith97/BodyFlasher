package com.sac.workoutservice.model;

import com.sac.workoutservice.enums.WorkoutExperience;
import com.sac.workoutservice.enums.WorkoutGoal;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * @author Sachith Harshamal
 * @created 2023-05-06
 */
@Data
@Entity
@Builder
@AllArgsConstructor
@RequiredArgsConstructor
@Table(name = "USER_WORKOUT")
public class UserWorkout implements Serializable {

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

    @ManyToOne
    @JoinColumn(name = "FK_USER")
    private User fkUser;

    @OneToMany(mappedBy = "fkUserWorkout")
    private List<UserWorkoutDetail> workoutList;

    @Override
    public boolean equals(Object object) {
        if (object == null) {
            return false;
        }
        UserWorkout other = (UserWorkout) object;
        return !((this.getId() == null && other.getId() != null) ||
                (this.getId() != null && !this.getId().equals(other.getId())));
    }
}
