package uz.oasis.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.oasis.demo.entity.User;
import uz.oasis.demo.repo.UserRepo;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "File download servlet", urlPatterns = "/file")
public class FileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String part = req.getParameter("part");
        if (id != null) {
            UserRepo userRepo = new UserRepo();
            UUID userId = UUID.fromString(id);
            User userById = userRepo.findById(userId);
            resp.getOutputStream().write(userById.getProfileImage());
        } else if (part != null) {
            byte[] profileImage = (byte[]) req.getSession().getAttribute("profileImage");
            resp.getOutputStream().write(profileImage);
        }
    }
}
