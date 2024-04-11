<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="meta.jsp" %>
    <title>Edit Book</title>
</head>
<body>
<div class="container">
    <h2>Edit Book</h2>
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
            <form:checkbox path="availability" class="form-check-input"/>
        </div>
        <div class="form-group">
            <b>Attachments</b><br/>
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
        </div>
        <input type="submit" value="Update" class="btn btn-primary"/>
    </form:form>
</div>
</body>
</html>
