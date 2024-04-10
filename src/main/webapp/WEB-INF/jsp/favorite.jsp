<!DOCTYPE html>
<html>
<head>
    <title>Favorite Books</title>
</head>
<body>
<h2>Favorite Books</h2>
<c:choose>
    <c:when test="${empty favorites}">
        <i>No favorite books added yet.</i>
    </c:when>
    <c:otherwise>
        <ul>
            <c:forEach items="${favorites}" var="ticket">
                <li>${ticket.bookName} by ${ticket.author}</li>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>
<br/>
<a href="<c:url value='/ticket' />">Return to the ticket list</a>
</body>
</html>
