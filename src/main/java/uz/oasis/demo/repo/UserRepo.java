package uz.oasis.demo.repo;

import uz.oasis.demo.entity.User;

import java.util.Optional;
import java.util.UUID;

public class UserRepo extends BaseRepo<User, UUID> {


    public Optional<User> findByEmail(String email) {
        return findAll().stream().filter(u -> u.getEmail().equals(email)).findFirst();
    }
}
