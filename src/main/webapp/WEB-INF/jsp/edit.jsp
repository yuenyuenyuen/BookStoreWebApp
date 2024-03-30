<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
</head>
<body>
<h2>Edit Book</h2>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="ticketForm">
    <form:label path="bookName">Book Name</form:label><br/>
    <form:input type="text" path="bookName"/><br/><br/>
    <form:label path="author">Author</form:label><br/>
    <form:input type="text" path="author"/><br/><br/>
    <form:label path="price">Price</form:label><br/>
    <form:input type="number" step="0.01" path="price"/><br/><br/>
    <form:label path="description">Description</form:label><br/>
    <form:textarea type="text" path="description" rows="5" cols="30"/><br/><br/>
    <form:label path="availability">Availability</form:label>
    <form:checkbox path="availability"/><br/><br/>
    <b>Attachments</b><br/>
    <input type="file" name="attachments" multiple="multiple"/><br/><br/>
    <input type="submit" value="Update"/>
</form:form>
</body>
</html>