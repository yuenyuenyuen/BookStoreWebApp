<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Insert Book</title>
</head>
<body>
<div class="container">
    <h2>Insert a Book</h2>
    <form:form method="POST" enctype="multipart/form-data" modelAttribute="ticketForm">
        <div class="form-group">
            <form:label path="bookName">Book Name</form:label>
            <form:input type="text" path="bookName" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="author">Author</form:label>
            <form:input type="text" path="author" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="price">Price</form:label>
            <form:input type="number" step="0.01" path="price" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="description">Description</form:label>
            <form:textarea type="text" path="description" rows="5" cols="30" class="form-control"></form:textarea>
        </div>
        <div class="form-group">
            <form:label path="availability">Availability</form:label>
            <form:checkbox path="availability"/>
        </div>
        <%--<form:label path="comments"></form:label>
        <form:hidden path="comments"/>--%>
        <%--<form:label path="comment">Comment</form:label><br/>
        <form:textarea path="comment" rows="5" cols="30"/><br/><br/>--%>
        <div class="form-group">
            <b>Attachments</b><br/>
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
        </div>
        <input type="submit" value="Submit" class="btn btn-primary"/>
    </form:form>
</div>
</body>
</html>
