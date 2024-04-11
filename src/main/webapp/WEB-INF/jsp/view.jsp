<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Details</title>
    <%@ include file="meta.jsp" %>
</head>
<br>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-8">
            <h2>Book Details</h2>

            <div class="card mb-4">
                <div class="card-body">
                    <h4 class="card-title">Book Name - <c:out value="${ticket.bookName}"/></h4>
                    <p class="card-text">Author - <c:out value="${ticket.author}"/></p>
                    <c:if test="${ticket.attachments != null}">
                        <p class="card-text">Book Cover:
                            <a href="<c:url value='/ticket/${ticketId}/attachment/${ticket.attachments.id}' />">
                                <c:out value="${ticket.attachments.name}"/>
                            </a>
                        </p>
                        <img src="<c:url value='/ticket/${ticketId}/attachment/${ticket.attachments.id}' />"
                             alt="Attachment"
                             class="img-fluid mb-2" style="max-width: 100%;"/>
                        <security:authorize access="hasRole('ADMIN')">
                            <p class="card-text">
                                [<a href="<c:url value='/ticket/${ticketId}/delete/${ticket.attachments.id}'/>">Delete</a>]
                            </p>
                        </security:authorize>
                    </c:if>

                    <p class="card-text">Description: <c:out value="${ticket.description}"/></p>
                    <p class="card-text">Price: <c:out value="${ticket.price}"/></p>
                    <p class="card-text">Availability - <input type="checkbox" ${ticket.availability ? 'checked' : ''}
                                                               onclick="return false;"/></p>
                    <p class="card-text">Comments:</p>

                    <c:choose>
                        <c:when test="${fn:length(ticket.comments) > 0}">
                            <ul>
                                <c:forEach var="cm" items="${ticket.comments}">
                                    <li>User: <c:out value="${cm.name}"/></li>
                                    <li><c:out value="${cm.content}"/></li>
                                    <security:authorize access="hasRole('ADMIN')">
                                        [<a href="<c:url value='/ticket/delete/comment/${ticket.id}/${cm.id}'/>">Delete</a>]
                                    </security:authorize>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p>There are no comments.</p>
                        </c:otherwise>
                    </c:choose>

                    <security:authorize access="hasAnyRole('ADMIN', 'USER')">
                        <form:form method="POST" enctype="multipart/form-data" modelAttribute="commentForm">
                            <form:hidden path="name" value="<%=request.getUserPrincipal().getName() %>"/>
                            <form:label path="content">Comment</form:label><br/>
                            <form:textarea path="content" rows="5" cols="30" class="form-control mb-2"/><br/><br/>
                            <input type="hidden" name="ticketId" value="${ticketId}"/>
                            <input type="submit" value="Add Comment" class="btn btn-primary"/>
                        </form:form>
                    </security:authorize>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <h4>Actions</h4>
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value="/ticket/delete/${ticket.id}"/>">Delete</a>]
                &nbsp;&nbsp;
                [<a href="<c:url value='/ticket/${ticket.id}/edit'/>">Edit Book</a>]
            </security:authorize>

            <security:authorize access="hasAnyRole('ADMIN', 'USER')">
                <c:choose>
                    <c:when test="${isFavorite}">
                        <form action="<c:url value='/favorite/remove/${ticket.id}' />" method="GET">
                            <input type="submit" value="Remove from Favorites" class="btn btn-danger mb-2"/>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="<c:url value='/favorite/${ticket.id}' />" method="POST">
                            <input type="submit" value="Add to Favorites" class="btn btn-success mb-2"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </c:otherwise>
                </c:choose>

                <form action="<c:url value='/cart/add/${ticket.id}' />" method="POST">
                    <div class="input-group mb-3">
                        <label for="quantity" class="input-group-text">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" min="1" value="1"/>
                    </div>
                    <input type="hidden" name="ticketId" value="${ticket.id}"/>
                    <input type="submit" value="Add to Cart" class="btn btn-primary  mb-2"/>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </security:authorize>
        </div>
    </div>
</div>
</body>
</html>