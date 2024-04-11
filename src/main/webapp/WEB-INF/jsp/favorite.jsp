<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Favorite Books</title>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h2>Favorite Books</h2>
    <c:choose>
        <c:when test="${empty favoriteTickets}">
            <p><i>No favorite books added yet.</i></p>
        </c:when>
        <c:otherwise>
            <ul class="list-group">
                <c:forEach items="${favoriteTickets}" var="ticket">
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col-md-8">
                                <a href="<c:url value='/ticket/view/${ticket.id}' />" class="text-decoration-none">
                                        ${ticket.bookName} by ${ticket.author}
                                </a>
                            </div>
                            <div class="col-md-4 text-right">
                                <form action="<c:url value='/favorite/remove/${ticket.id}' />" method="GET">
                                    <input type="submit" value="Remove from Favorites" class="btn btn-danger">
                                </form>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
    <br/>
</div>
</body>
</html>
