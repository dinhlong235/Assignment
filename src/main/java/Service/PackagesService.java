package Service;

import controller.ServicePackagesJpaController;
import java.util.List;
import model.ServicePackages;

public class PackagesService extends BaseService {

    private ServicePackagesJpaController controller;

    public PackagesService() {
        controller = new ServicePackagesJpaController(getEntityManagerFactory());
    }

    public void createPackage(ServicePackages pkg) throws Exception {
        controller.create(pkg);
    }

    public void updatePackage(ServicePackages pkg) throws Exception {
        controller.edit(pkg);
    }

    public void deletePackage(int id) throws Exception {
        controller.destroy(id);
    }

    public ServicePackages getPackage(int id) {
        return controller.findServicePackages(id);
    }

    public List<ServicePackages> getAllPackages() {
        return controller.findServicePackagesEntities();
    }
}
