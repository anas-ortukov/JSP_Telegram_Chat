package uz.oasis.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.oasis.demo.entity.Message;
import uz.oasis.demo.entity.User;
import uz.oasis.demo.repo.MessageRepo;
import uz.oasis.demo.repo.UserRepo;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "Chat Servlet", urlPatterns = "/chat")
public class ChatServlet extends HttpServlet {

    UserRepo userRepo = new UserRepo();
    MessageRepo messageRepo = new MessageRepo();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null) {
            resp.sendRedirect("/404");
            return;
        }
        UUID userId = UUID.fromString(id);
        req.getSession().setAttribute("receiverId", userId);
        resp.sendRedirect("/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object object = req.getSession().getAttribute("receiverId");
        User sender = (User)req.getSession().getAttribute("currentUser");
        String msg = req.getParameter("message");
        if (object != null) {
            UUID receiverId = UUID.fromString(object.toString());
            Message message = Message.builder()
                    .text(msg)
                    .sender(sender)
                    .receiver(userRepo.findById(receiverId))
                    .build();
            messageRepo.save(message);
            resp.sendRedirect("/index.jsp");
        }
    }
}
