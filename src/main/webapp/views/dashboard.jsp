<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Dashboard - MFlow</title>
</head>
<body>

<h2>Welcome, ${sessionScope.loggedInStaff.fullName}</h2>
<p>Role: ${sessionScope.loggedInStaff.role}</p>

<hr>

<c:choose>
    <c:when test="${sessionScope.loggedInStaff.role == 'RECEPTIONIST'}">
        <h3>Reception Panel</h3>
        <a href="${pageContext.request.contextPath}/register">
            Register New Patient Visit
        </a>
    </c:when>

    <c:when test="${sessionScope.loggedInStaff.role == 'NURSE'}">
        <h3>Nurse Panel</h3>
        <a href="${pageContext.request.contextPath}/nurse">
            Record Patient Vitals
        </a>
    </c:when>

    <c:when test="${sessionScope.loggedInStaff.role == 'DOCTOR'}">
        <h3>Doctor Panel</h3>
        <a href="${pageContext.request.contextPath}/doctor">
            Diagnose Patient
        </a>
    </c:when>

    <c:when test="${sessionScope.loggedInStaff.role == 'PHARMACIST'}">
        <h3>Pharmacy Panel</h3>
        <a href="${pageContext.request.contextPath}/pharmacy">
            Dispense Medication
        </a>
    </c:when>

    <c:when test="${sessionScope.loggedInStaff.role == 'ADMIN'}">
        <h3>Admin Panel</h3>
        <a href="${pageContext.request.contextPath}/archive">
            View Archived Visits
        </a>
    </c:when>

</c:choose>

<hr>

<a href="${pageContext.request.contextPath}/logout">Logout</a>

</body>
</html>
