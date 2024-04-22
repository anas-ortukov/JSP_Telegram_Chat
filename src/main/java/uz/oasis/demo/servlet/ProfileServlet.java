package uz.oasis.demo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import uz.oasis.demo.entity.User;
import uz.oasis.demo.repo.UserRepo;

import java.io.IOException;

@MultipartConfig
@WebServlet(name = "Profile servlet", urlPatterns = "/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        Object object = req.getSession().getAttribute("profileImage");
        User user = (User) req.getSession().getAttribute("currentUser");
        UserRepo userRepo = new UserRepo();
        userRepo.begin();
        User currentUser = userRepo.findById(user.getId());
        if (name != null) {
            currentUser.setName(name);
        }
        if (object != null) {
            byte[] profileImage = (byte[]) object;
            currentUser.setProfileImage(profileImage);
        }
        userRepo.commit();
        resp.sendRedirect("/");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part profileImage = req.getPart("profileImage");
        req.getSession().setAttribute("profileImage", profileImage.getInputStream().readAllBytes());
        resp.sendRedirect("/profile.jsp");
    }
}
