<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
</head>
<br>
<%--<h2>Book #${ticketId}: <c:out value="${ticket.author}"/></h2>--%>
<h2>Book Name - <c:out value="${ticket.bookName}"/></h2>
[<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]<br/><br/>
Author - <c:out value="${ticket.author}"/><br/><br/>
<c:if test="${ticket.attachments != null}">
    Book cover:
    <a href="<c:url value="/ticket/${ticketId}/attachment/${ticket.attachments.id}" />">
        <c:out value="${ticket.attachments.name}" /></a><br/>
    <img src="<c:url value='/ticket/${ticketId}/attachment/${ticket.attachments.id}' />" alt="Attachment" style="max-width: 500px; max-height: 500px;"><br/>
    [<a href="<c:url value="/ticket/${ticketId}/delete/${ticket.attachments.id}" />">Delete</a>]<br/><br/>
</c:if>
Description: <c:out value="${ticket.description}"/></br></br>
Price: <c:out value="${ticket.price}"/></br></br>
Availability - <input type="checkbox" ${ticket.availability ? 'checked' : ''} onclick="return false;" /><br/><br/>
<c:out value="${ticket.comments}"/><br/><br/>
<a href="<c:url value="/ticket" />">Back to book list</a>
</body>
</html>