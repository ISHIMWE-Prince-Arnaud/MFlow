<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Pharmacy - Dispense Medication</title>
</head>
<body>

<h2>Dispense Medication</h2>

<form action="${pageContext.request.contextPath}/pharmacy" method="post">

    <label>Visit ID:</label>
    <input type="number" name="visitId" value="${visitId}" required />
    <br><br>

    <label>Medication:</label>
    <br>
    <textarea name="medication" rows="4" cols="50" required></textarea>
    <br><br>

    <button type="submit">Dispense & Complete Visit</button>
</form>

<hr>
<a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>

</body>
</html>