package Service;

import controller.OrdersJpaController;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Orders;
import model.Payments;
import model.ServicePackages;
import model.Users;

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

    public boolean hasActiveOrPendingOrder(int userId) {

        List<Orders> list = controller.findOrdersEntities();

        for (Orders o : list) {

            if (o.getUserId().getUserId() == userId
                    && ("active".equalsIgnoreCase(o.getStatus())
                    || "pending".equalsIgnoreCase(o.getStatus()))) {

                return true;
            }
        }

        return false;
    }

    public void createOrder(int userId, int packageId) {

        EntityManager em = getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Users user = em.find(Users.class, userId);
            ServicePackages pack = em.find(ServicePackages.class, packageId);

            Orders order = new Orders();
            order.setUserId(user);
            order.setPackageId(pack);
            order.setOrderDate(new Date());
            order.setStatus("pending");

            em.persist(order);

            Payments payment = new Payments();
            payment.setUserId(user);
            payment.setOrderId(order);
            payment.setAmount(pack.getPrice());
            payment.setPaymentDate(new Date());
            payment.setStatus("pending");

            em.persist(payment);

            tx.commit();

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    private void createPaymentForOrder(Orders order) {

        EntityManager em = getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Orders managedOrder = em.find(Orders.class, order.getOrderId());
            Users managedUser = em.find(Users.class, order.getUserId().getUserId());

            Payments payment = new Payments();
            payment.setOrderId(managedOrder);
            payment.setUserId(managedUser);
            payment.setAmount(order.getPackageId().getPrice());
            payment.setPaymentDate(new Date());
            payment.setStatus("pending");

            em.persist(payment);

            tx.commit();

        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public void approveOrder(int orderId) throws Exception {

        Orders order = controller.findOrders(orderId);

        if (order == null) {
            throw new Exception("Order not found");
        }

        int userId = order.getUserId().getUserId();

        // Kiểm tra có active khác không (loại trừ chính nó)
        List<Orders> list = controller.findOrdersEntities();

        for (Orders o : list) {

            if (o.getUserId().getUserId() == userId
                    && o.getOrderId() != orderId
                    && "active".equalsIgnoreCase(o.getStatus())) {

                throw new Exception("User already has another active package");
            }
        }

        order.setStatus("active");
        controller.edit(order);

        Users user = order.getUserId();
        user.setUserType("household");

        new UsersService().updateUser(user);
    }

    public void cancelOrder(int orderId) throws Exception {

        Orders order = controller.findOrders(orderId);

        if (order == null) {
            throw new Exception("Order not found");
        }

        order.setStatus("cancelled");
        controller.edit(order);

        // reset user type
        Users user = order.getUserId();
        user.setUserType(null);

        new UsersService().updateUser(user);
    }

    public List<Orders> getOrdersByUser(int userId) {

        List<Orders> list = controller.findOrdersEntities();
        List<Orders> result = new ArrayList<>();

        for (Orders o : list) {
            if (o.getUserId().getUserId() == userId) {
                result.add(o);
            }
        }

        return result;
    }

    public Orders findOrderByUserAndStatus(int userId, String status) {

        List<Orders> list = controller.findOrdersEntities();

        for (Orders o : list) {
            if (o.getUserId().getUserId() == userId
                    && status.equalsIgnoreCase(o.getStatus())) {
                return o;
            }
        }

        return null;
    }

    public List<Orders> getOrdersByStatus(String status) {
        List<Orders> list = controller.findOrdersEntities();
        List<Orders> result = new ArrayList<>();

        for (Orders o : list) {
            if (status.equalsIgnoreCase(o.getStatus())) {
                result.add(o);
            }
        }
        return result;
    }

    public List<Payments> getPaymentsByOrder(int orderId) {
        EntityManager em = getEntityManagerFactory().createEntityManager();

        try {
            return em.createQuery(
                    "SELECT p FROM Payments p WHERE p.orderId.orderId = :id",
                    Payments.class)
                    .setParameter("id", orderId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
