<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — MFlow</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary:   '#2563EB',
                        secondary: '#0EA5E9',
                        success:   '#16A34A',
                        warning:   '#F59E0B',
                        danger:    '#DC2626',
                    },
                    fontFamily: {
                        sans: ['Inter', 'ui-sans-serif', 'system-ui'],
                    },
                }
            }
        }
    </script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body class="min-h-screen bg-slate-50 font-sans">

<%-- Resolve role badge class once, cleanly --%>
<c:set var="role" value="${sessionScope.loggedInStaff.role}" />
<c:choose>
    <c:when test="${role == 'RECEPTIONIST'}"><c:set var="roleBadgeClass" value="bg-blue-100 text-blue-700 border border-blue-200"/></c:when>
    <c:when test="${role == 'NURSE'}"><c:set var="roleBadgeClass" value="bg-amber-100 text-amber-700 border border-amber-200"/></c:when>
    <c:when test="${role == 'DOCTOR'}"><c:set var="roleBadgeClass" value="bg-indigo-100 text-indigo-700 border border-indigo-200"/></c:when>
    <c:when test="${role == 'PHARMACIST'}"><c:set var="roleBadgeClass" value="bg-green-100 text-green-700 border border-green-200"/></c:when>
    <c:when test="${role == 'ADMIN'}"><c:set var="roleBadgeClass" value="bg-slate-100 text-slate-700 border border-slate-200"/></c:when>
    <c:otherwise><c:set var="roleBadgeClass" value="bg-slate-100 text-slate-700 border border-slate-200"/></c:otherwise>
</c:choose>

<!-- Header -->
<header class="h-16 bg-white border-b border-slate-200 flex items-center px-8 justify-between shadow-sm">
    <div class="flex items-center gap-3">
        <div class="inline-flex items-center justify-center w-8 h-8 rounded-lg bg-primary">
            <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
            </svg>
        </div>
        <span class="text-lg font-semibold text-slate-800">MFlow</span>
    </div>

    <div class="flex items-center gap-4">
        <!-- Staff name + role in header -->
        <div class="hidden sm:flex items-center gap-2">
            <span class="text-sm text-slate-600">${sessionScope.loggedInStaff.fullName}</span>
            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${roleBadgeClass}">
                ${role}
            </span>
        </div>
        <div class="w-px h-5 bg-slate-200 hidden sm:block"></div>
        <a href="${pageContext.request.contextPath}/logout"
           class="flex items-center gap-2 text-sm text-slate-500 hover:text-danger transition-colors duration-150">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            Logout
        </a>
    </div>
</header>

<!-- Main -->
<main class="p-8 max-w-5xl mx-auto">

    <!-- Welcome Section -->
    <div class="mb-8">
        <h1 class="text-2xl font-semibold text-slate-800 mb-1">
            Welcome back, ${sessionScope.loggedInStaff.fullName}
        </h1>
        <p class="text-sm text-slate-500">
            Here's your workspace. Select an action below to get started.
        </p>
    </div>

    <!-- Success Alert for Patient Registration -->
    <c:if test="${param.registered == 'true'}">
        <div class="mb-6 flex items-start gap-3 rounded-lg bg-green-50 border border-green-200 px-4 py-3">
            <svg class="w-4 h-4 text-green-600 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clip-rule="evenodd"/>
            </svg>
            <p class="text-sm text-green-700">Patient registered successfully! The visit is now in the nurse's queue.</p>
        </div>
    </c:if>

    <!-- Empty State for Receptionist (No registered patients) -->
    <c:if test="${role == 'RECEPTIONIST' && empty registeredPatients}">
        <div class="mb-6 bg-white rounded-xl shadow-sm border border-slate-200 p-8 text-center">
            <div class="w-12 h-12 rounded-full bg-blue-100 flex items-center justify-center mx-auto mb-4">
                <svg class="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                </svg>
            </div>
            <p class="text-sm font-medium text-slate-700">No patients registered yet</p>
            <p class="text-xs text-slate-400 mt-1">Register a new patient to get started.</p>
        </div>
    </c:if>

    <!-- Empty State for Nurse (No patients needing vitals) -->
    <c:if test="${role == 'NURSE' && empty patientsNeedingVitals}">
        <div class="mb-6 bg-white rounded-xl shadow-sm border border-slate-200 p-8 text-center">
            <div class="w-12 h-12 rounded-full bg-amber-100 flex items-center justify-center mx-auto mb-4">
                <svg class="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                </svg>
            </div>
            <p class="text-sm font-medium text-slate-700">No patients waiting for vitals</p>
            <p class="text-xs text-slate-400 mt-1">Patients will appear here after registration.</p>
        </div>
    </c:if>

    <!-- Empty State for Doctor (No patients needing diagnosis) -->
    <c:if test="${role == 'DOCTOR' && empty patientsNeedingDiagnosis}">
        <div class="mb-6 bg-white rounded-xl shadow-sm border border-slate-200 p-8 text-center">
            <div class="w-12 h-12 rounded-full bg-indigo-100 flex items-center justify-center mx-auto mb-4">
                <svg class="w-6 h-6 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
            </div>
            <p class="text-sm font-medium text-slate-700">No patients waiting for diagnosis</p>
            <p class="text-xs text-slate-400 mt-1">Patients will appear here after vitals are recorded.</p>
        </div>
    </c:if>

    <!-- Empty State for Pharmacist (No patients needing medication) -->
    <c:if test="${role == 'PHARMACIST' && empty patientsNeedingMedication}">
        <div class="mb-6 bg-white rounded-xl shadow-sm border border-slate-200 p-8 text-center">
            <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center mx-auto mb-4">
                <svg class="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                </svg>
            </div>
            <p class="text-sm font-medium text-slate-700">No patients waiting for medication</p>
            <p class="text-xs text-slate-400 mt-1">Patients will appear here after diagnosis is completed.</p>
        </div>
    </c:if>

    <!-- Action Cards -->
    <c:choose>

        <c:when test="${role == 'RECEPTIONIST'}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <a href="${pageContext.request.contextPath}/register"
                   class="group bg-white rounded-xl shadow-sm border border-slate-200 p-6
                              hover:shadow-md hover:border-blue-200 transition duration-200 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                            </svg>
                        </div>
                        <svg class="w-4 h-4 text-slate-300 group-hover:text-primary group-hover:translate-x-0.5 transition-all duration-200"
                             fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-base font-medium text-slate-800 group-hover:text-primary transition-colors">
                            Register New Patient Visit
                        </h3>
                        <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                            Create a new patient record and send to the nurse queue.
                        </p>
                    </div>
                </a>
            </div>
        </c:when>

        <c:when test="${role == 'NURSE'}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <a href="${pageContext.request.contextPath}/nurse"
                   class="group bg-white rounded-xl shadow-sm border border-slate-200 p-6
                              hover:shadow-md hover:border-amber-200 transition duration-200 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <svg class="w-4 h-4 text-slate-300 group-hover:text-primary group-hover:translate-x-0.5 transition-all duration-200"
                             fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-base font-medium text-slate-800 group-hover:text-primary transition-colors">
                            Record Patient Vitals
                        </h3>
                        <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                            Record temperature, blood pressure, and weight for waiting patients.
                        </p>
                    </div>
                </a>
            </div>
        </c:when>

        <c:when test="${role == 'DOCTOR'}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <a href="${pageContext.request.contextPath}/doctor"
                   class="group bg-white rounded-xl shadow-sm border border-slate-200 p-6
                              hover:shadow-md hover:border-indigo-200 transition duration-200 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-indigo-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                        </div>
                        <svg class="w-4 h-4 text-slate-300 group-hover:text-primary group-hover:translate-x-0.5 transition-all duration-200"
                             fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-base font-medium text-slate-800 group-hover:text-primary transition-colors">
                            Diagnose Patient
                        </h3>
                        <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                            Review vitals and record diagnosis notes and prescriptions.
                        </p>
                    </div>
                </a>
            </div>
        </c:when>

        <c:when test="${role == 'PHARMACIST'}">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                <a href="${pageContext.request.contextPath}/pharmacy"
                   class="group bg-white rounded-xl shadow-sm border border-slate-200 p-6
                              hover:shadow-md hover:border-green-200 transition duration-200 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-green-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                            </svg>
                        </div>
                        <svg class="w-4 h-4 text-slate-300 group-hover:text-primary group-hover:translate-x-0.5 transition-all duration-200"
                             fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-base font-medium text-slate-800 group-hover:text-primary transition-colors">
                            Dispense Medication
                        </h3>
                        <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                            Fulfill prescriptions and complete the patient visit workflow.
                        </p>
                    </div>
                </a>
            </div>
        </c:when>

        <c:when test="${role == 'ADMIN'}">
            <!-- Row 1: View Archived Visits + Visit Status Cards -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <!-- View Archived Visits Card (Link/Action Card) -->
                <a href="${pageContext.request.contextPath}/archive"
                   class="group bg-gradient-to-br from-slate-50 to-slate-100 rounded-xl shadow-sm border-2 border-primary p-6
                                  hover:shadow-lg hover:border-primary/80 transition duration-200 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-primary flex items-center justify-center">
                            <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                            </svg>
                        </div>
                        <svg class="w-4 h-4 text-primary group-hover:translate-x-0.5 transition-all duration-200"
                             fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-base font-semibold text-primary group-hover:text-primary/80 transition-colors">
                            View Archived Visits
                        </h3>
                        <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                            Browse completed patient visit records and audit history.
                        </p>
                    </div>
                </a>

                <!-- Waiting for Vitals Card -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                    </div>
                    <div>
                        <p class="text-2xl font-semibold text-amber-700">${visitsRegistered}</p>
                        <p class="text-xs text-amber-600 mt-1">Waiting for Vitals</p>
                    </div>
                </div>

                <!-- Waiting for Diagnosis Card -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-indigo-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </svg>
                        </div>
                    </div>
                    <div>
                        <p class="text-2xl font-semibold text-indigo-700">${visitsVitalsRecorded}</p>
                        <p class="text-xs text-indigo-600 mt-1">Waiting for Diagnosis</p>
                    </div>
                </div>

                <!-- Waiting for Medication Card -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 flex flex-col gap-4">
                    <div class="flex items-start justify-between">
                        <div class="w-10 h-10 rounded-lg bg-cyan-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-cyan-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                            </svg>
                        </div>
                    </div>
                    <div>
                        <p class="text-2xl font-semibold text-cyan-700">${visitsDiagnosisRecorded}</p>
                        <p class="text-xs text-cyan-600 mt-1">Waiting for Medication</p>
                    </div>
                </div>
            </div>

            <!-- Section Separator -->
            <h2 class="text-lg font-semibold text-slate-800 mb-4 mt-8">Statistics Overview</h2>

            <!-- Row 2: Statistics Cards -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <!-- Today's Visits -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                            </svg>
                        </div>
                    </div>
                    <p class="text-2xl font-semibold text-slate-800">${todayVisits}</p>
                    <p class="text-xs text-slate-500 mt-1">Today's Visits</p>
                </div>

                <!-- Total Patients -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-lg bg-purple-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                        </div>
                    </div>
                    <p class="text-2xl font-semibold text-slate-800">${totalPatients}</p>
                    <p class="text-xs text-slate-500 mt-1">Total Patients</p>
                </div>

                <!-- Total Staff -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-lg bg-teal-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                        </div>
                    </div>
                    <p class="text-2xl font-semibold text-slate-800">${totalStaff}</p>
                    <p class="text-xs text-slate-500 mt-1">Total Staff</p>
                </div>

                <!-- Completed Visits -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-lg bg-green-100 flex items-center justify-center">
                            <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                    <p class="text-2xl font-semibold text-slate-800">${completedVisits}</p>
                    <p class="text-xs text-slate-500 mt-1">Completed Visits</p>
                </div>
            </div>

        </c:when>

    </c:choose>

    <!-- Patients Needing Vitals Section (For Nurses) -->
    <c:if test="${role == 'NURSE' && not empty patientsNeedingVitals}">
        <div class="mt-8">
            <h2 class="text-lg font-semibold text-slate-800 mb-4">Patients Needing Vitals</h2>
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                <table class="w-full">
                    <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Patient Name</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Visit ID</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Status</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Registered At</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                    <c:forEach var="visit" items="${patientsNeedingVitals}">
                        <tr class="hover:bg-slate-50">
                            <td class="px-4 py-3 text-sm text-slate-800">${visit.patientName}</td>
                            <td class="px-4 py-3 text-sm text-slate-600">#${visit.visitId}</td>
                            <td class="px-4 py-3">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-700 border border-amber-200">
                                                ${visit.visitStatus}
                                        </span>
                            </td>
                            <td class="px-4 py-3 text-sm text-slate-500">
                                    ${visit.createdAtFormatted}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <!-- Patients Needing Diagnosis Section (For Doctors) -->
    <c:if test="${role == 'DOCTOR' && not empty patientsNeedingDiagnosis}">
        <div class="mt-8">
            <h2 class="text-lg font-semibold text-slate-800 mb-4">Patients Needing Diagnosis</h2>
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                <table class="w-full">
                    <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Patient Name</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Visit ID</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Status</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Registered At</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                    <c:forEach var="visit" items="${patientsNeedingDiagnosis}">
                        <tr class="hover:bg-slate-50">
                            <td class="px-4 py-3 text-sm text-slate-800">${visit.patientName}</td>
                            <td class="px-4 py-3 text-sm text-slate-600">#${visit.visitId}</td>
                            <td class="px-4 py-3">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-indigo-100 text-indigo-700 border border-indigo-200">
                                                ${visit.visitStatus}
                                        </span>
                            </td>
                            <td class="px-4 py-3 text-sm text-slate-500">
                                    ${visit.createdAtFormatted}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <!-- Patients Needing Medication Section (For Pharmacists) -->
    <c:if test="${role == 'PHARMACIST' && not empty patientsNeedingMedication}">
        <div class="mt-8">
            <h2 class="text-lg font-semibold text-slate-800 mb-4">Patients Needing Medication</h2>
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                <table class="w-full">
                    <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Patient Name</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Visit ID</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Status</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Registered At</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                    <c:forEach var="visit" items="${patientsNeedingMedication}">
                        <tr class="hover:bg-slate-50">
                            <td class="px-4 py-3 text-sm text-slate-800">${visit.patientName}</td>
                            <td class="px-4 py-3 text-sm text-slate-600">#${visit.visitId}</td>
                            <td class="px-4 py-3">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-700 border border-green-200">
                                                ${visit.visitStatus}
                                        </span>
                            </td>
                            <td class="px-4 py-3 text-sm text-slate-500">
                                    ${visit.createdAtFormatted}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <!-- My Registered Patients Section (For Receptionists) -->
    <c:if test="${role == 'RECEPTIONIST' && not empty registeredPatients}">
        <div class="mt-8">
            <h2 class="text-lg font-semibold text-slate-800 mb-4">My Registered Patients</h2>
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                <table class="w-full">
                    <thead class="bg-slate-50 border-b border-slate-200">
                    <tr>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Patient Name</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Visit ID</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Status</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-slate-500 uppercase tracking-wider">Registered At</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                    <c:forEach var="visit" items="${registeredPatients}">
                        <tr class="hover:bg-slate-50">
                            <td class="px-4 py-3 text-sm text-slate-800">${visit.patientName}</td>
                            <td class="px-4 py-3 text-sm text-slate-600">#${visit.visitId}</td>
                            <td class="px-4 py-3">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-700 border border-blue-200">
                                                ${visit.visitStatus}
                                        </span>
                            </td>
                            <td class="px-4 py-3 text-sm text-slate-500">
                                    ${visit.createdAtFormatted}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</main>

</body>
</html>
