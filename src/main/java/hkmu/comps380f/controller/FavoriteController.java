package hkmu.comps380f.controller;

import hkmu.comps380f.dao.FavoriteService;
import hkmu.comps380f.dao.TicketService;
import hkmu.comps380f.dao.TicketUserService;
import hkmu.comps380f.exception.FavoriteAlreadyExistsException;
import hkmu.comps380f.exception.FavoriteNotFound;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Favorite;
import hkmu.comps380f.model.Ticket;
import hkmu.comps380f.model.TicketUser;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
    @Resource
    private TicketService tService;
    @Resource
    private TicketUserService tuService;
    @Resource
    private FavoriteService favService;

    @PostMapping("/{ticketId}")
    public String addFavorite(@PathVariable("ticketId") long ticketId, Principal principal) throws TicketNotFound, FavoriteAlreadyExistsException {
        Ticket ticket = tService.getTicket(ticketId);
        TicketUser user = tuService.getUserByUsername(principal.getName());

        Favorite favorite = new Favorite();
        favorite.setTicket(ticket);
        favorite.setUser(user);
        favService.addFavorite(favorite);
        return "redirect:/ticket/view/{ticketId}";
    }

    @GetMapping("/all")
    public ModelAndView favorite(Principal principal, ModelMap model) throws TicketNotFound {
        ModelAndView modelAndView = new ModelAndView("favorite");

        TicketUser user = tuService.getUserByUsername(principal.getName());
        List<Ticket> favoriteTickets = favService.getFavorites(user); // Get favorite tickets
        model.addAttribute("favoriteTickets", favoriteTickets);
        return modelAndView;
    }

    @GetMapping("/remove/{ticketId}")
    public String removeFavorite(@PathVariable("ticketId") long ticketId, Principal principal) throws FavoriteNotFound, TicketNotFound {
        TicketUser user = tuService.getUserByUsername(principal.getName());
        favService.removeFavorite(ticketId, user);
        return "redirect:/ticket/view/{ticketId}";
    }
}
