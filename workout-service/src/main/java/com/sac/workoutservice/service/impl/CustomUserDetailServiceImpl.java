package com.sac.workoutservice.service.impl;

import com.sac.workoutservice.model.User;
import com.sac.workoutservice.model.UserPrincipal;
import com.sac.workoutservice.repository.UserRepository;
import com.sac.workoutservice.service.CustomUserDetailService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * @author Sachith Harshamal
 * @created 2023-05-20
 */
@Service
public class CustomUserDetailServiceImpl implements CustomUserDetailService {

    private final UserRepository userRepository;

    public CustomUserDetailServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = userRepository.findByUsername(username);
        if(user.isEmpty()) {
            throw new UsernameNotFoundException("User 404");
        }
        return new UserPrincipal(user.get());
    }
}
