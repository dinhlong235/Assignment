package Service;

import controller.SuppliersJpaController;
import java.util.List;
import model.Suppliers;

public class SuppliersService extends BaseService {

    private SuppliersJpaController controller;

    public SuppliersService() {
        controller = new SuppliersJpaController(getEntityManagerFactory());
    }

    public void createSupplier(Suppliers supplier) throws Exception {
        controller.create(supplier);
    }

    public void updateSupplier(Suppliers supplier) throws Exception {
        controller.edit(supplier);
    }

    public void deleteSupplier(int id) throws Exception {
        controller.destroy(id);
    }

    public Suppliers getSupplier(int id) {
        return controller.findSuppliers(id);
    }

    public List<Suppliers> getAllSuppliers() {
        return controller.findSuppliersEntities();
    }
}