/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author ASUS
 */
import controller.OrdersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

import model.Orders;

public class OrdersService {

    private OrdersJpaController controller;

    public OrdersService() {

        EntityManagerFactory emf =
                Persistence.createEntityManagerFactory("EnergyPU");

        controller = new OrdersJpaController(emf);
    }

    // CREATE
    public void createOrder(Orders order) throws Exception {
        controller.create(order);
    }

    // UPDATE
    public void updateOrder(Orders order) throws Exception {
        controller.edit(order);
    }

    // DELETE
    public void deleteOrder(int id) throws Exception {
        controller.destroy(id);
    }

    // GET ONE
    public Orders getOrder(int id) {
        return controller.findOrders(id);
    }

    // GET ALL
    public List<Orders> getAllOrders() {
        return controller.findOrdersEntities();
    }
}
