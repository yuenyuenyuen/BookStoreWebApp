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
        <c:out value="${ticket.attachments.name}"/></a><br/>
    <img src="<c:url value='/ticket/${ticketId}/attachment/${ticket.attachments.id}' />" alt="Attachment"
         style="max-width: 500px; max-height: 500px;"><br/>
    <security:authorize access="hasRole('ADMIN')">
        [<a href="<c:url value="/ticket/${ticketId}/delete/${ticket.attachments.id}"/>">Delete</a>]<br/><br/>
    </security:authorize>
</c:if>
Description: <c:out value="${ticket.description}"/></br></br>
Price: <c:out value="${ticket.price}"/></br></br>
Availability - <input type="checkbox" ${ticket.availability ? 'checked' : ''} onclick="return false;"/><br/><br/>
Comment:</br></br>
<c:choose>
    <c:when test="${fn:length(ticket.comments) > 0}">
        <c:forEach var="cm" items="${ticket.comments}">
            User: <c:out value="${cm.name}"/><br/>
            <c:out value="${cm.content}"/><br/>
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value="/ticket/delete/comment/${ticket.id}/${cm.id}"/>">Delete</a>]<br/><br/>
            </security:authorize>
        </c:forEach>
    </c:when>
    <c:otherwise>
        There are no comment.<br/><br/>
    </c:otherwise>
</c:choose>
<security:authorize access="hasAnyRole('ADMIN', 'USER')">
    <form:form method="POST" enctype="multipart/form-data" modelAttribute="commentForm">
        <form:hidden path="name" value="<%=request.getUserPrincipal().getName()%>"/><br/><br/>
        <form:label path="content">Comment</form:label><br/>
        <form:textarea path="content" rows="5" cols="30"/><br/><br/>
        <input type="hidden" name="ticketId" value="${ticketId}"/>
        <input type="submit" value="Add Comment"/>
    </form:form><br/><br/>
</security:authorize>
<security:authorize access="hasRole('ADMIN')">
    [<a href="<c:url value="/ticket/delete/${ticket.id}"/>">Delete</a>]
    &nbsp;&nbsp;
    [<a href="<c:url value='/ticket/${ticket.id}/edit'/>">Edit Book</a>]
    &nbsp;
</security:authorize>

<c:choose>
    <c:when test="${isFavorite}">
        <span>This book is already in your favorites.</span>
        <form action="<c:url value='/favorite/remove/${ticket.id}' />" method="GET">
            <input type="submit" value="Remove from Favorites">
        </form>
    </c:when>
    <c:otherwise>
        <form action="<c:url value='/favorite/${ticket.id}' />" method="POST">
            <input type="submit" value="Add to Favorites">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </c:otherwise>
</c:choose>

<form action="<c:url value='/cart/add/${ticket.id}' />" method="POST">
    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" min="1" value="1">
    <input type="hidden" name="ticketId" value="${ticket.id}">
    <input type="submit" value="Add to Cart">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

[<a href="<c:url value="/ticket/list" />">Back to book list</a>]
</body>
</html>