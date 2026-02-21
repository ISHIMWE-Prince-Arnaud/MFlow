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

        <!-- Action Cards -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

            <c:choose>

                <c:when test="${role == 'RECEPTIONIST'}">
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
                </c:when>

                <c:when test="${role == 'NURSE'}">
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
                </c:when>

                <c:when test="${role == 'DOCTOR'}">
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
                </c:when>

                <c:when test="${role == 'PHARMACIST'}">
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
                </c:when>

                <c:when test="${role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/archive"
                       class="group bg-white rounded-xl shadow-sm border border-slate-200 p-6
                              hover:shadow-md hover:border-slate-300 transition duration-200 flex flex-col gap-4">
                        <div class="flex items-start justify-between">
                            <div class="w-10 h-10 rounded-lg bg-slate-100 flex items-center justify-center">
                                <svg class="w-5 h-5 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                                </svg>
                            </div>
                            <svg class="w-4 h-4 text-slate-300 group-hover:text-primary group-hover:translate-x-0.5 transition-all duration-200"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </div>
                        <div>
                            <h3 class="text-base font-medium text-slate-800 group-hover:text-primary transition-colors">
                                View Archived Visits
                            </h3>
                            <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                                Browse completed patient visit records and audit history.
                            </p>
                        </div>
                    </a>
                </c:when>

            </c:choose>

        </div>

        <!-- Footer note -->
        <p class="text-xs text-slate-400 mt-10 text-center">
            MFlow Clinical Workflow Management &mdash; All actions are logged for audit purposes.
        </p>
    </main>

</body>
</html>
