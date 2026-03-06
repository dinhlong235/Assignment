package Service;

import controller.UsersJpaController;
import jakarta.persistence.EntityManager;
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

    public Users login(String username, String password) {

        for (Users u : controller.findUsersEntities()) {

            if (u.getName().equals(username)
                    && u.getPasswordHash().equals(password)) {

                return u;
            }
        }

        return null;
    }

    public List<Users> getRecentUsers(int limit) {

        EntityManager em = getEntityManagerFactory().createEntityManager();

        try {

            return em.createQuery(
                    "SELECT u FROM Users u ORDER BY u.userId DESC",
                    Users.class
            )
                    .setMaxResults(limit)
                    .getResultList();

        } finally {
            em.close();
        }
    }
}
