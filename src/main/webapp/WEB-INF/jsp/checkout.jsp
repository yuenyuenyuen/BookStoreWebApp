<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
</head>
<body>
<h2>Checkout</h2>
<h3>Purchase Details</h3>
<table border="1">
    <tr>
        <th>Book Name</th>
        <th>Author</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total Price</th>
    </tr>
    <c:forEach items="${cart.items}" var="entry">
        <c:set var="ticket" value="${ticketService.getTicket(entry.key)}"/>
        <tr>
            <td>${ticket.bookName}</td>
            <td>${ticket.author}</td>
            <td>${ticket.price}</td>
            <td>${entry.value}</td>
            <td>${entry.value * ticket.price}</td>
        </tr>
    </c:forEach>
</table>
<br/>
Total Items: ${cart.totalItems}<br>
Total Price: ${totalPrice}<br>

<form action="<c:url value='/checkout/process' />" method="get">
    <!-- Add Checkout Form Fields Here -->
    <input type="submit" value="Proceed to Payment">
</form>
<a href="<c:url value='/cart/view' />">Back to Cart</a>
</body>
</html>
