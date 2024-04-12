package hkmu.comps380f.controller;

import hkmu.comps380f.dao.UserManagementService;
import hkmu.comps380f.model.TicketUser;
import hkmu.comps380f.model.UserRole;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserManagementController {
    @Resource
    UserManagementService umService;
    @GetMapping({"", "/", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("ticketUsers", umService.getTicketUsers());
        return "listUser";
    }
    public static class Form {
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String address;
        private String[] roles;
        // getters and setters for all properties

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

        public String getFullName() {return fullName;}

        public void setFullName(String fullName) {this.fullName = fullName;}

        public String getEmail() {return email;}

        public void setEmail(String email) {this.email = email;}

        public String getAddress() {return address;}

        public void setAddress(String address) {this.address = address;}

        public String[] getRoles() {
            return roles;
        }

        public void setRoles(String[] roles) {
            this.roles = roles;
        }
    }
    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("addUser", "ticketUser", new Form());
    }
    @PostMapping("/create")
    public String create(Form form) throws IOException {
        umService.createTicketUser(form.getUsername(),
                form.getPassword(), form.getFullName(), form.getEmail(),
                form.getAddress(), form.getRoles());
        return "redirect:/user/list";
    }

    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("register", "ticketUser", new Form());
    }
    @PostMapping("/register")
    public String register(Form form) throws IOException {
        umService.createTicketUser(form.getUsername(),
                form.getPassword(), form.getFullName(), form.getEmail(),
                form.getAddress(), form.getRoles());
        return "redirect:/login";
    }

    @GetMapping("/userinfo")
    public ModelAndView editInfo(Model model, Form form, Principal principal) {
        String username = principal.getName();
        TicketUser ticketUser = umService.getTicketUser(username);
        form.setUsername(ticketUser.getUsername());
        form.setPassword(ticketUser.getPassword().replace("{noop}", ""));
        form.setFullName(ticketUser.getFullName());
        form.setEmail(ticketUser.getEmail());
        form.setAddress(ticketUser.getAddress());
        List<UserRole> userRoleList = ticketUser.getRoles();
        String[] passRole = new String[userRoleList.size()];
        for(int i = 0; i < userRoleList.size(); i++){
            passRole[i] = userRoleList.get(i).getRole();
        }
        form.setRoles(passRole);
        model.addAttribute("ticketUser", form);
        return new ModelAndView("editInfo", "ticketUser", form);
    }
    @PostMapping("/userinfo")
    public String editInfo(Form form) throws IOException {
        umService.updateTicketUser(form.getUsername(),
                "{noop}" + form.getPassword(), form.getFullName(), form.getEmail(),
                form.getAddress(), form.getRoles());
        return "redirect:/ticket";
    }
    @GetMapping("/userinfo/{userName}")
    public ModelAndView editInfoWithId(@PathVariable("userName") String userName, Model model, Form form, Principal principal) {
        TicketUser ticketUser = umService.getTicketUser(userName);
        form.setUsername(ticketUser.getUsername());
        form.setPassword(ticketUser.getPassword().replace("{noop}", ""));
        form.setFullName(ticketUser.getFullName());
        form.setEmail(ticketUser.getEmail());
        form.setAddress(ticketUser.getAddress());
        List<UserRole> userRoleList = ticketUser.getRoles();
        String[] passRole = new String[userRoleList.size()];
        for(int i = 0; i < userRoleList.size(); i++){
            passRole[i] = userRoleList.get(i).getRole();
        }
        form.setRoles(passRole);
        model.addAttribute("ticketUser", form);
        return new ModelAndView("editInfo", "ticketUser", form);
    }
    @PostMapping("/userinfo/{userName}")
    public String editInfoWithId(Form form) throws IOException {
        umService.updateTicketUser(form.getUsername(),
                "{noop}" + form.getPassword(), form.getFullName(), form.getEmail(),
                form.getAddress(), form.getRoles());
        return "redirect:/ticket";
    }

    @GetMapping("/delete/{username}")
    public String deleteTicket(@PathVariable("username") String username) {
        umService.delete(username);
        return "redirect:/user/list";
    }
}