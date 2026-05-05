<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.SkillDAO, dao.MessageDAO" %>
<%@ page import="model.Skill, model.User" %>
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
    List<Skill> skills = new SkillDAO().getAllSkills();
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
    <title>Manage Skills — Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="admin-wrapper">
    <aside class="sidebar">
        <div class="sidebar-logo">RK<span>.</span> Admin</div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/pages/admin/dashboard.jsp"       class="sidebar-link">📊 Dashboard</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_projects.jsp" class="sidebar-link">🚀 Projects</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_skills.jsp"   class="sidebar-link active">💡 Skills</a>
            <a href="<%= request.getContextPath() %>/pages/admin/messages.jsp"        class="sidebar-link">✉️ Messages <% if (unreadCount > 0) { %><span style="background:var(--cyan);color:var(--bg);border-radius:99px;padding:0 6px;font-size:0.7rem;"><%= unreadCount %></span><% } %></a>
            <a href="<%= request.getContextPath() %>/"                               class="sidebar-link">🌐 View Site</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet"                  class="sidebar-link">🚪 Logout</a>
        </nav>
    </aside>

    <main class="admin-content">
        <div class="admin-header">
            <h1 class="admin-title">Manage Skills</h1>
            <button type="button" class="btn btn-primary" onclick="openModal('addSkillModal')">+ Add Skill</button>
        </div>

        <% if (successMsg != null) { %><div class="alert alert-success"><%= successMsg %></div><% } %>
        <% if (errorMsg   != null) { %><div class="alert alert-danger"><%= errorMsg %></div><% } %>

        <div class="card">
            <% if (skills.isEmpty()) { %>
            <p style="color:var(--text-muted); text-align:center; padding:2rem;">No skills found. Add one!</p>
            <% } else { %>
            <table class="admin-table">
                <thead>
                    <tr><th>#</th><th>Skill Name</th><th>Category</th><th>Proficiency</th><th>Actions</th></tr>
                </thead>
                <tbody>
                    <% int idx = 1; for (Skill s : skills) { %>
                    <tr>
                        <td><%= idx++ %></td>
                        <td><strong><%= s.getSkillName() %></strong></td>
                        <td><span class="tag"><%= s.getCategory() %></span></td>
                        <td>
                            <div style="display:flex; align-items:center; gap:0.75rem;">
                                <div style="flex:1; background:var(--bg-2); border-radius:4px; height:6px; overflow:hidden; max-width:120px;">
                                    <div style="width:<%= s.getProficiency() %>%; height:100%; background:var(--cyan); border-radius:4px;"></div>
                                </div>
                                <span style="font-family:var(--font-mono); font-size:0.75rem; color:var(--cyan);"><%= s.getProficiency() %>%</span>
                            </div>
                        </td>
                        <td style="display:flex; gap:0.5rem;">
                            <button type="button" class="btn btn-outline btn-sm edit-skill-btn"
                                data-id="<%= s.getId() %>"
                                data-skillname="<%= escapeHtmlAttr(s.getSkillName()) %>"
                                data-category="<%= escapeHtmlAttr(s.getCategory()) %>"
                                data-proficiency="<%= s.getProficiency() %>">Edit</button>
                            <form id="deleteSkill<%= s.getId() %>" action="<%= request.getContextPath() %>/admin/SkillServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this skill? This action cannot be undone.');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id"     value="<%= s.getId() %>">
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

<!-- Add Skill Modal -->
<div class="modal-overlay" id="addSkillModal">
    <div class="modal">
        <div class="modal-title">Add New Skill</div>
        <form action="<%= request.getContextPath() %>/admin/SkillServlet" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>Skill Name *</label>
                <input type="text" name="skill_name" class="form-control" placeholder="e.g. TensorFlow" required>
            </div>
            <div class="form-group">
                <label>Category *</label>
                <select name="category" class="form-control" required>
                    <option value="language">Language</option>
                    <option value="library">Library</option>
                    <option value="tool">Tool</option>
                </select>
            </div>
            <div class="form-group">
                <label>Proficiency: <span id="profDisplay">80</span>%</label>
                <input type="range" name="proficiency" min="0" max="100" value="80" class="form-control"
                    oninput="document.getElementById('profDisplay').textContent=this.value">
            </div>
            <div style="display:flex; gap:1rem; margin-top:1.5rem;">
                <button type="submit" class="btn btn-primary">Add Skill</button>
                <button type="button" class="btn btn-outline" onclick="closeModal('addSkillModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Skill Modal -->
<div class="modal-overlay" id="editSkillModal">
    <div class="modal">
        <div class="modal-title">Edit Skill</div>
        <form action="<%= request.getContextPath() %>/admin/SkillServlet" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="editSkillId">
            <div class="form-group">
                <label>Skill Name *</label>
                <input type="text" name="skill_name" id="editSkillName" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Category *</label>
                <select name="category" id="editSkillCategory" class="form-control" required>
                    <option value="language">Language</option>
                    <option value="library">Library</option>
                    <option value="tool">Tool</option>
                </select>
            </div>
            <div class="form-group">
                <label>Proficiency: <span id="editProfDisplay">80</span>%</label>
                <input type="range" name="proficiency" id="editSkillProficiency" min="0" max="100" value="80"
                    class="form-control"
                    oninput="document.getElementById('editProfDisplay').textContent=this.value">
            </div>
            <div style="display:flex; gap:1rem; margin-top:1.5rem;">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <button type="button" class="btn btn-outline" onclick="closeModal('editSkillModal')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script src="<%= request.getContextPath() %>/js/main.js"></script>
<script>
// Sync proficiency display on modal open
const editProf = document.getElementById('editSkillProficiency');
if (editProf) {
    editProf.addEventListener('input', () => {
        document.getElementById('editProfDisplay').textContent = editProf.value;
    });
}
</script>
</body>
</html>
