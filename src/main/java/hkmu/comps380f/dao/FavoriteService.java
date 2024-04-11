package hkmu.comps380f.dao;

import hkmu.comps380f.exception.FavoriteAlreadyExistsException;
import hkmu.comps380f.exception.FavoriteNotFound;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Favorite;
import hkmu.comps380f.model.Ticket;
import hkmu.comps380f.model.TicketUser;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class FavoriteService {
    @Resource
    private FavoriteRepository favRepo;
    @Resource
    private TicketService tService;
    @Resource
    private TicketUserRepository ticketUserRepo;

    public boolean isFavorite(long ticketId, String userId) throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        TicketUser user = ticketUserRepo.findById(userId).orElse(null);
        if (user == null) {
            return false;
        }
        Favorite favorite = favRepo.findByTicketAndUser(ticket, user);
        return favorite != null;
    }

    @Transactional
    public void addFavorite(Favorite favorite) throws FavoriteAlreadyExistsException {
        Ticket ticket = favorite.getTicket();
        TicketUser user = favorite.getUser();

        Favorite existingFavorite = favRepo.findByTicketAndUser(ticket, user);
        if (existingFavorite != null) {
            throw new FavoriteAlreadyExistsException("User has already favorited this ticket");
        }

        favRepo.save(favorite);
    }

    @Transactional
    public void removeFavorite(long ticketId, TicketUser user) throws FavoriteNotFound, TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        if (ticket == null) {
            throw new TicketNotFound(ticketId);
        }
        Favorite favorite = favRepo.findByTicketAndUser(ticket, user);
        if (favorite == null) {
            throw new FavoriteNotFound();
        }
        favRepo.delete(favorite);
    }

    @Transactional
    public List<Ticket> getFavorites(TicketUser user) {
        List<Favorite> favorites = favRepo.findByUser(user);
        List<Ticket> tickets = new ArrayList<>();
        for (Favorite favorite : favorites) {
            tickets.add(favorite.getTicket());
        }
        return tickets;
    }
}
