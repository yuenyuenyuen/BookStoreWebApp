<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store User Management</title>
    <%@ include file="meta.jsp" %>
</head>
<body>
<div class="container">
    <h2>Users</h2>
    <a href="<c:url value="/user/create" />" class="btn btn-success">Create a User</a><br/><br/>
    <c:choose>
        <c:when test="${fn:length(ticketUsers) == 0}">
            <p><i>There are no users in the system.</i></p>
        </c:when>
        <c:otherwise>
            <table class="table">
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Roles</th>
                    <th>Action</th>
                </tr>
                <c:forEach items="${ticketUsers}" var="user">
                    <tr>
                        <td>${user.username}</td>
                        <td>${fn:substringAfter(user.password, '{noop}')}</td>
                        <td>
                            <c:forEach items="${user.roles}" var="role" varStatus="status">
                                <c:if test="${!status.first}">, </c:if>
                                ${role.role}
                            </c:forEach>
                        </td>
                        <td>
                            [<a href="<c:url value="user/userinfo/${user.username}"/>">Edit</a>]
                        </td>
                        <td>
                            [<a href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>