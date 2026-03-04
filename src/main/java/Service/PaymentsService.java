package Service;

import controller.PaymentsJpaController;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.Date;
import java.util.List;
import model.Orders;
import model.Payments;

public class PaymentsService extends BaseService {

    private PaymentsJpaController controller;

    public PaymentsService() {
        controller = new PaymentsJpaController(getEntityManagerFactory());
    }

    public void createPayment(Payments payment) throws Exception {
        controller.create(payment);
    }

    public void updatePayment(Payments payment) throws Exception {
        controller.edit(payment);
    }

    public void deletePayment(int id) throws Exception {
        controller.destroy(id);
    }

    public Payments getPayment(int id) {
        return controller.findPayments(id);
    }

    public List<Payments> getAllPayments() {
        return controller.findPaymentsEntities();
    }

    public void payOrder(int orderId) throws Exception {

        EntityManager em = getEntityManagerFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Orders order = em.find(Orders.class, orderId);

            if (order == null) {
                throw new Exception("Order not found");
            }

            if (order == null || !"pending".equals(order.getStatus())) {
                throw new Exception("Order not valid for payment");
            }

            // 1️⃣ Tạo Payment
            Payments payment = new Payments();
            payment.setOrderId(order);
            payment.setUserId(order.getUserId());
            payment.setAmount(order.getPackageId().getPrice());
            payment.setStatus("success");
            payment.setPaymentDate(new Date());

            em.persist(payment);

            // 2️⃣ Update Order
            order.setStatus("active");
            em.merge(order);

            tx.commit();

        } catch (Exception e) {
            tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
