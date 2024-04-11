package hkmu.comps380f.dao;

import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Ticket;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class CartService {
    @Resource
    private TicketService ticketService;

    public double getTotalPrice(Map<Long, Integer> items) throws TicketNotFound {
        double totalPrice = 0.0;
        for (Map.Entry<Long, Integer> entry : items.entrySet()) {
            long ticketId = entry.getKey();
            int quantity = entry.getValue();
            Ticket ticket = ticketService.getTicket(ticketId);
            if (ticket != null) {
                double price = ticket.getPrice() * quantity;
                totalPrice += price;
            }
        }
        return totalPrice;
    }
}
