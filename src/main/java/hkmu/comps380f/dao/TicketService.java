package hkmu.comps380f.dao;

import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.InvalidFileFormatException;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Attachment;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.Ticket;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class TicketService {
    @Resource
    private TicketRepository tRepo;
    @Resource
    private AttachmentRepository aRepo;
    @Transactional
    public List<Ticket> getTickets() {
        return tRepo.findAll();
    }
    @Transactional
    public Ticket getTicket(long id)
            throws TicketNotFound {
        Ticket ticket = tRepo.findById(id).orElse(null);
        if (ticket == null) {
            throw new TicketNotFound(id);
        }
        return ticket;
    }
    @Transactional
    public Attachment getAttachment(long ticketId, UUID attachmentId)
            throws TicketNotFound, AttachmentNotFound {
        Ticket ticket = tRepo.findById(ticketId).orElse(null);
        if (ticket == null) {
            throw new TicketNotFound(ticketId);
        }
        Attachment attachment = aRepo.findById(attachmentId).orElse(null);
        if (attachment == null) {
            throw new AttachmentNotFound(attachmentId);
        }
        return attachment;
    }
    @Transactional(rollbackFor = TicketNotFound.class)
    public void delete(long id) throws TicketNotFound {
        Ticket deletedTicket = tRepo.findById(id).orElse(null);
        if (deletedTicket == null) {
            throw new TicketNotFound(id);
        }
        tRepo.delete(deletedTicket);
    }
    @Transactional(rollbackFor = AttachmentNotFound.class)
    public void deleteAttachment(long ticketId, UUID attachmentId)
            throws TicketNotFound, AttachmentNotFound {
        Ticket ticket = tRepo.findById(ticketId).orElse(null);
        if (ticket == null) {
            throw new TicketNotFound(ticketId);
        }
        Attachment attachment = ticket.getAttachments();
            if (attachment.getId().equals(attachmentId)) {
                ticket.deleteAttachment(attachment);
                tRepo.save(ticket);
                return;
            }
        throw new AttachmentNotFound(attachmentId);
    }
    @Transactional
    public long createTicket(String bookName, String author, String description, Float price, boolean availability, MultipartFile attachments)
            throws IOException, InvalidFileFormatException {
        if (attachments != null && !attachments.isEmpty()) {
            String contentType = attachments.getContentType();
            if (contentType == null || (!contentType.equals("image/jpeg") && !contentType.equals("image/png"))) {
                throw new InvalidFileFormatException("Only JPG and PNG files are allowed.");
            }
        }
        Ticket ticket = new Ticket();
        ticket.setBookName(bookName);
        ticket.setAuthor(author);
        ticket.setDescription(description);
        ticket.setPrice(price);
        ticket.setAvailability(availability);
        ticket.setComments(new ArrayList<>());
        if (attachments != null && !attachments.isEmpty()) {
            Attachment attachment = new Attachment();
            attachment.setName(attachments.getOriginalFilename());
            attachment.setContents(attachments.getBytes());
            attachment.setTicket(ticket);
            ticket.setAttachments(attachment);
        }
        Ticket savedTicket = tRepo.save(ticket);
        return savedTicket.getId();
    }

    @Transactional
    public void updateTicket(long ticketId, String bookName, String author, String description, Float price, boolean availability, List<Comment> comment, MultipartFile attachments)
            throws IOException, InvalidFileFormatException, TicketNotFound {
        Ticket ticket = tRepo.findById(ticketId)
                .orElseThrow(() -> new TicketNotFound(ticketId));

        if (attachments != null && !attachments.isEmpty()) {
            String contentType = attachments.getContentType();
            if (contentType == null || (!contentType.equals("image/jpeg") && !contentType.equals("image/png"))) {
                throw new InvalidFileFormatException("Only JPG and PNG files are allowed.");
            }
        }

        ticket.setBookName(bookName);
        ticket.setAuthor(author);
        ticket.setDescription(description);
        ticket.setPrice(price);
        ticket.setAvailability(availability);
        ticket.setComments(comment);

        if (attachments != null && !attachments.isEmpty()) {
            Attachment attachment = new Attachment();
            attachment.setName(attachments.getOriginalFilename());
            attachment.setContents(attachments.getBytes());
            attachment.setTicket(ticket);
            ticket.setAttachments(attachment);
        }

        tRepo.save(ticket);
    }

    @Transactional
    public void addComment(long ticketId, List<Comment> comment)
            throws IOException, InvalidFileFormatException, TicketNotFound {
        Ticket ticket = tRepo.findById(ticketId)
                .orElseThrow(() -> new TicketNotFound(ticketId));

        ticket.setComments(comment);

        tRepo.save(ticket);
    }
    @Transactional
    public void deleteComment(long ticketId, long commentId)
            throws TicketNotFound, AttachmentNotFound {
        Ticket ticket = tRepo.findById(ticketId).orElse(null);
        if (ticket == null) {
            throw new TicketNotFound(ticketId);
        }
        for (Comment comment : ticket.getComments()) {
            if (comment.getId() == commentId) {
                ticket.deleteComment(comment);
                tRepo.save(ticket);
                return;
            }
        }
    }
    @Transactional
    public void addFavorite(Favorite favorite) {
        favoriteRepository.save(favorite);
    }

    @Transactional
    public void removeFavorite(long favoriteId) throws FavoriteNotFound {
        Favorite favorite = favoriteRepository.findById(favoriteId).orElse(null);
        if (favorite == null) {
            throw new FavoriteNotFound(favoriteId);
        }
        favoriteRepository.delete(favorite);
    }

    @Transactional
    public List<Ticket> getFavoriteTickets() {
        List<Favorite> favorites = favoriteRepository.findAll();
        List<Ticket> favoriteTickets = new ArrayList<>();
        for (Favorite favorite : favorites) {
            favoriteTickets.add(favorite.getTicket());
        }
        return favoriteTickets;
    }
}
