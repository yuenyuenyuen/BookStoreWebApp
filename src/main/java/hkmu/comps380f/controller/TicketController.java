package hkmu.comps380f.controller;

import hkmu.comps380f.dao.TicketService;
import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.InvalidFileFormatException;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Attachment;
import hkmu.comps380f.model.Comment;
import hkmu.comps380f.model.Ticket;
import hkmu.comps380f.view.DownloadingView;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/ticket")
public class TicketController {
    @Resource
    private TicketService tService;

    public class commentForm{
        private String name;
        private String content;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }
    // Controller methods, Form-backing object, ...
    @GetMapping(value = {"", "/list"})
    public String list(ModelMap model, Principal principal) {
        model.addAttribute("ticketDatabase", tService.getTickets());
        return "list";
    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("add", "ticketForm", new Form());
    }

    public static class Form {
        private String bookName;
        private String author;
        private String description;
        private float price;
        private boolean availability;
        private List<Comment> comments;
        private MultipartFile attachments;

        // Getters and Setters of customerName, subject, body, attachments
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

        public MultipartFile getAttachments() {
            return attachments;
        }

        public void setAttachments(MultipartFile attachments) {
            this.attachments = attachments;
        }
    }

    @PostMapping("/create")
    public View create(@Validated Form form, Principal principal, @RequestParam("attachments") MultipartFile attachments, BindingResult bindingResult) throws IOException, InvalidFileFormatException {
        // Validate the form data
        if (bindingResult.hasErrors()) {
            // Handle validation errors
            return new RedirectView("/create");
        }
        form.setAttachments(attachments);
        long ticketId = tService.createTicket(form.getBookName(),
                form.getAuthor(), form.getDescription(), form.getPrice(),
                form.getAvailability(), form.getAttachments());
        return new RedirectView("/ticket/view/" + ticketId, true);
    }

    @GetMapping("/view/{ticketId}")
    public ModelAndView view(@PathVariable("ticketId") long ticketId, Principal principal,
                       ModelMap model)
            throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        commentForm commentForm = new commentForm();
        model.addAttribute("ticketId", ticketId);
        model.addAttribute("ticket", ticket);
        model.addAttribute("commentForm", commentForm);
        model.addAttribute("availability", ticket.getAvailability());
        return new ModelAndView("view", "commentForm", commentForm);
    }

    @PostMapping("/view/{ticketId}")
    public View addComment(@PathVariable("ticketId") long ticketId, @Validated commentForm form,
                           Principal principal, @RequestParam("name") String name,
                           @RequestParam("content") String content) throws TicketNotFound, InvalidFileFormatException, IOException {

        // Extract the comment from the commentForm

        // Retrieve the ticket from the data store or service
        Ticket ticket = tService.getTicket(ticketId);
        // Add the new comment to the ticket's comment list
        Comment newcomment = new Comment();
        newcomment.setContent(content);
        newcomment.setName(name);
        newcomment.setTicket(ticket);
        List<Comment> newcommentlist = ticket.getComments();
        newcommentlist.add(newcomment);
        // Perform the necessary actions to update the ticket in your data store or service
        tService.addComment(ticketId, newcommentlist);

        // Redirect back to the ticket details page
        return new RedirectView("/ticket/view/" + ticketId, true);
    }



//    @GetMapping("/history/{ticketId}")
//    public ModelAndView history(@PathVariable("ticketId") long ticketId, Principal principal,
//                             ModelMap model)
//            throws TicketNotFound {
//        Ticket ticket = tService.getTicket(ticketId);
//        commentForm commentForm = new commentForm();
//        model.addAttribute("ticketId", ticketId);
//        model.addAttribute("ticket", ticket);
//        model.addAttribute("commentForm", commentForm);
//        model.addAttribute("availability", ticket.getAvailability());
//        return new ModelAndView("history", "commentForm", commentForm);
//    }
    @GetMapping("/history/all")
    public ModelAndView history(Principal principal, ModelMap model) throws TicketNotFound {
        ModelAndView modelAndView = new ModelAndView("history");

        List<Ticket> tickets = tService.getTickets(); // Get all tickets

        model.addAttribute("tickets", tickets);
        model.addAttribute("commentForm", new commentForm());

        return modelAndView;
    }



    @GetMapping("/{id}/edit")
    public ModelAndView edit(@PathVariable("id") long ticketId) throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        Form form = new Form();
        form.setBookName(ticket.getBookName());
        form.setAuthor(ticket.getAuthor());
        form.setDescription(ticket.getDescription());
        form.setPrice(ticket.getPrice());
        form.setAvailability(ticket.getAvailability());
        return new ModelAndView("edit", "ticketForm", form);
    }

    @PostMapping("/{id}/edit")
    public View update(@PathVariable("id") long ticketId, @Validated Form form, @RequestParam("attachments") MultipartFile attachments, BindingResult bindingResult) throws IOException, InvalidFileFormatException, TicketNotFound {
        // Validate the form data
        if (bindingResult.hasErrors()) {
            // Handle validation errors
            return new RedirectView("/{id}/edit");
        }
        Ticket ticket = tService.getTicket(ticketId);
        form.setAttachments(attachments);
        tService.updateTicket(ticketId, form.getBookName(),
                form.getAuthor(), form.getDescription(), form.getPrice(),
                form.getAvailability(), ticket.getComments(), form.getAttachments());
        return new RedirectView("/ticket/view/" + ticketId, true);
    }

    @GetMapping("/delete/comment/{ticketId}/{commentId}")
    public View deleteComment(@PathVariable("ticketId") long ticketId, @PathVariable("commentId") long commentId) throws TicketNotFound, AttachmentNotFound {

        tService.deleteComment(ticketId, commentId);

        return new RedirectView("/ticket/view/" + ticketId, true);
    }

    @GetMapping("/{ticketId}/attachment/{attachment:.+}")
    public View download(@PathVariable("ticketId") long ticketId,
                         @PathVariable("attachment") UUID attachmentId)
            throws TicketNotFound, AttachmentNotFound {
        Attachment attachment = tService.getAttachment(ticketId, attachmentId);
        return new DownloadingView(attachment.getName(),
                attachment.getMimeContentType(), attachment.getContents());
    }

    @GetMapping("/delete/{ticketId}")
    public String deleteTicket(@PathVariable("ticketId") long ticketId)
            throws TicketNotFound {
        tService.delete(ticketId);
        return "redirect:/ticket/list";
    }

    @GetMapping("/{ticketId}/delete/{attachment:.+}")
    public String deleteAttachment(@PathVariable("ticketId") long ticketId,
                                   @PathVariable("attachment") UUID attachmentId)
            throws TicketNotFound, AttachmentNotFound {
        tService.deleteAttachment(ticketId, attachmentId);
        return "redirect:/ticket/view/" + ticketId;
    }

    @ExceptionHandler({TicketNotFound.class, AttachmentNotFound.class, InvalidFileFormatException.class})
    public ModelAndView error(Exception e) {
        return new ModelAndView("error", "message", e.getMessage());
    }
}
