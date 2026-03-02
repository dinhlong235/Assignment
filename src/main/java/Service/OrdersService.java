package Service;

import controller.OrdersJpaController;
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
}