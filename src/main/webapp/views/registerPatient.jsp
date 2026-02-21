<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register Patient</title>
</head>
<body>

<h2>Register Patient</h2>

<c:if test="${param.success == 'true'}">
    <p style="color:green;">Patient registered successfully! The visit is now in the nurse's queue.</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/register">

    <label>Full Name:</label>
    <input type="text" name="fullName" required><br><br>

    <label>Gender:</label>
    <select name="gender">
        <option value="Male">Male</option>
        <option value="Female">Female</option>
    </select><br><br>

    <label>Date of Birth:</label>
    <input type="date" name="dateOfBirth"><br><br>

    <label>Phone:</label>
    <input type="text" name="phone"><br><br>

    <button type="submit">Register & Send to Nurse</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

</body>
</html>