<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Shopping Cart</title>
</head>
<body>
<div class="container">
    <h2>Shopping Cart</h2>
    <c:if test="${cart.totalItems == 0}">
        <div class="alert alert-info" role="alert">
            Your cart is empty. Please add items to proceed to checkout.
        </div>
    </c:if>
    <c:if test="${cart.totalItems > 0}">
        <table class="table table-bordered">
            <thead class="thead-dark">
            <tr>
                <th>Book Name</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${cart.items}" var="entry">
                <c:set var="quantity" value="${entry.value}"/>
                <c:set var="ticket" value="${ticketService.getTicket(entry.key)}"/>
                <tr>
                    <td>${ticket.bookName}</td>
                    <td>${ticket.author}</td>
                    <td>${ticket.price}</td>
                    <td>
                        <form action="<c:url value='/cart/update/${entry.key}' />" method="GET">
                            <input type="number" name="quantity" value="${entry.value}" min="0" class="form-control">
                            <input type="submit" value="Update" class="btn btn-primary">
                        </form>
                    </td>
                    <td>${ticket.price * quantity}</td>
                    <td>
                        <a href="<c:url value='/cart/remove/${ticket.id}' />" class="btn btn-danger">Remove</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <form action="<c:url value='/cart/clear' />" method="get">
            <input type="submit" value="Clear Cart" class="btn btn-warning">
        </form>
        <a href="<c:url value='/checkout' />" class="btn btn-success">Checkout</a>
    </c:if>
    <a href="<c:url value='/ticket/list' />" class="btn btn-info">Continue Shopping</a>
</div>
</body>
</html>
