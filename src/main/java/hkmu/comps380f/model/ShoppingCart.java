package hkmu.comps380f.model;

import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
    private Map<Long, Integer> items; // Map of Ticket ID to Quantity

    public ShoppingCart() {
        this.items = new HashMap<>();
    }

    public Map<Long, Integer> getItems() {
        return items;
    }

    public void setItems(Map<Long, Integer> items) {
        this.items = items;
    }

    public void addItem(long ticketId, Integer quantity) {
        int existingQuantity = items.getOrDefault(ticketId, 0);
        items.put(ticketId, existingQuantity + quantity);
    }

    public void removeItem(long ticketId) {
        items.remove(ticketId);
    }

    public void updateQuantity(long ticketId, int quantity) {
        if (quantity <= 0) {
            items.remove(ticketId);
        } else {
            items.put(ticketId, quantity);
        }
    }

    public void clearCart() {
        items.clear();
    }

    public int getTotalItems() {
        return items.size();
    }
}
