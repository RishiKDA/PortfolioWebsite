<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.ProjectDAO, dao.MessageDAO" %>
<%@ page import="model.Project, model.User" %>
<%@ page import="java.util.List" %>
<%! 
    private String escapeHtmlAttr(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;")
                    .replace("\r", " ")
                    .replace("\n", " ");
    }
%>
<%
    User loggedIn = (User) session.getAttribute("loggedInUser");
    if (loggedIn == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<Project> projects = new ProjectDAO().getAllProjects();
    int unreadCount = new MessageDAO().getUnreadCount();

    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg   = (String) session.getAttribute("errorMsg");
    if (successMsg != null) session.removeAttribute("successMsg");
    if (errorMsg   != null) session.removeAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Projects — Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="admin-wrapper">
    <aside class="sidebar">
        <div class="sidebar-logo">RK<span>.</span> Admin</div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/pages/admin/dashboard.jsp"       class="sidebar-link">📊 Dashboard</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_projects.jsp" class="sidebar-link active">🚀 Projects</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_skills.jsp"   class="sidebar-link">💡 Skills</a>
            <a href="<%= request.getContextPath() %>/pages/admin/messages.jsp"        class="sidebar-link">✉️ Messages <% if (unreadCount > 0) { %><span style="background:var(--cyan);color:var(--bg);border-radius:99px;padding:0 6px;font-size:0.7rem;"><%= unreadCount %></span><% } %></a>
            <a href="<%= request.getContextPath() %>/"                               class="sidebar-link">🌐 View Site</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet"                  class="sidebar-link">🚪 Logout</a>
        </nav>
    </aside>

    <main class="admin-content">
        <div class="admin-header">
            <h1 class="admin-title">Manage Projects</h1>
            <button type="button" class="btn btn-primary" onclick="openModal('addProjectModal')">+ Add Project</button>
        </div>

        <% if (successMsg != null) { %><div class="alert alert-success"><%= successMsg %></div><% } %>
        <% if (errorMsg   != null) { %><div class="alert alert-danger"><%= errorMsg %></div><% } %>

        <!-- Projects Table -->
        <div class="card">
            <% if (projects.isEmpty()) { %>
            <p style="color:var(--text-muted); text-align:center; padding:2rem;">No projects found. Add one!</p>
            <% } else { %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Tech Stack</th>
                        <th>GitHub</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% int idx = 1; for (Project p : projects) { %>
                    <tr>
                        <td><%= idx++ %></td>
                        <td><strong><%= p.getTitle() %></strong></td>
                        <td style="font-size:0.8rem; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;"><%= p.getTechStack() != null ? p.getTechStack() : "—" %></td>
                        <td>
                            <% if (p.getGithubUrl() != null && !p.getGithubUrl().isEmpty()) { %>
                            <a href="<%= p.getGithubUrl() %>" target="_blank" class="btn btn-outline btn-sm">View ↗</a>
                            <% } else { %><span style="color:var(--text-dim);">—</span><% } %>
                        </td>
                        <td style="display:flex; gap:0.5rem; flex-wrap:wrap;">
                            <button type="button" class="btn btn-outline btn-sm edit-project-btn"
                                data-id="<%= p.getId() %>"
                                data-title="<%= escapeHtmlAttr(p.getTitle()) %>"
                                data-description="<%= escapeHtmlAttr(p.getDescription()) %>"
                                data-techstack="<%= escapeHtmlAttr(p.getTechStack()) %>"
                                data-githuburl="<%= escapeHtmlAttr(p.getGithubUrl()) %>"
                                data-liveurl="<%= escapeHtmlAttr(p.getLiveUrl()) %>">Edit</button>
                            <form id="deleteProject<%= p.getId() %>" action="<%= request.getContextPath() %>/admin/ProjectServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this project? This action cannot be undone.');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id"     value="<%= p.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </main>
</div>

<!-- ── Add Project Modal ─── -->
<div class="modal-overlay" id="addProjectModal">
    <div class="modal">
        <div class="modal-title">Add New Project</div>
        <form action="<%= request.getContextPath() %>/admin/ProjectServlet" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group"><label>Title *</label><input type="text" name="title" class="form-control" required></div>
            <div class="form-group"><label>Description</label><textarea name="description" class="form-control"></textarea></div>
            <div class="form-group"><label>Tech Stack (comma-separated)</label><input type="text" name="tech_stack" class="form-control" placeholder="Python, NumPy, Scikit-learn"></div>
            <div class="form-group"><label>GitHub URL</label><input type="url" name="github_url" class="form-control"></div>
            <div class="form-group"><label>Live URL</label><input type="url" name="live_url" class="form-control"></div>
            <div class="form-group"><label>Image URL</label><input type="url" name="image_url" class="form-control"></div>
            <div style="display:flex; gap:1rem; margin-top:1.5rem;">
                <button type="submit" class="btn btn-primary">Add Project</button>
                <button type="button" class="btn btn-outline" onclick="closeModal('addProjectModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- ── Edit Project Modal ─── -->
<div class="modal-overlay" id="editProjectModal">
    <div class="modal">
        <div class="modal-title">Edit Project</div>
        <form action="<%= request.getContextPath() %>/admin/ProjectServlet" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="editProjectId">
            <div class="form-group"><label>Title *</label><input type="text" name="title" id="editTitle" class="form-control" required></div>
            <div class="form-group"><label>Description</label><textarea name="description" id="editDescription" class="form-control"></textarea></div>
            <div class="form-group"><label>Tech Stack</label><input type="text" name="tech_stack" id="editTechStack" class="form-control"></div>
            <div class="form-group"><label>GitHub URL</label><input type="url" name="github_url" id="editGithubUrl" class="form-control"></div>
            <div class="form-group"><label>Live URL</label><input type="url" name="live_url" id="editLiveUrl" class="form-control"></div>
            <div style="display:flex; gap:1rem; margin-top:1.5rem;">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <button type="button" class="btn btn-outline" onclick="closeModal('editProjectModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
