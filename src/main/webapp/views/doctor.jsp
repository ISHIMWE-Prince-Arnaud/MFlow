<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Doctor - Diagnosis</title>
</head>
<body>

<h2>Patient Diagnosis</h2>

<form action="${pageContext.request.contextPath}/doctor" method="post">

    <label>Visit ID:</label>
    <input type="number" name="visitId" required />
    <br><br>

    <label>Notes:</label>
    <br>
    <textarea name="notes" rows="4" cols="50"></textarea>
    <br><br>

    <label>Prescription:</label>
    <br>
    <textarea name="prescription" rows="4" cols="50"></textarea>
    <br><br>

    <button type="submit">Save Diagnosis</button>
</form>

<hr>
<a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>

</body>
</html>