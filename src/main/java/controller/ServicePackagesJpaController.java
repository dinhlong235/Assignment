/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import DAO.exceptions.NonexistentEntityException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import java.io.Serializable;
import jakarta.persistence.Query;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import model.Suppliers;
import model.Orders;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import model.ServicePackages;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

/**
 *
 * @author ASUS
 */
public class ServicePackagesJpaController implements Serializable {

    public ServicePackagesJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(ServicePackages servicePackages) {
        if (servicePackages.getOrdersCollection() == null) {
            servicePackages.setOrdersCollection(new ArrayList<Orders>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Suppliers supplierId = servicePackages.getSupplierId();
            if (supplierId != null) {
                supplierId = em.getReference(supplierId.getClass(), supplierId.getSupplierId());
                servicePackages.setSupplierId(supplierId);
            }
            Collection<Orders> attachedOrdersCollection = new ArrayList<Orders>();
            for (Orders ordersCollectionOrdersToAttach : servicePackages.getOrdersCollection()) {
                ordersCollectionOrdersToAttach = em.getReference(ordersCollectionOrdersToAttach.getClass(), ordersCollectionOrdersToAttach.getOrderId());
                attachedOrdersCollection.add(ordersCollectionOrdersToAttach);
            }
            servicePackages.setOrdersCollection(attachedOrdersCollection);
            em.persist(servicePackages);
            if (supplierId != null) {
                supplierId.getServicePackagesCollection().add(servicePackages);
                supplierId = em.merge(supplierId);
            }
            for (Orders ordersCollectionOrders : servicePackages.getOrdersCollection()) {
                ServicePackages oldPackageIdOfOrdersCollectionOrders = ordersCollectionOrders.getPackageId();
                ordersCollectionOrders.setPackageId(servicePackages);
                ordersCollectionOrders = em.merge(ordersCollectionOrders);
                if (oldPackageIdOfOrdersCollectionOrders != null) {
                    oldPackageIdOfOrdersCollectionOrders.getOrdersCollection().remove(ordersCollectionOrders);
                    oldPackageIdOfOrdersCollectionOrders = em.merge(oldPackageIdOfOrdersCollectionOrders);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(ServicePackages servicePackages) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            ServicePackages persistentServicePackages = em.find(ServicePackages.class, servicePackages.getPackageId());
            Suppliers supplierIdOld = persistentServicePackages.getSupplierId();
            Suppliers supplierIdNew = servicePackages.getSupplierId();
            Collection<Orders> ordersCollectionOld = persistentServicePackages.getOrdersCollection();
            Collection<Orders> ordersCollectionNew = servicePackages.getOrdersCollection();
            if (supplierIdNew != null) {
                supplierIdNew = em.getReference(supplierIdNew.getClass(), supplierIdNew.getSupplierId());
                servicePackages.setSupplierId(supplierIdNew);
            }
            Collection<Orders> attachedOrdersCollectionNew = new ArrayList<Orders>();
            for (Orders ordersCollectionNewOrdersToAttach : ordersCollectionNew) {
                ordersCollectionNewOrdersToAttach = em.getReference(ordersCollectionNewOrdersToAttach.getClass(), ordersCollectionNewOrdersToAttach.getOrderId());
                attachedOrdersCollectionNew.add(ordersCollectionNewOrdersToAttach);
            }
            ordersCollectionNew = attachedOrdersCollectionNew;
            servicePackages.setOrdersCollection(ordersCollectionNew);
            servicePackages = em.merge(servicePackages);
            if (supplierIdOld != null && !supplierIdOld.equals(supplierIdNew)) {
                supplierIdOld.getServicePackagesCollection().remove(servicePackages);
                supplierIdOld = em.merge(supplierIdOld);
            }
            if (supplierIdNew != null && !supplierIdNew.equals(supplierIdOld)) {
                supplierIdNew.getServicePackagesCollection().add(servicePackages);
                supplierIdNew = em.merge(supplierIdNew);
            }
            for (Orders ordersCollectionOldOrders : ordersCollectionOld) {
                if (!ordersCollectionNew.contains(ordersCollectionOldOrders)) {
                    ordersCollectionOldOrders.setPackageId(null);
                    ordersCollectionOldOrders = em.merge(ordersCollectionOldOrders);
                }
            }
            for (Orders ordersCollectionNewOrders : ordersCollectionNew) {
                if (!ordersCollectionOld.contains(ordersCollectionNewOrders)) {
                    ServicePackages oldPackageIdOfOrdersCollectionNewOrders = ordersCollectionNewOrders.getPackageId();
                    ordersCollectionNewOrders.setPackageId(servicePackages);
                    ordersCollectionNewOrders = em.merge(ordersCollectionNewOrders);
                    if (oldPackageIdOfOrdersCollectionNewOrders != null && !oldPackageIdOfOrdersCollectionNewOrders.equals(servicePackages)) {
                        oldPackageIdOfOrdersCollectionNewOrders.getOrdersCollection().remove(ordersCollectionNewOrders);
                        oldPackageIdOfOrdersCollectionNewOrders = em.merge(oldPackageIdOfOrdersCollectionNewOrders);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = servicePackages.getPackageId();
                if (findServicePackages(id) == null) {
                    throw new NonexistentEntityException("The servicePackages with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            ServicePackages servicePackages;
            try {
                servicePackages = em.getReference(ServicePackages.class, id);
                servicePackages.getPackageId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The servicePackages with id " + id + " no longer exists.", enfe);
            }
            Suppliers supplierId = servicePackages.getSupplierId();
            if (supplierId != null) {
                supplierId.getServicePackagesCollection().remove(servicePackages);
                supplierId = em.merge(supplierId);
            }
            Collection<Orders> ordersCollection = servicePackages.getOrdersCollection();
            for (Orders ordersCollectionOrders : ordersCollection) {
                ordersCollectionOrders.setPackageId(null);
                ordersCollectionOrders = em.merge(ordersCollectionOrders);
            }
            em.remove(servicePackages);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<ServicePackages> findServicePackagesEntities() {
        return findServicePackagesEntities(true, -1, -1);
    }

    public List<ServicePackages> findServicePackagesEntities(int maxResults, int firstResult) {
        return findServicePackagesEntities(false, maxResults, firstResult);
    }

    private List<ServicePackages> findServicePackagesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(ServicePackages.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public ServicePackages findServicePackages(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ServicePackages.class, id);
        } finally {
            em.close();
        }
    }

    public int getServicePackagesCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<ServicePackages> rt = cq.from(ServicePackages.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    /**
     * Hàm tìm gói cước theo bộ lọc
     * @param supplierType: Loại năng lượng (ví dụ: "solar", "wind", "EVN")
     * @param usageType: Loại khách hàng (ví dụ: "household", "business")
     * @return Danh sách các gói cước phù hợp
     */
    public List<ServicePackages> findPackagesByFilter(String supplierType, String usageType) {
        EntityManager em = getEntityManager();
        try {
            // Viết câu Query: Chọn gói cước P mà có Supplier là loại A và PackageType là loại B
            String jpql = "SELECT p FROM ServicePackages p "
                        + "WHERE p.supplierId.type = :sType " 
                        + "AND p.packageType = :uType";
            
            TypedQuery<ServicePackages> q = em.createQuery(jpql, ServicePackages.class);
            q.setParameter("sType", supplierType);
            q.setParameter("uType", usageType);
            
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}
