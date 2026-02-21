<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MFlow - Login</title>
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
<body class="min-h-screen bg-gradient-to-br from-blue-50 to-slate-100 font-sans flex items-center justify-center">

    <div class="w-full max-w-md">

        <!-- Logo / Brand -->
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-12 h-12 rounded-xl bg-primary mb-4">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                </svg>
            </div>
            <h1 class="text-2xl font-semibold text-slate-800">MFlow</h1>
            <p class="text-sm text-slate-500 mt-1">Clinical Workflow Management</p>
        </div>

        <!-- Card -->
        <div class="bg-white rounded-xl shadow-lg border border-slate-200 p-8">
            <h2 class="text-xl font-semibold text-slate-800 mb-6">Sign in to your account</h2>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="mb-5 flex items-start gap-3 rounded-lg bg-red-50 border border-red-200 px-4 py-3">
                    <svg class="w-4 h-4 text-red-600 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd"
                              d="M10 18a8 8 0 100-16 8 8 0 000 16zm-.75-11.25a.75.75 0 011.5 0v4.5a.75.75 0 01-1.5 0v-4.5zm.75 7.5a.75.75 0 100-1.5.75.75 0 000 1.5z"
                              clip-rule="evenodd"/>
                    </svg>
                    <p class="text-sm text-red-700">${error}</p>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-5">

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="username">Username</label>
                    <input
                        id="username"
                        type="text"
                        name="username"
                        required
                        placeholder="Enter your username"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="password">Password</label>
                    <input
                        id="password"
                        type="password"
                        name="password"
                        required
                        placeholder="Enter your password"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                </div>

                <button
                    type="submit"
                    class="w-full bg-primary text-white text-sm font-medium px-4 py-2.5 rounded-lg
                           transition-all duration-200 hover:bg-blue-700 hover:scale-[1.02]
                           focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2
                           active:scale-[0.98]"
                >
                    Sign In
                </button>

            </form>
        </div>

        <p class="text-center text-xs text-slate-400 mt-6">MFlow &copy; 2025 - Secure Clinical System</p>
    </div>

</body>
</html>
