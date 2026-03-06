package Service;

import jakarta.persistence.EntityManager;
import java.util.List;
import model.Users;
import java.math.BigDecimal;

public class DashboardService extends BaseService {

    public long countUsers() {
        EntityManager em = getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(u) FROM Users u", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countPackages() {
        EntityManager em = getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(p) FROM ServicePackages p", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countPendingOrders() {
        EntityManager em = getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(o) FROM Orders o WHERE o.status = 'pending'",
                    Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public Double totalRevenue() {

        EntityManager em = getEntityManagerFactory().createEntityManager();

        try {

            BigDecimal result = em.createQuery(
                    "SELECT SUM(p.amount) FROM Payments p WHERE p.status = 'success'",
                    BigDecimal.class)
                    .getSingleResult();

            return result == null ? 0.0 : result.doubleValue();

        } finally {
            em.close();
        }
    }

    public List<Users> getRecentUsers(int limit) {

        EntityManager em = getEntityManagerFactory().createEntityManager();

        try {

            return em.createQuery(
                    "SELECT u FROM Users u ORDER BY u.userId DESC",
                    Users.class
            )
                    .setMaxResults(limit)
                    .getResultList();

        } finally {
            em.close();
        }
    }
}
