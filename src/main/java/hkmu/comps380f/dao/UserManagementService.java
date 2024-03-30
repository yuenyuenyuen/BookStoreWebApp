package hkmu.comps380f.dao;

import hkmu.comps380f.model.TicketUser;
import hkmu.comps380f.model.UserRole;
import jakarta.annotation.Resource;
import org.springframework.security.core.parameters.P;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class UserManagementService {
    @Resource
    private TicketUserRepository tuRepo;
    @Transactional
    public List<TicketUser> getTicketUsers() {
        return tuRepo.findAll();
    }
    @Transactional
    public TicketUser getTicketUser(String username) throws UsernameNotFoundException{
        TicketUser ticketUser = tuRepo.findById(username).orElse(null);
        if(ticketUser==null){
            throw  new UsernameNotFoundException(username);
        }
        return ticketUser;
    }
    @Transactional
    public void delete(String username) {
        TicketUser ticketUser = tuRepo.findById(username).orElse(null);
        if (ticketUser == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }
        tuRepo.delete(ticketUser);
    }
    @Transactional
    public void createTicketUser(String username, String password, String fullName, String email, String address, String[] roles) {
        TicketUser user = new TicketUser(username, password, fullName, email, address, roles);
        tuRepo.save(user);
    }
    @Transactional
    public void updateTicketUser(String username, String password, String fullName, String email, String address, String[] roles){
        TicketUser ticketUser = tuRepo.findById(username).orElseThrow(() -> new UsernameNotFoundException("User '" + username + "' not found."));
        ticketUser.setPassword(password);
        ticketUser.setFullName(fullName);
        ticketUser.setEmail(email);
        for (UserRole role : new ArrayList<>(ticketUser.getRoles())) {
            ticketUser.deleteRole(role);
        }
        ticketUser.setRoles(roles);
        tuRepo.save(ticketUser);
    }

}
