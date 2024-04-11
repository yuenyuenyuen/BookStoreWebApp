<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Checkout</title>
</head>
<body>
<div class="container">
    <h2>Checkout</h2>
    <h3>Purchase Details</h3>
    <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>Book Name</th>
            <th>Author</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
        </tr>
        </thead>
        <tbody>
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
        </tbody>
    </table>
    <br/>
    <div>
        <p>Total Items: ${cart.totalItems}</p>
        <p>Total Price: ${totalPrice}</p>
    </div>

    <form action="<c:url value='/checkout/process' />" method="get">
        <!-- Add Checkout Form Fields Here -->
        <input type="submit" value="Proceed to Payment" class="btn btn-success">
    </form>
    <a href="<c:url value='/cart/view' />" class="btn btn-info">Back to Cart</a>
</div>
</body>
</html>
