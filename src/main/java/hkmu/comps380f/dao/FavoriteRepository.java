package hkmu.comps380f.dao;

import hkmu.comps380f.model.Favorite;
import hkmu.comps380f.model.Ticket;
import hkmu.comps380f.model.TicketUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface FavoriteRepository extends JpaRepository<Favorite, Long>{
    List<Favorite> findByUser(TicketUser user);

    Favorite findByTicketAndUser(Ticket ticket, TicketUser user);
}
