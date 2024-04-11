<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
    <%@include file="meta.jsp" %>
</head>
<body>
<div class="container">
    <h2 class="mt-3 mb-4">Book Store</h2>

    <!-- Additional Links -->
    <div class="mt-4">
        <a href="<c:url value="/ticket/history/all" />" class="btn btn-secondary">View Comments History</a>
    </div>
    <security:authorize access="hasRole('ADMIN')">
        <div class="mt-4">
            <a href="<c:url value="/user" />" class="btn btn-primary">Manage User Accounts</a>
        </div>
        <div class="mt-4">
            <a href="<c:url value="/ticket/create" />" class="btn btn-success">Create a Book</a>
        </div>
    </security:authorize>

    <!-- Book Listing -->
    <div class="mt-4">
        <c:choose>
            <c:when test="${fn:length(ticketDatabase) == 0}">
                <p class="text-muted">There are no books in the store.</p>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach items="${ticketDatabase}" var="entry">
                        <div class="col-md-4 mt-3">
                            <div class="card">
                                <div class="card-body">
                                    <c:if test="${entry.attachments != null}">
                                        <img src="<c:url value='/ticket/${entry.id}/attachment/${entry.attachments.id}' />"
                                             class="card-img-top" alt="Attachment">
                                    </c:if>
                                    <h5 class="card-title">
                                        <a href="<c:url value="/ticket/view/${entry.id}" />"
                                           class="text-decoration-none">
                                            <c:out value="${entry.bookName}"/>
                                        </a>
                                    </h5>
                                    <p class="card-text">Author: <c:out value="${entry.author}"/></p>
                                    <security:authorize access="hasRole('ADMIN')">
                                        <a href="<c:url value='/ticket/${entry.id}/edit'/>"
                                           class="btn btn-primary me-2">Edit</a>
                                        <a href="<c:url value="/ticket/delete/${entry.id}"/>" class="btn btn-danger">Delete</a>
                                    </security:authorize>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <!-- End Book Listing -->
</div>
</body>
</html>
