<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Redirect if already logged in
    if (session.getAttribute("loggedInUser") != null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard.jsp");
        return;
    }
    String error = (String) request.getAttribute("error");
    String regSuccess = (String) session.getAttribute("regSuccess");
    if (regSuccess != null) session.removeAttribute("regSuccess");
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login — Rishi Kedia Portfolio</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        body { display:flex; align-items:center; justify-content:center; min-height:100vh; }
        .auth-card {
            width: 100%; max-width: 440px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 3rem;
        }
        .auth-logo {
            font-family: var(--font-display);
            font-size: 2rem; font-weight: 800;
            color: var(--text); margin-bottom: 0.25rem;
        }
        .auth-logo span { color: var(--cyan); }
        .auth-sub {
            font-family: var(--font-mono);
            font-size: 0.75rem; color: var(--text-muted);
            letter-spacing: 0.1em; text-transform: uppercase;
            margin-bottom: 2.5rem;
        }
        .auth-footer {
            text-align: center; margin-top: 2rem;
            font-size: 0.85rem; color: var(--text-muted);
        }
        .auth-footer a { color: var(--cyan); }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-logo">RK<span>.</span></div>
        <div class="auth-sub">Admin Login</div>

        <% if (regSuccess != null) { %>
        <div class="alert alert-success"><%= regSuccess %></div>
        <% } %>
        <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Enter username" required autocomplete="username">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required autocomplete="current-password">
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center;">Login →</button>
        </form>

        <div class="auth-footer">
            Don't have an account? <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
        </div>
        <div class="auth-footer" style="margin-top:0.75rem;">
            <a href="<%= request.getContextPath() %>/">← Back to Portfolio</a>
        </div>
    </div>
    <script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
