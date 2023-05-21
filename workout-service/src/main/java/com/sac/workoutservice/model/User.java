package com.sac.workoutservice.model;

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
@Table(name = "USER")
public class User implements Serializable {

    protected static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "FIRST_NAME", length = 100)
    private String firstName;

    @Column(name = "LAST_NAME", length = 100)
    private String lastName;

    @Column(name = "EMAIL", length = 50)
    private String email;

    @Column(name = "PROFESSION")
    private String profession;

    @Column(name = "AGE")
    private Integer age;

    @Column(name = "WEIGHT")
    private Integer weight;

    @Column(name = "HEIGHT")
    private Integer height;

    @Column(name = "USERNAME", unique = true, length = 20)
    private String username;

    @Column(name = "PASSWORD")
    private String password;

    @Override
    public boolean equals(Object object) {
        if (object == null) {
            return false;
        }
        User other = (User) object;
        return !((this.getId() == null && other.getId() != null) ||
                (this.getId() != null && !this.getId().equals(other.getId())));
    }
}
