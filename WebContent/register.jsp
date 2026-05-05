<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("loggedInUser") != null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard.jsp");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Portfolio Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        body { display:flex; align-items:center; justify-content:center; min-height:100vh; }
        .auth-card {
            width:100%; max-width:480px;
            background:var(--bg-card);
            border:1px solid var(--border);
            border-radius:16px;
            padding:3rem;
        }
        .auth-logo { font-family:var(--font-display); font-size:2rem; font-weight:800; color:var(--text); margin-bottom:0.25rem; }
        .auth-logo span { color:var(--cyan); }
        .auth-sub { font-family:var(--font-mono); font-size:0.75rem; color:var(--text-muted); letter-spacing:0.1em; text-transform:uppercase; margin-bottom:2.5rem; }
        .auth-footer { text-align:center; margin-top:1.5rem; font-size:0.85rem; color:var(--text-muted); }
        .auth-footer a { color:var(--cyan); }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-logo">RK<span>.</span></div>
        <div class="auth-sub">Create Admin Account</div>

        <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form id="registerForm" action="<%= request.getContextPath() %>/RegisterServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Choose a username" required>
                <div class="form-error" id="usernameError"></div>
            </div>
            <div class="form-group">
                <label for="regEmail">Email</label>
                <input type="email" id="regEmail" name="email" class="form-control" placeholder="your@email.com" required>
                <div class="form-error" id="regEmailError"></div>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Min 8 characters" required>
                <div class="form-error" id="passwordError"></div>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" class="form-control" placeholder="Repeat password" required>
                <div class="form-error" id="confirmError"></div>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center;">Create Account →</button>
        </form>

        <div class="auth-footer">
            Already have an account? <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
        </div>
    </div>
    <script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
