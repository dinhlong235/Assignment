/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author ASUS
 */
import controller.PaymentsJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;
import model.Payments;

public class PaymentsService {
    private PaymentsJpaController controller;

    public PaymentsService() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("EnergyPU");
        controller = new PaymentsJpaController(emf);
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