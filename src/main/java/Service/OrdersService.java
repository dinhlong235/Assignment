package Service;

import controller.OrdersJpaController;
import jakarta.persistence.EntityManager;
import java.util.List;
import model.Orders;

public class OrdersService extends BaseService {

    private OrdersJpaController controller;

    public OrdersService() {
        controller = new OrdersJpaController(getEntityManagerFactory());
    }

    public void createOrder(Orders order) throws Exception {
        controller.create(order);
    }

    public void updateOrder(Orders order) throws Exception {
        controller.edit(order);
    }

    public void deleteOrder(int id) throws Exception {
        controller.destroy(id);
    }

    public Orders getOrder(int id) {
        return controller.findOrders(id);
    }

    public List<Orders> getAllOrders() {
        return controller.findOrdersEntities();
    }

    public Orders findPendingOrderByUser(int userId) {
        EntityManager em = getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT o FROM Orders o WHERE o.userId.userId = :uid AND o.status = :status",
                    Orders.class
            )
                    .setParameter("uid", userId)
                    .setParameter("status", "pending")
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }

    public Orders findActiveOrderByUser(int userId) {
        EntityManager em = getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT o FROM Orders o WHERE o.userId.userId = :uid AND o.status = :status",
                    Orders.class
            )
                    .setParameter("uid", userId)
                    .setParameter("status", "active")
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }

    public Orders findAnyOrderByUser(int userId) {
        EntityManager em = getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT o FROM Orders o WHERE o.userId.userId = :uid",
                    Orders.class
            )
                    .setParameter("uid", userId)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }
}
