<!DOCTYPE html>
<html>
<head>
    <title>Book Store</title>
</head>
<body>
<security:authorize access="!hasAnyRole('ADMIN', 'USER')">
    [<a href="<c:url value="/user/register" />">Register</a>]
    &nbsp;
    [<a href="<c:url value="/login" />">Login</a>]
</security:authorize>
<security:authorize access="hasAnyRole('ADMIN', 'USER')">
<c:url var="logoutUrl" value="/logout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
</security:authorize>
<h2>Book Store</h2>
<security:authorize access="hasRole('ADMIN')">
    <a href="<c:url value="/user" />">Manage User Accounts</a><br/><br/>
</security:authorize>
<security:authorize access="hasRole('ADMIN')">
<a href="<c:url value="/ticket/create" />">Create a Ticket</a><br/><br/>
</security:authorize>
<c:choose>
    <c:when test="${fn:length(ticketDatabase) == 0}">
        <i>There are no book in the store.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${ticketDatabase}" var="entry">
            <c:if test="${entry.attachments != null}">
            <img src="<c:url value='/ticket/${entry.id}/attachment/${entry.attachments.id}' />" alt="Attachment" style="max-width: 200px; max-height: 200px;"><br/>
            </c:if>
            Book ${entry.id}:
            <a href="<c:url value="/ticket/view/${entry.id}" />">
                <c:out value="${entry.bookName}"/></a>
            (author: <c:out value="${entry.author}"/>)
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value='/ticket/${entry.id}/edit' />">Edit</a>]
            </security:authorize>
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value="/ticket/delete/${entry.id}" />">Delete</a>]
            </security:authorize>
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>
