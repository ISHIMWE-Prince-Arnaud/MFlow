<!DOCTYPE html>
<html>
<head>
    <title>MFlow Login</title>
</head>
<body>

<h2>Login</h2>

<form method="post" action="${pageContext.request.contextPath}/login">
    <label>Username:</label>
    <input type="text" name="username" required><br><br>

    <label>Password:</label>
    <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

</body>
</html>