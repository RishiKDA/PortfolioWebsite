package controller;

import dao.SkillDAO;
import model.Skill;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/admin/SkillServlet")
public class SkillServlet extends HttpServlet {

    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Skill s = buildFromRequest(req);
            skillDAO.addSkill(s);
            req.getSession().setAttribute("successMsg", "Skill added!");

        } else if ("edit".equals(action)) {
            Skill s = buildFromRequest(req);
            s.setId(Integer.parseInt(req.getParameter("id")));
            skillDAO.updateSkill(s);
            req.getSession().setAttribute("successMsg", "Skill updated!");

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            skillDAO.deleteSkill(id);
            req.getSession().setAttribute("successMsg", "Skill deleted.");
        }

        resp.sendRedirect(req.getContextPath() + "/pages/admin/manage_skills.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        if ("delete".equals(req.getParameter("action"))) {
            skillDAO.deleteSkill(Integer.parseInt(req.getParameter("id")));
        }
        resp.sendRedirect(req.getContextPath() + "/pages/admin/manage_skills.jsp");
    }

    private Skill buildFromRequest(HttpServletRequest req) {
        Skill s = new Skill();
        s.setSkillName(req.getParameter("skill_name"));
        s.setCategory(req.getParameter("category"));
        s.setProficiency(Integer.parseInt(req.getParameter("proficiency")));
        return s;
    }

    private boolean isLoggedIn(HttpServletRequest req) {
        HttpSession sess = req.getSession(false);
        return sess != null && sess.getAttribute("loggedInUser") != null;
    }
}
