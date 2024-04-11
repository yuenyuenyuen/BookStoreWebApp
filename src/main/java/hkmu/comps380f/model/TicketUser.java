package hkmu.comps380f.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "users")
public class TicketUser {
    @Id
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String address;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserRole> roles = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Favorite> favorites = new HashSet<>();

    public TicketUser() {}

    public TicketUser(String username, String password, String fullName, String email, String address, String[] roles) {
        this.username = username;
        this.password = "{noop}" + password;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        for (String role : roles) {
            this.roles.add(new UserRole(this, role));
        }
    }
    // getters and setters of all properties

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<UserRole> getRoles() {
        return roles;
    }

    public void setRoles(String[] roles) {
        for (String role : roles) {
            this.roles.add(new UserRole(this, role));
        }
    }

    public void deleteRole(UserRole role){
        roles.remove(role);
        role.setUser(null);
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Set<Favorite> getFavorites() {
        return favorites;
    }

    public void setFavorites(Set<Favorite> favorites) {
        this.favorites = favorites;
    }
}