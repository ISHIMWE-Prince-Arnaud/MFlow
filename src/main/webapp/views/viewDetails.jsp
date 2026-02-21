<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visit Details — MFlow</title>
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
    <style>
        .card-accent-blue   { border-left: 4px solid #2563EB; }
        .card-accent-amber  { border-left: 4px solid #F59E0B; }
        .card-accent-indigo { border-left: 4px solid #6366F1; }
        .card-accent-green  { border-left: 4px solid #16A34A; }
        .card-accent-slate  { border-left: 4px solid #64748B; }
        @media print {
            header, .no-print { display: none !important; }
            body { background: white !important; }
            .print-card { box-shadow: none !important; border: 1px solid #e2e8f0 !important; }
        }
    </style>
</head>
<body class="min-h-screen bg-slate-50 font-sans">

    <%-- Resolve status badge classes once --%>
    <c:choose>
        <c:when test="${visitDetails.visitStatus == 'REGISTERED'}">
            <c:set var="statusBadgeClass" value="bg-blue-100 text-blue-700 border-blue-500"/>
            <c:set var="statusStep" value="1"/>
        </c:when>
        <c:when test="${visitDetails.visitStatus == 'VITALS_RECORDED'}">
            <c:set var="statusBadgeClass" value="bg-amber-100 text-amber-700 border-amber-500"/>
            <c:set var="statusStep" value="2"/>
        </c:when>
        <c:when test="${visitDetails.visitStatus == 'DIAGNOSED'}">
            <c:set var="statusBadgeClass" value="bg-indigo-100 text-indigo-700 border-indigo-500"/>
            <c:set var="statusStep" value="3"/>
        </c:when>
        <c:when test="${visitDetails.visitStatus == 'COMPLETED'}">
            <c:set var="statusBadgeClass" value="bg-green-100 text-green-700 border-green-500"/>
            <c:set var="statusStep" value="4"/>
        </c:when>
        <c:otherwise>
            <c:set var="statusBadgeClass" value="bg-red-100 text-red-700 border-red-500"/>
            <c:set var="statusStep" value="0"/>
        </c:otherwise>
    </c:choose>

    <!-- Header -->
    <header class="h-16 bg-white border-b border-slate-200 flex items-center px-8 justify-between shadow-sm no-print">
        <div class="flex items-center gap-3">
            <div class="inline-flex items-center justify-center w-8 h-8 rounded-lg bg-primary">
                <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                </svg>
            </div>
            <span class="text-lg font-semibold text-slate-800">MFlow</span>
        </div>
        <div class="flex items-center gap-3">
            <!-- Print button -->
            <button
                onclick="window.print()"
                class="flex items-center gap-2 text-sm text-slate-500 hover:text-slate-700 border border-slate-200
                       hover:border-slate-300 rounded-lg px-3 py-1.5 transition-colors duration-150"
                title="Print this record"
            >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                </svg>
                Print
            </button>
            <a href="${pageContext.request.contextPath}/archive"
               class="flex items-center gap-2 text-sm text-slate-500 hover:text-primary transition-colors duration-150">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Back to Archive
            </a>
        </div>
    </header>

    <!-- Main -->
    <main class="p-8 max-w-4xl mx-auto">

        <!-- Page Title + Status Badge -->
        <div class="flex items-start justify-between mb-6">
            <div>
                <h1 class="text-2xl font-semibold text-slate-800">Visit Details</h1>
                <p class="text-sm text-slate-500 mt-1">Full clinical record for visit <span class="font-medium text-slate-700">#${visitDetails.visitId}</span></p>
            </div>
            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium border ${statusBadgeClass}">
                ${visitDetails.visitStatus}
            </span>
        </div>

        <!-- Workflow Progress Stepper -->
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-5 mb-6 no-print">
            <p class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-4">Workflow Progress</p>
            <div class="flex items-center">

                <!-- Step 1: Registered -->
                <div class="flex flex-col items-center flex-1">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center text-xs font-semibold
                        ${statusStep >= 1 ? 'bg-blue-600 text-white' : 'bg-slate-100 text-slate-400'}">
                        <c:choose>
                            <c:when test="${statusStep > 1}">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7"/>
                                </svg>
                            </c:when>
                            <c:otherwise>1</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="text-xs mt-1.5 font-medium ${statusStep >= 1 ? 'text-blue-700' : 'text-slate-400'}">Registered</span>
                </div>

                <!-- Connector -->
                <div class="flex-1 h-0.5 ${statusStep >= 2 ? 'bg-amber-400' : 'bg-slate-200'} mx-1 mb-5"></div>

                <!-- Step 2: Vitals -->
                <div class="flex flex-col items-center flex-1">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center text-xs font-semibold
                        ${statusStep >= 2 ? 'bg-amber-500 text-white' : 'bg-slate-100 text-slate-400'}">
                        <c:choose>
                            <c:when test="${statusStep > 2}">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7"/>
                                </svg>
                            </c:when>
                            <c:otherwise>2</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="text-xs mt-1.5 font-medium ${statusStep >= 2 ? 'text-amber-700' : 'text-slate-400'}">Vitals</span>
                </div>

                <!-- Connector -->
                <div class="flex-1 h-0.5 ${statusStep >= 3 ? 'bg-indigo-400' : 'bg-slate-200'} mx-1 mb-5"></div>

                <!-- Step 3: Diagnosed -->
                <div class="flex flex-col items-center flex-1">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center text-xs font-semibold
                        ${statusStep >= 3 ? 'bg-indigo-600 text-white' : 'bg-slate-100 text-slate-400'}">
                        <c:choose>
                            <c:when test="${statusStep > 3}">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7"/>
                                </svg>
                            </c:when>
                            <c:otherwise>3</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="text-xs mt-1.5 font-medium ${statusStep >= 3 ? 'text-indigo-700' : 'text-slate-400'}">Diagnosed</span>
                </div>

                <!-- Connector -->
                <div class="flex-1 h-0.5 ${statusStep >= 4 ? 'bg-green-400' : 'bg-slate-200'} mx-1 mb-5"></div>

                <!-- Step 4: Completed -->
                <div class="flex flex-col items-center flex-1">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center text-xs font-semibold
                        ${statusStep >= 4 ? 'bg-green-600 text-white' : 'bg-slate-100 text-slate-400'}">
                        <c:choose>
                            <c:when test="${statusStep >= 4}">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7"/>
                                </svg>
                            </c:when>
                            <c:otherwise>4</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="text-xs mt-1.5 font-medium ${statusStep >= 4 ? 'text-green-700' : 'text-slate-400'}">Completed</span>
                </div>

            </div>
        </div>

        <div class="space-y-5">

            <!-- Visit Info Card -->
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 card-accent-blue hover:shadow-md transition duration-200 print-card">
                <div class="flex items-center gap-2 mb-4">
                    <svg class="w-4 h-4 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                    <h2 class="text-base font-semibold text-slate-800">Visit Information</h2>
                </div>
                <dl class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Visit ID</dt>
                        <dd class="text-sm font-semibold text-slate-800">#${visitDetails.visitId}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Status</dt>
                        <dd>
                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border ${statusBadgeClass}">
                                ${visitDetails.visitStatus}
                            </span>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Date</dt>
                        <dd class="text-sm text-slate-800">${visitDetails.visitDate}</dd>
                    </div>
                </dl>
            </div>

            <!-- Patient Info Card -->
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 card-accent-slate hover:shadow-md transition duration-200 print-card">
                <div class="flex items-center gap-2 mb-4">
                    <svg class="w-4 h-4 text-slate-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    <h2 class="text-base font-semibold text-slate-800">Patient Information</h2>
                </div>
                <dl class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Full Name</dt>
                        <dd class="text-sm font-medium text-slate-800">${visitDetails.patientName}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Gender</dt>
                        <dd class="text-sm text-slate-800">${visitDetails.gender}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Date of Birth</dt>
                        <dd class="text-sm text-slate-800">${visitDetails.dateOfBirth}</dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Phone</dt>
                        <dd class="text-sm text-slate-800">${visitDetails.phone}</dd>
                    </div>
                </dl>
            </div>

            <!-- Vitals Card -->
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 card-accent-amber hover:shadow-md transition duration-200 print-card">
                <div class="flex items-center gap-2 mb-4">
                    <svg class="w-4 h-4 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                    </svg>
                    <h2 class="text-base font-semibold text-slate-800">Vitals</h2>
                    <c:if test="${empty visitDetails.temperature && empty visitDetails.bloodPressure && empty visitDetails.weight}">
                        <span class="ml-auto text-xs text-slate-400 italic">Not yet recorded</span>
                    </c:if>
                </div>
                <dl class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Temperature</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.temperature}">${visitDetails.temperature} °C</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Blood Pressure</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.bloodPressure}">${visitDetails.bloodPressure}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Weight</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.weight}">${visitDetails.weight} kg</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Recorded by Nurse</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.nurseName}">${visitDetails.nurseName}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                </dl>
            </div>

            <!-- Diagnosis Card -->
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 card-accent-indigo hover:shadow-md transition duration-200 print-card">
                <div class="flex items-center gap-2 mb-4">
                    <svg class="w-4 h-4 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    <h2 class="text-base font-semibold text-slate-800">Diagnosis</h2>
                    <c:if test="${empty visitDetails.doctorName}">
                        <span class="ml-auto text-xs text-slate-400 italic">Not yet completed</span>
                    </c:if>
                </div>
                <dl class="space-y-4">
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Doctor</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.doctorName}">${visitDetails.doctorName}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Clinical Notes</dt>
                        <dd class="text-sm text-slate-800 leading-relaxed bg-slate-50 rounded-lg p-3 border border-slate-100 min-h-[3rem]">
                            <c:choose>
                                <c:when test="${not empty visitDetails.notes}">${visitDetails.notes}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">No notes recorded</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Prescription</dt>
                        <dd class="text-sm text-slate-800 leading-relaxed bg-slate-50 rounded-lg p-3 border border-slate-100 min-h-[3rem]">
                            <c:choose>
                                <c:when test="${not empty visitDetails.prescription}">${visitDetails.prescription}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">No prescription issued</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                </dl>
            </div>

            <!-- Pharmacy Card -->
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 card-accent-green hover:shadow-md transition duration-200 print-card">
                <div class="flex items-center gap-2 mb-4">
                    <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                    </svg>
                    <h2 class="text-base font-semibold text-slate-800">Pharmacy</h2>
                    <c:if test="${empty visitDetails.pharmacistName}">
                        <span class="ml-auto text-xs text-slate-400 italic">Not yet dispensed</span>
                    </c:if>
                </div>
                <dl class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div class="sm:col-span-2">
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Medication Dispensed</dt>
                        <dd class="text-sm text-slate-800 leading-relaxed bg-slate-50 rounded-lg p-3 border border-slate-100 min-h-[3rem]">
                            <c:choose>
                                <c:when test="${not empty visitDetails.medication}">${visitDetails.medication}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">Not dispensed yet</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Pharmacist</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.pharmacistName}">${visitDetails.pharmacistName}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-xs font-medium text-slate-500 uppercase tracking-wide mb-1">Dispensed At</dt>
                        <dd class="text-sm text-slate-800">
                            <c:choose>
                                <c:when test="${not empty visitDetails.dispensedAt}">${visitDetails.dispensedAt}</c:when>
                                <c:otherwise><span class="text-slate-400 italic">—</span></c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                </dl>
            </div>

        </div>

        <!-- Bottom actions -->
        <div class="mt-8 flex items-center justify-between no-print">
            <a href="${pageContext.request.contextPath}/archive"
               class="flex items-center gap-2 text-sm text-slate-500 hover:text-primary transition-colors duration-150">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Back to Archive
            </a>
            <button
                onclick="window.print()"
                class="flex items-center gap-2 text-sm font-medium text-white bg-primary px-4 py-2 rounded-lg
                       hover:bg-blue-700 transition-all duration-200 hover:scale-[1.02] focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2"
            >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                </svg>
                Print Record
            </button>
        </div>

    </main>

</body>
</html>
