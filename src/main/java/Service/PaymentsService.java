package Service;

import controller.PaymentsJpaController;
import java.util.List;
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
}