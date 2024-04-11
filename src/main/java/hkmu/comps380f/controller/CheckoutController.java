package hkmu.comps380f.controller;

import hkmu.comps380f.dao.CartService;
import hkmu.comps380f.dao.TicketService;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Cart;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {
    @Resource
    private TicketService ticketService;
    @Resource
    private CartService cartService;

    @GetMapping("")
    public ModelAndView checkout(HttpSession session, ModelMap model) throws TicketNotFound {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalItems() == 0) {
            return new ModelAndView("redirect:/cart/view");
        }

        // Add the cart and any additional data to the model
        model.addAttribute("cart", cart);
        model.addAttribute("ticketService", ticketService);
        model.addAttribute("totalPrice", cartService.getTotalPrice(cart.getItems()));

        // Return the checkout view
        return new ModelAndView("checkout", model);
    }

    @GetMapping("/process")
    public String processCheckout(HttpSession session) {
        // Remove all cart items from the session
        session.removeAttribute("cart");

        // Redirect to the home page or any other desired page
        return "redirect:/";
    }
}
