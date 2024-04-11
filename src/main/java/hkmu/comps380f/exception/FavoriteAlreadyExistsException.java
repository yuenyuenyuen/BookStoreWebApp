package hkmu.comps380f.exception;

public class FavoriteAlreadyExistsException extends Exception {

    public FavoriteAlreadyExistsException() {
        super();
    }

    public FavoriteAlreadyExistsException(String message) {
        super(message);
    }

    public FavoriteAlreadyExistsException(String message, Throwable cause) {
        super(message, cause);
    }

    public FavoriteAlreadyExistsException(Throwable cause) {
        super(cause);
    }
}
