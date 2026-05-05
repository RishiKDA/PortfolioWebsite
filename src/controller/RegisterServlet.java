package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirm_password");

        // Server-side validation
        if (username == null || username.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()    ||
            password == null || password.isEmpty()) {
            setError(req, resp, "All fields are required.");
            return;
        }
        if (!password.equals(confirm)) {
            setError(req, resp, "Passwords do not match.");
            return;
        }
        if (password.length() < 8) {
            setError(req, resp, "Password must be at least 8 characters.");
            return;
        }
        if (userDAO.usernameExists(username)) {
            setError(req, resp, "Username already taken.");
            return;
        }
        if (userDAO.emailExists(email)) {
            setError(req, resp, "Email already registered.");
            return;
        }

        boolean success = userDAO.register(username, email, password);
        if (success) {
            req.getSession().setAttribute("regSuccess", "Registration successful! Please login.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            setError(req, resp, "Registration failed. Please try again.");
        }
    }

    private void setError(HttpServletRequest req, HttpServletResponse resp, String msg)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/register.jsp");
    }
}
