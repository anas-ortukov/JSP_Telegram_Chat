package uz.oasis.demo;

import com.github.javafaker.Faker;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.mindrot.jbcrypt.BCrypt;
import uz.oasis.demo.entity.User;
import uz.oasis.demo.repo.UserRepo;

@WebListener
public class DBInitializer implements ServletContextListener {


    @Override
    public void contextInitialized(ServletContextEvent sce) {
        UserRepo userRepo = new UserRepo();
        if (userRepo.findAll().isEmpty()) {
            int i = 0;
            while (i < 10) {
                Faker faker = new Faker();
                String password = "123";
                String hashpw = BCrypt.hashpw(password, BCrypt.gensalt());
                User user = User.builder()
                        .email(faker.internet().emailAddress())
                        .password(hashpw)
                        .name(faker.name().firstName())
                        .build();
                userRepo.save(user);
                i++;
            }
        }
        ServletContextListener.super.contextInitialized(sce);
    }
}
