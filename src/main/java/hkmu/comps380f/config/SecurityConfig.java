package hkmu.comps380f.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http)
            throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/user/register").permitAll()
                        .requestMatchers("/user/userinfo").hasAnyRole("ADMIN", "USER")
                        .requestMatchers("/user/userinfo/**").hasRole("ADMIN")
                        .requestMatchers("/user/**").hasRole("ADMIN")
                        .requestMatchers("/ticket/delete/**").hasRole("ADMIN")
                        .requestMatchers("/cart/**").hasAnyRole("ADMIN", "USER")
                        .requestMatchers("/favorite/**").hasAnyRole("ADMIN", "USER")
                        .requestMatchers("/checkout/**").hasAnyRole("ADMIN", "USER")
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/")
                        .failureUrl("/login?error")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                )
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret")
                        .tokenValiditySeconds(86400)
                )
                .httpBasic(withDefaults());
        return http.build();
    }
}