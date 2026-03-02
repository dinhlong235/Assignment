package Service;

import controller.UsersJpaController;
import java.util.List;
import model.Users;

public class UsersService extends BaseService {

    private UsersJpaController controller;

    public UsersService() {
        controller = new UsersJpaController(getEntityManagerFactory());
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