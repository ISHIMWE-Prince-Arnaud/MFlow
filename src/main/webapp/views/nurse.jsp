<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Nurse - Record Vitals</title>
</head>
<body>

<h2>Record Patient Vitals</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<c:choose>
    <c:when test="${empty pendingVisits}">
        <p>No patients waiting for vitals.</p>
    </c:when>
    <c:otherwise>
        <h3>Patients Waiting for Vitals:</h3>
        <table border="1" cellpadding="5">
            <tr>
                <th>Visit ID</th>
                <th>Patient Name</th>
                <th>Time</th>
                <th>Action</th>
            </tr>
            <c:forEach var="visit" items="${pendingVisits}">
                <tr>
                    <td>${visit.visitId}</td>
                    <td>${visit.patientName}</td>
                    <td>${visit.createdAt}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/nurse" method="post" style="margin:0;">
                            <input type="hidden" name="visitId" value="${visit.visitId}" />
                            
                            <label>Temperature (°C):</label>
                            <input type="number" step="0.1" name="temperature" required /><br>
                            
                            <label>Blood Pressure:</label>
                            <input type="text" name="bloodPressure" placeholder="e.g., 120/80" required /><br>
                            
                            <label>Weight (kg):</label>
                            <input type="number" step="0.1" name="weight" required /><br>
                            
                            <button type="submit">Save Vitals</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

<hr>
<a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>

</body>
</html>
