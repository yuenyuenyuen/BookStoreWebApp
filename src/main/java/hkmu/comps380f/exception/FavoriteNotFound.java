package hkmu.comps380f.exception;

public class FavoriteNotFound extends Exception {
    public FavoriteNotFound() {
        super("Favorite not found.");
    }

    public FavoriteNotFound(long favoriteId) {
        super("Favorite with ID " + favoriteId + " not found.");
    }
}
