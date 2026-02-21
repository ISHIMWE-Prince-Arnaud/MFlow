<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MFlow — Login</title>
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
<body class="min-h-screen bg-gradient-to-br from-blue-50 to-slate-100 font-sans flex items-center justify-center px-4">

    <div class="w-full max-w-md">

        <!-- Logo / Brand -->
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-primary shadow-lg mb-4">
                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                </svg>
            </div>
            <h1 class="text-2xl font-semibold text-slate-800">MFlow</h1>
            <p class="text-sm text-slate-500 mt-1">Clinical Workflow Management System</p>
        </div>

        <!-- Card -->
        <div class="bg-white rounded-2xl shadow-lg border border-slate-200 p-8">
            <h2 class="text-lg font-semibold text-slate-800 mb-1">Sign in to your account</h2>
            <p class="text-xs text-slate-400 mb-6">Enter your credentials to access the system.</p>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="mb-5 flex items-start gap-3 rounded-lg bg-red-50 border border-red-200 px-4 py-3" role="alert">
                    <svg class="w-4 h-4 text-red-600 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                        <path fill-rule="evenodd"
                              d="M10 18a8 8 0 100-16 8 8 0 000 16zm-.75-11.25a.75.75 0 011.5 0v4.5a.75.75 0 01-1.5 0v-4.5zm.75 7.5a.75.75 0 100-1.5.75.75 0 000 1.5z"
                              clip-rule="evenodd"/>
                    </svg>
                    <p class="text-sm text-red-700">${error}</p>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-5" id="loginForm" novalidate>

                <!-- Username -->
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="username">Username</label>
                    <input
                        id="username"
                        type="text"
                        name="username"
                        required
                        autocomplete="username"
                        placeholder="Enter your username"
                        class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-800
                               placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                               transition duration-150"
                    >
                </div>

                <!-- Password with show/hide toggle -->
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5" for="password">Password</label>
                    <div class="relative">
                        <input
                            id="password"
                            type="password"
                            name="password"
                            required
                            autocomplete="current-password"
                            placeholder="Enter your password"
                            class="w-full rounded-lg border border-slate-300 bg-white px-3.5 py-2.5 pr-11 text-sm text-slate-800
                                   placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary
                                   transition duration-150"
                        >
                        <!-- Toggle button -->
                        <button
                            type="button"
                            id="togglePassword"
                            aria-label="Toggle password visibility"
                            class="absolute inset-y-0 right-0 flex items-center px-3 text-slate-400 hover:text-slate-600 transition-colors"
                            onclick="
                                var p = document.getElementById('password');
                                var eyeOn = document.getElementById('eyeOn');
                                var eyeOff = document.getElementById('eyeOff');
                                if (p.type === 'password') {
                                    p.type = 'text';
                                    eyeOn.classList.add('hidden');
                                    eyeOff.classList.remove('hidden');
                                } else {
                                    p.type = 'password';
                                    eyeOn.classList.remove('hidden');
                                    eyeOff.classList.add('hidden');
                                }
                            "
                        >
                            <!-- Eye open icon -->
                            <svg id="eyeOn" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                            <!-- Eye closed icon (hidden by default) -->
                            <svg id="eyeOff" class="w-4 h-4 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Submit -->
                <button
                    type="submit"
                    id="submitBtn"
                    class="w-full bg-primary text-white text-sm font-medium px-4 py-2.5 rounded-lg
                           transition-all duration-200 hover:bg-blue-700 hover:scale-[1.02]
                           focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2
                           active:scale-[0.98] disabled:opacity-60 disabled:cursor-not-allowed disabled:scale-100
                           flex items-center justify-center gap-2"
                    onclick="
                        this.disabled = true;
                        document.getElementById('btnText').textContent = 'Signing in…';
                        document.getElementById('btnSpinner').classList.remove('hidden');
                        document.getElementById('loginForm').submit();
                    "
                >
                    <svg id="btnSpinner" class="hidden w-4 h-4 animate-spin" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"/>
                    </svg>
                    <span id="btnText">Sign In</span>
                </button>

            </form>
        </div>

        <p class="text-center text-xs text-slate-400 mt-6">MFlow &copy; 2025 &mdash; Secure Clinical System</p>
    </div>

</body>
</html>
