<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Archived Visits — MFlow</title>
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
        <a href="${pageContext.request.contextPath}/dashboard"
           class="flex items-center gap-2 text-sm text-slate-500 hover:text-primary transition-colors duration-150">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
            </svg>
            Back to Dashboard
        </a>
    </header>

    <!-- Main -->
    <main class="p-8 max-w-6xl mx-auto">

        <div class="mb-6 flex items-start justify-between">
            <div>
                <h1 class="text-2xl font-semibold text-slate-800">Archived Visits</h1>
                <p class="text-sm text-slate-500 mt-1">Completed patient visit records.</p>
            </div>
            <c:if test="${not empty records}">
                <span class="inline-flex items-center px-3 py-1.5 rounded-full text-xs font-medium bg-slate-100 text-slate-600 border border-slate-200">
                    ${fn:length(records)} records
                </span>
            </c:if>
        </div>

        <!-- Table Card -->
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <c:choose>
                <c:when test="${empty records}">
                    <!-- Empty State -->
                    <div class="p-12 text-center">
                        <div class="w-12 h-12 rounded-full bg-slate-100 flex items-center justify-center mx-auto mb-4">
                            <svg class="w-6 h-6 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                            </svg>
                        </div>
                        <p class="text-sm font-medium text-slate-700">No archived visits found</p>
                        <p class="text-xs text-slate-400 mt-1">Completed visits will appear here.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="w-full text-sm">
                        <thead>
                            <tr class="bg-slate-50 border-b border-slate-200">
                                <th class="text-left px-6 py-3 text-xs font-medium text-slate-500 uppercase tracking-wide">Visit ID</th>
                                <th class="text-left px-6 py-3 text-xs font-medium text-slate-500 uppercase tracking-wide">Patient</th>
                                <th class="text-left px-6 py-3 text-xs font-medium text-slate-500 uppercase tracking-wide">Doctor</th>
                                <th class="text-left px-6 py-3 text-xs font-medium text-slate-500 uppercase tracking-wide">Medication</th>
                                <th class="text-left px-6 py-3 text-xs font-medium text-slate-500 uppercase tracking-wide">Date</th>
                                <th class="text-left px-6 py-3 text-xs font-medium text-slate-500 uppercase tracking-wide">Action</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            <c:forEach var="record" items="${records}">
                                <tr class="hover:bg-slate-50 transition-colors duration-100">
                                    <td class="px-6 py-4 text-slate-600 font-medium">#${record.visitId}</td>
                                    <td class="px-6 py-4 text-slate-800">${record.patientName}</td>
                                    <td class="px-6 py-4 text-slate-600">${record.doctorName}</td>
                                    <td class="px-6 py-4 text-slate-600 max-w-xs truncate">${record.medication}</td>
                                    <td class="px-6 py-4 text-slate-500 text-xs">${record.visitDate}</td>
                                    <td class="px-6 py-4">
                                        <a href="${pageContext.request.contextPath}/archive/details?visitId=${record.visitId}"
                                           class="inline-flex items-center gap-1.5 text-xs font-medium text-primary hover:text-blue-700
                                                  transition-colors duration-150">
                                            View Details
                                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                            </svg>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

    </main>

</body>
</html>
