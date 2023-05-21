package com.sac.workoutservice.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author Sachith Harshamal
 * @created 2023-05-06
 */
@Data
@Entity
@Builder
@AllArgsConstructor
@RequiredArgsConstructor
@Table(name = "USER_WORKOUT_DETAIL")
public class UserWorkoutDetail implements Serializable {

    protected static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "STARTED_DATE")
    private Date startedDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "COMPLETED_DATE")
    private Date completedDate;

    @Column(name = "COMPLETED_SECONDS")
    private Integer completedSeconds;

    @ManyToOne
    @JoinColumn(name = "FK_USER_WORKOUT")
    private UserWorkout fkUserWorkout;

    @OneToOne
    @JoinColumn(name = "FK_WORKOUT_PLAN")
    private WorkoutPlan fkWorkoutPlan;

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof UserWorkoutDetail other)) {
            return false;
        }
        return !((this.getId() == null && other.getId() != null) ||
                (this.getId() != null && !this.getId().equals(other.getId())));
    }
}
