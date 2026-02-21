<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Patient — MFlow</title>
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
                          d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
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
    <main class="p-8 max-w-2xl mx-auto">

        <div class="mb-6">
            <h1 class="text-2xl font-semibold text-slate-800">Register Patient</h1>
            <p class="text-sm text-slate-500 mt-1">Create a new patient visit and send to the nurse queue.</p>
        </div>

        <!-- Success Alert -->
        <c:if test="${param.success == 'true'}">
            <div class="mb-6 flex items-start gap-3 rounded-lg bg-green-50 border border-green-200 px-4 py-3">
                <svg class="w-4 h-4 text-green-600 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
                          d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                          clip-rule="evenodd"/>
                </svg>
                <p class="text-sm text-green-700">Patient registered successfully! The visit is now in the nurse's queue.</p>
            </div>
        </c:if>

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

        <!-- Form Card -->
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
            <form method="post" action="${pageContext.request.contextPath}/register" class="space-y-5">

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="fullName">Full Name</label>
                    <input
                        id="fullName"
                        type="text"
                        name="fullName"
                        required
                        placeholder="e.g. Jane Doe"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="gender">Gender</label>
                    <select
                        id="gender"
                        name="gender"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="dateOfBirth">Date of Birth</label>
                    <input
                        id="dateOfBirth"
                        type="date"
                        name="dateOfBirth"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="phone">Phone Number</label>
                    <input
                        id="phone"
                        type="text"
                        name="phone"
                        placeholder="e.g. +27 82 000 0000"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                </div>

                <div class="pt-2">
                    <button
                        type="submit"
                        class="w-full bg-primary text-white text-sm font-medium px-4 py-2.5 rounded-lg
                               transition-all duration-200 hover:bg-blue-700 hover:scale-[1.02]
                               focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2
                               active:scale-[0.98]"
                    >
                        Register &amp; Send to Nurse
                    </button>
                </div>

            </form>
        </div>

    </main>

</body>
</html>
