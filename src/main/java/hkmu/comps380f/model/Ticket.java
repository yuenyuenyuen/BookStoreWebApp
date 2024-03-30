package hkmu.comps380f.model;

import jakarta.persistence.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Column(name = "name")
    private String bookName;
    private String author;
    private String description;
    private float price;
    private boolean availability = false;

    @OneToMany(mappedBy = "ticket", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.SUBSELECT)
    private List<Comment> comments = new ArrayList<>();

    @OneToOne(mappedBy = "ticket", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    private Attachment attachments;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {return description;}

    public void setDescription(String description) {this.description = description;}

    public float getPrice() {return price;}

    public void setPrice(float price) {this.price = price;}

    public boolean getAvailability() {return availability;}

    public void setAvailability(boolean availability) {this.availability = availability;}

    public List<Comment> getComments() {return comments;}

    public void setComments(List<Comment> comments) {this.comments = comments;}

    public void deleteComment(Comment comment) {
        comments.remove(comment);
        comment.setTicket(null);
    }

    public Attachment getAttachments() {return attachments;}

    public void setAttachments(Attachment attachments) {
        if (this.attachments != null) {
            deleteAttachment(this.attachments);
        }

        // Set the new attachment
        this.attachments = attachments;
        if (attachments != null) {
            attachments.setTicket(this);
        }
    }

    public void deleteAttachment(Attachment attachment) {
        if (this.attachments != null && this.attachments.equals(attachment)) {
            this.attachments = null;
            attachment.setTicket(null);
        }
    }
}
