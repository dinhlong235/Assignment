/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author ASUS
 */
import controller.UsersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;
import model.Users;

public class UsersService {
    private UsersJpaController controller;

    public UsersService() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("EnergyPU");
        controller = new UsersJpaController(emf);
    }

    public void createUser(Users user) throws Exception {
        controller.create(user);
    }

    public void updateUser(Users user) throws Exception {
        controller.edit(user);
    }

    public void deleteUser(int id) throws Exception {
        controller.destroy(id);
    }

    public Users getUser(int id) {
        return controller.findUsers(id);
    }

    public List<Users> getAllUsers() {
        return controller.findUsersEntities();
    }
}