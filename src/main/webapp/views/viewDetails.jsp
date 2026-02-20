<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Visit Details</title>
</head>
<body>

<h2>Visit Details</h2>

<h3>Visit Information</h3>
<p><strong>ID:</strong> ${visitDetails.visitId}</p>
<p><strong>Status:</strong> ${visitDetails.visitStatus}</p>
<p><strong>Date:</strong> ${visitDetails.visitDate}</p>

<hr>

<h3>Patient Information</h3>
<p><strong>Name:</strong> ${visitDetails.patientName}</p>
<p><strong>Gender:</strong> ${visitDetails.gender}</p>
<p><strong>Date of Birth:</strong> ${visitDetails.dateOfBirth}</p>
<p><strong>Phone:</strong> ${visitDetails.phone}</p>

<hr>

<h3>Vitals</h3>
<p><strong>Temperature:</strong> ${visitDetails.temperature}</p>
<p><strong>Blood Pressure:</strong> ${visitDetails.bloodPressure}</p>
<p><strong>Weight:</strong> ${visitDetails.weight}</p>
<p><strong>Nurse:</strong> ${visitDetails.nurseName}</p>

<hr>

<h3>Diagnosis</h3>
<p><strong>Doctor:</strong> ${visitDetails.doctorName}</p>
<p><strong>Notes:</strong> ${visitDetails.notes}</p>
<p><strong>Prescription:</strong> ${visitDetails.prescription}</p>

<hr>

<h3>Pharmacy</h3>
<p><strong>Medication:</strong> ${visitDetails.medication}</p>
<p><strong>Pharmacist:</strong> ${visitDetails.pharmacistName}</p>
<p><strong>Dispensed At:</strong> ${visitDetails.dispensedAt}</p>

<hr>

<a href="${pageContext.request.contextPath}/archive">Back to Archive</a>

</body>
</html>