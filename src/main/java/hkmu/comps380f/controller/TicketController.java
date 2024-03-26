package hkmu.comps380f.controller;

import hkmu.comps380f.dao.TicketService;
import hkmu.comps380f.exception.AttachmentNotFound;
import hkmu.comps380f.exception.InvalidFileFormatException;
import hkmu.comps380f.exception.TicketNotFound;
import hkmu.comps380f.model.Attachment;
import hkmu.comps380f.model.Ticket;
import hkmu.comps380f.view.DownloadingView;
import jakarta.annotation.Resource;
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
import java.util.UUID;

@Controller
@RequestMapping("/ticket")
public class TicketController {
    @Resource
    private TicketService tService;

    // Controller methods, Form-backing object, ...
    @GetMapping(value = {"", "/list"})
    public String list(ModelMap model) {
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

        public MultipartFile getAttachments() {
            return attachments;
        }

        public void setAttachments(MultipartFile attachments) {
            this.attachments = attachments;
        }
    }

    @PostMapping("/create")
    public View create(@Validated Form form, @RequestParam("attachments") MultipartFile attachments, BindingResult bindingResult) throws IOException, InvalidFileFormatException {
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
    public String view(@PathVariable("ticketId") long ticketId,
                       ModelMap model)
            throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        model.addAttribute("ticketId", ticketId);
        model.addAttribute("ticket", ticket);
        model.addAttribute("availability", ticket.getAvailability());
        return "view";
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
