<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MessageDAO" %>
<%@ page import="model.Message, model.User" %>
<%@ page import="java.util.List" %>
<%
    // ── Auth Guard ──────────────────────────────────────────
    User loggedIn = (User) session.getAttribute("loggedInUser");
    if (loggedIn == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    MessageDAO msgDAO       = new MessageDAO();
    List<Message> messages  = msgDAO.getAllMessages();
    int unreadCount         = msgDAO.getUnreadCount();

    // Mark message as read if action passed
    String markId = request.getParameter("markRead");
    if (markId != null) {
        msgDAO.markRead(Integer.parseInt(markId));
        response.sendRedirect(request.getContextPath() + "/pages/admin/messages.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages — Portfolio Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .msg-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: border-color var(--transition);
            position: relative;
        }
        .msg-card.unread {
            border-left: 3px solid var(--cyan);
        }
        .msg-card:hover {
            border-color: var(--border-glow);
        }
        .msg-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .msg-sender {
            font-family: var(--font-display);
            font-size: 1rem;
            font-weight: 700;
            color: var(--text);
        }
        .msg-email {
            font-family: var(--font-mono);
            font-size: 0.75rem;
            color: var(--cyan);
            margin-top: 0.2rem;
        }
        .msg-time {
            font-family: var(--font-mono);
            font-size: 0.7rem;
            color: var(--text-muted);
            white-space: nowrap;
        }
        .msg-subject {
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--text-muted);
            margin-bottom: 0.5rem;
        }
        .msg-body {
            font-size: 0.88rem;
            color: var(--text-muted);
            line-height: 1.7;
            background: var(--bg-2);
            border-radius: 8px;
            padding: 1rem;
            margin-top: 0.75rem;
            border: 1px solid var(--border);
        }
        .msg-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        .badge-unread {
            font-family: var(--font-mono);
            font-size: 0.65rem;
            background: var(--cyan);
            color: var(--bg);
            padding: 0.2rem 0.6rem;
            border-radius: 99px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .badge-read {
            font-family: var(--font-mono);
            font-size: 0.65rem;
            background: var(--bg-2);
            color: var(--text-muted);
            padding: 0.2rem 0.6rem;
            border-radius: 99px;
            border: 1px solid var(--border);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-muted);
        }
        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.4;
        }
        .filter-bar {
            display: flex;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            align-items: center;
        }
        .count-tag {
            font-family: var(--font-mono);
            font-size: 0.75rem;
            color: var(--text-muted);
            padding: 0.35rem 0.85rem;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 99px;
        }
        .count-tag strong { color: var(--cyan); }
    </style>
</head>
<body>
<div class="admin-wrapper">

    <!-- ── Sidebar ──────────────────────────────────────── -->
    <aside class="sidebar">
        <div class="sidebar-logo">RK<span>.</span> Admin</div>
        <nav class="sidebar-nav">
            <a href="<%= request.getContextPath() %>/pages/admin/dashboard.jsp"
               class="sidebar-link">📊 Dashboard</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_projects.jsp"
               class="sidebar-link">🚀 Projects</a>
            <a href="<%= request.getContextPath() %>/pages/admin/manage_skills.jsp"
               class="sidebar-link">💡 Skills</a>
            <a href="<%= request.getContextPath() %>/pages/admin/messages.jsp"
               class="sidebar-link active">
                ✉️ Messages
                <% if (unreadCount > 0) { %>
                <span style="background:var(--cyan);color:var(--bg);border-radius:99px;
                             padding:0 6px;font-size:0.7rem;margin-left:auto;">
                    <%= unreadCount %>
                </span>
                <% } %>
            </a>
            <a href="<%= request.getContextPath() %>/"
               class="sidebar-link">🌐 View Site</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet"
               class="sidebar-link">🚪 Logout</a>
        </nav>
        <div style="padding:1.5rem;font-family:var(--font-mono);font-size:0.72rem;
                    color:var(--text-muted);border-top:1px solid var(--border);">
            Logged in as<br>
            <span style="color:var(--cyan);"><%= loggedIn.getUsername() %></span>
        </div>
    </aside>

    <!-- ── Main Content ─────────────────────────────────── -->
    <main class="admin-content">

        <!-- Header -->
        <div class="admin-header">
            <h1 class="admin-title">Messages</h1>
            <div style="font-family:var(--font-mono);font-size:0.78rem;color:var(--text-muted);">
                Inbox from Contact Form
            </div>
        </div>

        <!-- Filter / Count Bar -->
        <div class="filter-bar">
            <div class="count-tag">
                Total: <strong><%= messages.size() %></strong>
            </div>
            <div class="count-tag">
                Unread: <strong><%= unreadCount %></strong>
            </div>
            <div class="count-tag">
                Read: <strong><%= messages.size() - unreadCount %></strong>
            </div>
        </div>

        <!-- Message List -->
        <% if (messages.isEmpty()) { %>
        <div class="empty-state">
            <div class="empty-icon">📭</div>
            <p style="font-family:var(--font-display);font-size:1.2rem;font-weight:700;
                      color:var(--text);margin-bottom:0.5rem;">
                No Messages Yet
            </p>
            <p>When visitors fill the contact form, their messages appear here.</p>
        </div>

        <% } else { %>
        <% for (Message msg : messages) { %>
        <div class="msg-card <%= !msg.isRead() ? "unread" : "" %>">

            <div class="msg-header">
                <div>
                    <div class="msg-sender">
                        <%= msg.getSenderName() %>
                        &nbsp;
                        <% if (!msg.isRead()) { %>
                        <span class="badge-unread">New</span>
                        <% } else { %>
                        <span class="badge-read">Read</span>
                        <% } %>
                    </div>
                    <div class="msg-email">
                        <a href="mailto:<%= msg.getSenderEmail() %>">
                            <%= msg.getSenderEmail() %>
                        </a>
                    </div>
                </div>
                <div class="msg-time">
                    <%
                        java.text.SimpleDateFormat sdf =
                            new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
                        out.print(msg.getSentAt() != null
                            ? sdf.format(msg.getSentAt()) : "—");
                    %>
                </div>
            </div>

            <div class="msg-subject">
                📌 Subject: <%= msg.getSubject() != null ? msg.getSubject() : "No Subject" %>
            </div>

            <div class="msg-body">
                <%= msg.getMessage() %>
            </div>

            <div class="msg-actions">
                <!-- Reply via email -->
                <a href="mailto:<%= msg.getSenderEmail() %>?subject=Re: <%= msg.getSubject() %>"
                   class="btn btn-primary btn-sm">
                    Reply ↗
                </a>

                <!-- Mark as read -->
                <% if (!msg.isRead()) { %>
                <a href="<%= request.getContextPath() %>/pages/admin/messages.jsp?markRead=<%= msg.getId() %>"
                   class="btn btn-outline btn-sm">
                    Mark as Read
                </a>
                <% } %>
            </div>

        </div>
        <% } %>
        <% } %>

    </main>
</div>

<script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
