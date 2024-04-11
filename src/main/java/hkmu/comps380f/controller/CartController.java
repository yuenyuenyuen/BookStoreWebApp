package hkmu.comps380f.controller;

import hkmu.comps380f.dao.TicketService;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Cart;
import hkmu.comps380f.model.Ticket;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Resource
    private TicketService tService;

    @Autowired
    private TicketService ticketService; // Autowire TicketService

    @GetMapping("/view")
    public ModelAndView viewCart(HttpSession session,ModelMap model) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }
        model.addAttribute("cart", cart);
        model.addAttribute("ticketService", ticketService);
        return new ModelAndView("cart", model);
    }

    @PostMapping("/add/{ticketId}")
    public String addToCart(@PathVariable long ticketId, @RequestParam(value = "quantity", defaultValue = "1") int quantity, HttpSession session) throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        if (ticket != null) {
            Cart cart= (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            cart.addItem(ticketId, quantity);
            session.setAttribute("cart", cart);
        }
        return "redirect:/cart/view";
    }

    @GetMapping("/remove/{ticketId}")
    public String removeFromCart(@PathVariable long ticketId, HttpSession session) throws TicketNotFound {
        Cart cart= (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.removeItem(ticketId);
        }
        return "redirect:/cart/view";
    }

    @GetMapping("/update/{ticketId}")
    public String updateQuantity(@PathVariable("ticketId") long ticketId, @RequestParam("quantity") int quantity, HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.updateQuantity(ticketId, quantity);
        }
        return "redirect:/cart/view";
    }

    @GetMapping("/clear")
    public String clearCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.clearCart();
        }
        return "redirect:/cart/view";
    }
}
