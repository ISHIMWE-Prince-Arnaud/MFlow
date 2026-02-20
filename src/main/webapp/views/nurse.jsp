<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Nurse - Record Vitals</title>
</head>
<body>

<h2>Record Patient Vitals</h2>

<form action="${pageContext.request.contextPath}/nurse" method="post">

    <label>Visit ID:</label>
    <input type="number" name="visitId" required />
    <br><br>

    <label>Temperature (°C):</label>
    <input type="number" step="0.1" name="temperature" />
    <br><br>

    <label>Blood Pressure:</label>
    <input type="text" name="bloodPressure" />
    <br><br>

    <label>Weight (kg):</label>
    <input type="number" step="0.1" name="weight" />
    <br><br>

    <button type="submit">Save Vitals</button>
</form>

<hr>
<a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>

</body>
</html>