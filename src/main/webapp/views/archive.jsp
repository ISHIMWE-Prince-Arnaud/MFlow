<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Archived Visits</title>
</head>
<body>

<h2>Archived Visits</h2>

<table border="1">
    <tr>
        <th>Visit ID</th>
        <th>Patient</th>
        <th>Doctor</th>
        <th>Medication</th>
        <th>Date</th>
        <th>Action</th>
    </tr>

    <c:forEach var="record" items="${records}">
        <tr>
            <td>${record.visitId}</td>
            <td>${record.patientName}</td>
            <td>${record.doctorName}</td>
            <td>${record.medication}</td>
            <td>${record.visitDate}</td>
            <td>
                <a href="${pageContext.request.contextPath}/archive/details?visitId=${record.visitId}">
                    View Details
                </a>
            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>