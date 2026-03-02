package Service;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class BaseService {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("EnergyPU");

    protected EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }
}