package controller;

import dao.ProjectDAO;
import model.Project;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/admin/ProjectServlet")
public class ProjectServlet extends HttpServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Auth check
        if (!isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Project p = buildFromRequest(req);
            if (projectDAO.addProject(p)) {
                setSuccess(req, resp, "Project added successfully!");
            } else {
                setError(req, resp, "Failed to add project.");
            }

        } else if ("edit".equals(action)) {
            Project p = buildFromRequest(req);
            p.setId(Integer.parseInt(req.getParameter("id")));
            if (projectDAO.updateProject(p)) {
                setSuccess(req, resp, "Project updated successfully!");
            } else {
                setError(req, resp, "Failed to update project.");
            }

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            if (projectDAO.deleteProject(id)) {
                setSuccess(req, resp, "Project deleted.");
            } else {
                setError(req, resp, "Failed to delete project.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            projectDAO.deleteProject(id);
        }
        resp.sendRedirect(req.getContextPath() + "/pages/admin/manage_projects.jsp");
    }

    private Project buildFromRequest(HttpServletRequest req) {
        Project p = new Project();
        p.setTitle(req.getParameter("title"));
        p.setDescription(req.getParameter("description"));
        p.setTechStack(req.getParameter("tech_stack"));
        p.setGithubUrl(req.getParameter("github_url"));
        p.setLiveUrl(req.getParameter("live_url"));
        p.setImageUrl(req.getParameter("image_url"));
        return p;
    }

    private boolean isLoggedIn(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s != null && s.getAttribute("loggedInUser") != null;
    }

    private void setSuccess(HttpServletRequest req, HttpServletResponse resp, String msg)
            throws IOException {
        req.getSession().setAttribute("successMsg", msg);
        resp.sendRedirect(req.getContextPath() + "/pages/admin/manage_projects.jsp");
    }

    private void setError(HttpServletRequest req, HttpServletResponse resp, String msg)
            throws IOException {
        req.getSession().setAttribute("errorMsg", msg);
        resp.sendRedirect(req.getContextPath() + "/pages/admin/manage_projects.jsp");
    }
}
