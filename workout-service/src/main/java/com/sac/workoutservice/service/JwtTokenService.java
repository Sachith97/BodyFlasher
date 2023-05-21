package com.sac.workoutservice.service;

import io.jsonwebtoken.Claims;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Date;
import java.util.function.Function;

/**
 * @author Sachith Harshamal
 * @created 2023-05-20
 */
public interface JwtTokenService {

    String extractUsername(String token);

    Date extractExpiration(String token);

    <T> T extractClaim(String token, Function<Claims, T> claimResolver);

    String generateToken(UserDetails userDetails);

    Boolean validateToken(String token, UserDetails userDetails);
}
