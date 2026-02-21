<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy — Dispense Medication — MFlow</title>
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
    <main class="p-8 max-w-5xl mx-auto">

        <div class="mb-6 flex items-start justify-between">
            <div>
                <h1 class="text-2xl font-semibold text-slate-800">Dispense Medication</h1>
                <p class="text-sm text-slate-500 mt-1">Patients with prescriptions awaiting medication dispensing.</p>
            </div>
            <c:if test="${not empty pendingVisits}">
                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold bg-green-100 text-green-700 border border-green-200">
                    <span class="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse inline-block"></span>
                    ${fn:length(pendingVisits)} waiting
                </span>
            </c:if>
        </div>

        <!-- Error Alert -->
        <c:if test="${not empty error}">
            <div class="mb-6 flex items-start gap-3 rounded-lg bg-red-50 border border-red-200 px-4 py-3">
                <svg class="w-4 h-4 text-red-600 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
                          d="M10 18a8 8 0 100-16 8 8 0 000 16zm-.75-11.25a.75.75 0 011.5 0v4.5a.75.75 0 01-1.5 0v-4.5zm.75 7.5a.75.75 0 100-1.5.75.75 0 000 1.5z"
                          clip-rule="evenodd"/>
                </svg>
                <p class="text-sm text-red-700">${error}</p>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty pendingVisits}">
                <!-- Empty State -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-12 text-center">
                    <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center mx-auto mb-4">
                        <svg class="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                        </svg>
                    </div>
                    <p class="text-sm font-medium text-slate-700">No patients waiting for medication</p>
                    <p class="text-xs text-slate-400 mt-1">Patients will appear here after diagnosis is completed.</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Patients List -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-100">
                        <h2 class="text-base font-medium text-slate-700">Patients Waiting for Medication</h2>
                    </div>
                    <div class="divide-y divide-slate-100">
                        <c:forEach var="visit" items="${pendingVisits}">
                            <div class="p-6">
                                <!-- Patient Info Row -->
                                <div class="flex items-start justify-between mb-4">
                                    <div>
                                        <div class="flex items-center gap-2 mb-1">
                                            <span class="text-xs font-medium text-slate-400 uppercase tracking-wide">Visit</span>
                                            <span class="text-xs font-semibold text-slate-600">#${visit.visitId}</span>
                                        </div>
                                        <p class="text-base font-medium text-slate-800">${visit.patientName}</p>
                                        <p class="text-xs text-slate-400 mt-0.5">${visit.createdAt}</p>
                                    </div>
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-indigo-100 text-indigo-700 border border-indigo-200">
                                        DIAGNOSED
                                    </span>
                                </div>

                                <!-- Dispense Form -->
                                <form action="${pageContext.request.contextPath}/pharmacy" method="post">
                                    <input type="hidden" name="visitId" value="${visit.visitId}" />
                                    <div class="mb-4">
                                        <label class="block text-xs font-medium text-slate-600 mb-1.5">Medication Dispensed</label>
                                        <textarea
                                            name="medication"
                                            rows="3"
                                            required
                                            placeholder="List medications dispensed..."
                                            class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800
                                                   placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                                                   transition duration-150 resize-none leading-relaxed"
                                        ></textarea>
                                    </div>
                                    <button
                                        type="submit"
                                        class="bg-success text-white text-sm font-medium px-4 py-2 rounded-lg
                                               transition-all duration-200 hover:bg-green-700 hover:scale-[1.02]
                                               focus:outline-none focus:ring-2 focus:ring-success focus:ring-offset-2
                                               active:scale-[0.98]"
                                    >
                                        Dispense &amp; Complete Visit
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

</body>
</html>
