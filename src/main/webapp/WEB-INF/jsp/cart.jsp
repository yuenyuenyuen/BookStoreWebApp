<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shopping Cart</title>
</head>
<body>
<h2>Shopping Cart</h2>
<c:if test="${cart.totalItems ==0}">
    <p>Your cart is empty. Please add items to proceed to checkout.</p>
</c:if>
<c:if test="${cart.totalItems > 0}">
    <table border="1">
        <tr>
            <th>Book Name</th>
            <th>Author</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Action</th>
        </tr>
        <c:forEach items="${cart.items}" var="entry">
            <c:set var="quantity" value="${entry.value}"/>
            <c:set var="ticket" value="${ticketService.getTicket(entry.key)}"/>
            <tr>
                <td>${ticket.bookName}</td>
                <td>${ticket.author}</td>
                <td>${ticket.price}</td>
                <td>
                    <form action="<c:url value='/cart/update/${entry.key}' />" method="GET">
                        <input type="number" name="quantity" value="${entry.value}" min="0">
                        <input type="submit" value="Update">
                    </form>
                </td>
                <td>${ticket.price * quantity}</td>
                <td>
                    <a href="<c:url value='/cart/remove/${ticket.id}' />">Remove</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <form action="<c:url value='/cart/clear' />" method="get">
        <input type="submit" value="Clear Cart">
    </form>
    <a href="<c:url value='/checkout' />">Checkout</a>
</c:if>
<a href="<c:url value='/ticket/list' />">Continue Shopping</a>
</body>
</html>
