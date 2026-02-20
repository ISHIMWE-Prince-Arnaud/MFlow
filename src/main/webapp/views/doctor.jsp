<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Doctor - Diagnosis</title>
</head>
<body>

<h2>Patient Diagnosis</h2>

<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>

<c:choose>
    <c:when test="${empty pendingVisits}">
        <p>No patients waiting for diagnosis.</p>
    </c:when>
    <c:otherwise>
        <h3>Patients Waiting for Diagnosis:</h3>
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
                    <td><fmt:formatDate value="${visit.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/doctor" method="post" style="margin:0;">
                            <input type="hidden" name="visitId" value="${visit.visitId}" />
                            
                            <label>Notes:</label><br>
                            <textarea name="notes" rows="3" cols="30" required></textarea><br>
                            
                            <label>Prescription:</label><br>
                            <textarea name="prescription" rows="3" cols="30"></textarea><br>
                            
                            <button type="submit">Save Diagnosis</button>
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
