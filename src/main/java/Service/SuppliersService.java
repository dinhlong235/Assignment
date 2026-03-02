/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author ASUS
 */

import controller.SuppliersJpaController;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;
import model.Suppliers;

public class SuppliersService {
    private SuppliersJpaController controller;

    public SuppliersService() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("EnergyPU");
        controller = new SuppliersJpaController(emf);
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
