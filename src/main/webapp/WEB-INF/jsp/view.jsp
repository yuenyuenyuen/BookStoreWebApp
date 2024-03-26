<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
</head>
<body>
<h2>Book #${ticketId}: <c:out value="${ticket.author}"/></h2>
[<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]<br/><br/>
<i>Book Name - <c:out value="${ticket.bookName}"/></i><br/><br/>
<c:out value="${ticket.comments}"/><br/><br/>
<c:if test="${ticket.attachments != null}">
    Attachments:
    <a href="<c:url value="/ticket/${ticketId}/attachment/${ticket.attachments.id}" />">
        <c:out value="${ticket.attachments.name}" /></a><br/>
    <img src="<c:url value='/ticket/${ticketId}/attachment/${ticket.attachments.id}' />" alt="Attachment" style="max-width: 500px; max-height: 500px;"><br/>
    [<a href="<c:url value="/ticket/${ticketId}/delete/${ticket.attachments.id}" />">Delete</a>]<br/><br/>
</c:if>
<a href="<c:url value="/ticket" />">Back to book list</a>
</body>
</html>
