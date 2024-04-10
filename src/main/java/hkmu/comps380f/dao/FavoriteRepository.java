package hkmu.comps380f.dao;

import hkmu.comps380f.model.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
public interface FavoriteRepository extends JpaRepository<Favorite, Long>{
}
