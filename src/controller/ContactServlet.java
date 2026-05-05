package controller;


import model.Message;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    // Using inner class reference — MessageDAO is package-private in PortfolioDAOs.java
    // For simplicity, we inline the DB call here using direct DAO instantiation via reflection or we re-expose it.
    // Since PortfolioDAOs defines MessageDAO as package-private, we put ContactServlet in dao package OR
    // make MessageDAO public. For production, make it public. Here we use a direct approach:

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String name    = req.getParameter("name");
        String email   = req.getParameter("email");
        String subject = req.getParameter("subject");
        String body    = req.getParameter("message");

        // Basic server-side validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            body == null || body.trim().isEmpty()) {
            req.setAttribute("contactError", "Name, email, and message are required.");
            req.getRequestDispatcher("/pages/public/contact.jsp").forward(req, resp);
            return;
        }

        Message msg = new Message();
        msg.setSenderName(name.trim());
        msg.setSenderEmail(email.trim());
        msg.setSubject(subject != null ? subject.trim() : "No Subject");
        msg.setMessage(body.trim());

        dao.MessageDAO msgDAO = new dao.MessageDAO();
        boolean saved = msgDAO.saveMessage(msg);

        if (saved) {
            req.getSession().setAttribute("contactSuccess",
                "Thank you, " + name.trim() + "! Your message has been sent.");
            resp.sendRedirect(req.getContextPath() + "/pages/public/contact.jsp");
        } else {
            req.setAttribute("contactError", "Failed to send message. Please try again.");
            req.getRequestDispatcher("/pages/public/contact.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/pages/public/contact.jsp");
    }
}
