<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.ProjectDAO, dao.SkillDAO, dao.MessageDAO" %>
<%@ page import="model.User" %>
<%
    User loggedIn = (User) session.getAttribute("loggedInUser");
    if (loggedIn == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    int projectCount = new ProjectDAO().getAllProjects().size();
    int skillCount   = new SkillDAO().getAllSkills().size();
    int msgCount     = new MessageDAO().getAllMessages().size();
    int unreadCount  = new MessageDAO().getUnreadCount();
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Portfolio Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="admin-wrapper">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-logo">RK<span>.</span> Admin</div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/pages/admin/dashboard.jsp"  class="sidebar-link active">📊 Dashboard</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_projects.jsp" class="sidebar-link">🚀 Projects</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_skills.jsp"   class="sidebar-link">💡 Skills</a>
            <a href="<%= request.getContextPath() %>/pages/admin/messages.jsp"        class="sidebar-link">✉️ Messages <% if (unreadCount > 0) { %><span style="background:var(--cyan);color:var(--bg);border-radius:99px;padding:0 6px;font-size:0.7rem;"><%= unreadCount %></span><% } %></a>
            <a href="<%= request.getContextPath() %>/"                               class="sidebar-link">🌐 View Site</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet"                  class="sidebar-link">🚪 Logout</a>
        </nav>
        <div style="padding:1.5rem; font-family:var(--font-mono); font-size:0.72rem; color:var(--text-muted); border-top:1px solid var(--border);">
            Logged in as<br><span style="color:var(--cyan);"><%= loggedIn.getUsername() %></span>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="admin-content">
        <div class="admin-header">
            <h1 class="admin-title">Dashboard</h1>
            <div style="font-family:var(--font-mono); font-size:0.78rem; color:var(--text-muted);">
                Welcome back, <span style="color:var(--cyan);"><%= loggedIn.getUsername() %></span>
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Total Projects</div>
                <div class="stat-number"><%= projectCount %></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Total Skills</div>
                <div class="stat-number"><%= skillCount %></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Messages</div>
                <div class="stat-number"><%= msgCount %></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Unread Messages</div>
                <div class="stat-number" style="<%= unreadCount > 0 ? "color:#ff6b6b;" : "" %>"><%= unreadCount %></div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div style="margin-top:2rem;">
            <h2 style="font-family:var(--font-display); font-size:1.2rem; font-weight:700; color:var(--text); margin-bottom:1.5rem;">Quick Actions</h2>
            <div style="display:flex; gap:1rem; flex-wrap:wrap;">
                <a href="<%= request.getContextPath() %>/pages/admin/manage_projects.jsp" class="btn btn-primary">+ Add Project</a>
                <a href="<%= request.getContextPath() %>/pages/admin/manage_skills.jsp"   class="btn btn-outline">+ Add Skill</a>
                <a href="<%= request.getContextPath() %>/pages/admin/messages.jsp"        class="btn btn-outline">View Messages</a>
                <a href="<%= request.getContextPath() %>/" target="_blank"                class="btn btn-outline">View Live Site ↗</a>
            </div>
        </div>

        <!-- System Info -->
        <div style="margin-top:3rem;" class="card">
            <h3 style="font-family:var(--font-display); font-size:1rem; font-weight:700; color:var(--text); margin-bottom:1rem;">System Info</h3>
            <div style="font-family:var(--font-mono); font-size:0.78rem; color:var(--text-muted); display:flex; flex-direction:column; gap:0.5rem;">
                <span>Java Version: <%= System.getProperty("java.version") %></span>
                <span>Servlet Container: <%= application.getServerInfo() %></span>
                <span>Session Created: <%= new java.util.Date(session.getCreationTime()) %></span>
            </div>
        </div>
    </main>
</div>
<script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
