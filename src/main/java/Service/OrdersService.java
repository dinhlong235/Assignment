package Service;

import controller.OrdersJpaController;
import java.util.ArrayList;
import java.util.List;
import model.Orders;
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
    public boolean hasActiveOrder(int userId) {

    List<Orders> list = controller.findOrdersEntities();

    for (Orders o : list) {
       if ("active".equalsIgnoreCase(o.getStatus()) 
    || "pending".equalsIgnoreCase(o.getStatus()));
    }

    return false;
}
    public void createOrder(int userId, int packageId) throws Exception {

    if (hasActiveOrder(userId)) {
        throw new Exception("User already has active package");
    }

    Users user = new Users();
    user.setUserId(userId);

    ServicePackages pack = new ServicePackages();
    pack.setPackageId(packageId);

    Orders order = new Orders();
    order.setUserId(user);
    order.setPackageId(pack);
    order.setStatus("pending");
    order.setOrderDate(new java.util.Date());

    controller.create(order);
}
   public void approveOrder(int orderId) throws Exception {

    Orders order = controller.findOrders(orderId);

    if (order == null) {
        throw new Exception("Order not found");
    }

    int userId = order.getUserId().getUserId();

    // Kiểm tra nếu đã có active khác
    if (hasActiveOrder(userId)) {
        throw new Exception("User already has active package");
    }

    order.setStatus("active");
    controller.edit(order);

    // 🔥 UPDATE USER TYPE
    Users user = order.getUserId();
    user.setUserType("household"); // hoặc lấy từ package nếu muốn động

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
   public List<Orders> getOrdersByUser(int userId){

    List<Orders> list = controller.findOrdersEntities();
    List<Orders> result = new ArrayList<>();

    for(Orders o : list){
        if(o.getUserId().getUserId() == userId){
            result.add(o);
        }
    }

    return result;
}
}