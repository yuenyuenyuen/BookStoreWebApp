<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
</head>
<br>
<%--<h2>Book #${ticketId}: <c:out value="${ticket.author}"/></h2>--%>
<h2>Book Name - <c:out value="${ticket.bookName}"/></h2>
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
Comment:</br></br>
<c:choose>
<c:when test="${fn:length(ticket.comments) > 0}">
<c:forEach var="cm" items="${ticket.comments}">
User: <c:out value="${cm.name}"/><br/>
<c:out value="${cm.content}"/><br/><br/>
</c:forEach>
</c:when>
<c:otherwise>
    There are no comment.<br/><br/>
</c:otherwise>
</c:choose>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="commentForm">
    <form:label path="name">User Name</form:label><br/>
    <form:input type="text" path="name"/><br/><br/>
    <form:label path="content">Comment</form:label><br/>
    <form:textarea path="content" rows="5" cols="30"/><br/><br/>
    <input type="hidden" name="ticketId" value="${ticketId}"/>
    <input type="submit" value="Add Comment"/>
</form:form><br/><br/>

[<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
&nbsp;&nbsp;
[<a href="<c:url value='/ticket/${ticket.id}/edit' />">Edit Book</a>]
&nbsp;&nbsp;
[<a href="<c:url value="/ticket" />">Back to book list</a>]
</body>
</html>