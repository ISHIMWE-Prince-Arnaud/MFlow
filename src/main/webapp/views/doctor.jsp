<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor — Diagnosis — MFlow</title>
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
                <h1 class="text-2xl font-semibold text-slate-800">Patient Diagnosis</h1>
                <p class="text-sm text-slate-500 mt-1">Patients with recorded vitals awaiting diagnosis.</p>
            </div>
            <c:if test="${not empty pendingVisits}">
                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold bg-indigo-100 text-indigo-700 border border-indigo-200">
                    <span class="w-1.5 h-1.5 rounded-full bg-indigo-500 animate-pulse inline-block"></span>
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
                    <div class="w-12 h-12 rounded-full bg-indigo-100 flex items-center justify-center mx-auto mb-4">
                        <svg class="w-6 h-6 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <p class="text-sm font-medium text-slate-700">No patients waiting for diagnosis</p>
                    <p class="text-xs text-slate-400 mt-1">Patients will appear here after vitals are recorded.</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Patients List -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-100">
                        <h2 class="text-base font-medium text-slate-700">Patients Waiting for Diagnosis</h2>
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
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-amber-100 text-amber-700 border border-amber-200">
                                        VITALS RECORDED
                                    </span>
                                </div>

                                <!-- Diagnosis Form -->
                                <form action="${pageContext.request.contextPath}/doctor" method="post">
                                    <input type="hidden" name="visitId" value="${visit.visitId}" />
                                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-4">
                                        <div>
                                            <label class="block text-xs font-medium text-slate-600 mb-1.5">Clinical Notes</label>
                                            <textarea
                                                name="notes"
                                                rows="4"
                                                required
                                                placeholder="Enter diagnosis notes..."
                                                class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800
                                                       placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                                                       transition duration-150 resize-none leading-relaxed"
                                            ></textarea>
                                        </div>
                                        <div>
                                            <label class="block text-xs font-medium text-slate-600 mb-1.5">Prescription</label>
                                            <textarea
                                                name="prescription"
                                                rows="4"
                                                placeholder="Enter prescription details..."
                                                class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800
                                                       placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                                                       transition duration-150 resize-none leading-relaxed"
                                            ></textarea>
                                        </div>
                                    </div>
                                    <button
                                        type="submit"
                                        class="bg-primary text-white text-sm font-medium px-4 py-2 rounded-lg
                                               transition-all duration-200 hover:bg-blue-700 hover:scale-[1.02]
                                               focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2
                                               active:scale-[0.98]"
                                    >
                                        Save Diagnosis
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
