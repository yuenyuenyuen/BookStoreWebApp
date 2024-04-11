<!DOCTYPE html>
<html>
<head>
    <title>Favorite Books</title>
</head>
<body>
<h2>Favorite Books</h2>
<c:choose>
    <c:when test="${empty favoriteTickets}">
        <i>No favorite books added yet.</i>
    </c:when>
    <c:otherwise>
        <ul>
            <c:forEach items="${favoriteTickets}" var="ticket">
                <li>${ticket.bookName} by ${ticket.author}
                    <form action="<c:url value='/favorite/remove/${ticket.id}' />" method="GET">
                        <input type="submit" value="Remove from Favorites">
                    </form>
                </li>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>
<br/>
<a href="<c:url value='/ticket' />">Return to the ticket list</a>
</body>
</html>
