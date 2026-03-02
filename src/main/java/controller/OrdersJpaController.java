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
import model.ServicePackages;
import model.Users;
import model.Payments;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import model.Orders;

/**
 *
 * @author ASUS
 */
public class OrdersJpaController implements Serializable {

    public OrdersJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Orders orders) {
        if (orders.getPaymentsCollection() == null) {
            orders.setPaymentsCollection(new ArrayList<Payments>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            ServicePackages packageId = orders.getPackageId();
            if (packageId != null) {
                packageId = em.getReference(packageId.getClass(), packageId.getPackageId());
                orders.setPackageId(packageId);
            }
            Users userId = orders.getUserId();
            if (userId != null) {
                userId = em.getReference(userId.getClass(), userId.getUserId());
                orders.setUserId(userId);
            }
            Collection<Payments> attachedPaymentsCollection = new ArrayList<Payments>();
            for (Payments paymentsCollectionPaymentsToAttach : orders.getPaymentsCollection()) {
                paymentsCollectionPaymentsToAttach = em.getReference(paymentsCollectionPaymentsToAttach.getClass(), paymentsCollectionPaymentsToAttach.getPaymentId());
                attachedPaymentsCollection.add(paymentsCollectionPaymentsToAttach);
            }
            orders.setPaymentsCollection(attachedPaymentsCollection);
            em.persist(orders);
            if (packageId != null) {
                packageId.getOrdersCollection().add(orders);
                packageId = em.merge(packageId);
            }
            if (userId != null) {
                userId.getOrdersCollection().add(orders);
                userId = em.merge(userId);
            }
            for (Payments paymentsCollectionPayments : orders.getPaymentsCollection()) {
                Orders oldOrderIdOfPaymentsCollectionPayments = paymentsCollectionPayments.getOrderId();
                paymentsCollectionPayments.setOrderId(orders);
                paymentsCollectionPayments = em.merge(paymentsCollectionPayments);
                if (oldOrderIdOfPaymentsCollectionPayments != null) {
                    oldOrderIdOfPaymentsCollectionPayments.getPaymentsCollection().remove(paymentsCollectionPayments);
                    oldOrderIdOfPaymentsCollectionPayments = em.merge(oldOrderIdOfPaymentsCollectionPayments);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Orders orders) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Orders persistentOrders = em.find(Orders.class, orders.getOrderId());
            ServicePackages packageIdOld = persistentOrders.getPackageId();
            ServicePackages packageIdNew = orders.getPackageId();
            Users userIdOld = persistentOrders.getUserId();
            Users userIdNew = orders.getUserId();
            Collection<Payments> paymentsCollectionOld = persistentOrders.getPaymentsCollection();
            Collection<Payments> paymentsCollectionNew = orders.getPaymentsCollection();
            if (packageIdNew != null) {
                packageIdNew = em.getReference(packageIdNew.getClass(), packageIdNew.getPackageId());
                orders.setPackageId(packageIdNew);
            }
            if (userIdNew != null) {
                userIdNew = em.getReference(userIdNew.getClass(), userIdNew.getUserId());
                orders.setUserId(userIdNew);
            }
            Collection<Payments> attachedPaymentsCollectionNew = new ArrayList<Payments>();
            for (Payments paymentsCollectionNewPaymentsToAttach : paymentsCollectionNew) {
                paymentsCollectionNewPaymentsToAttach = em.getReference(paymentsCollectionNewPaymentsToAttach.getClass(), paymentsCollectionNewPaymentsToAttach.getPaymentId());
                attachedPaymentsCollectionNew.add(paymentsCollectionNewPaymentsToAttach);
            }
            paymentsCollectionNew = attachedPaymentsCollectionNew;
            orders.setPaymentsCollection(paymentsCollectionNew);
            orders = em.merge(orders);
            if (packageIdOld != null && !packageIdOld.equals(packageIdNew)) {
                packageIdOld.getOrdersCollection().remove(orders);
                packageIdOld = em.merge(packageIdOld);
            }
            if (packageIdNew != null && !packageIdNew.equals(packageIdOld)) {
                packageIdNew.getOrdersCollection().add(orders);
                packageIdNew = em.merge(packageIdNew);
            }
            if (userIdOld != null && !userIdOld.equals(userIdNew)) {
                userIdOld.getOrdersCollection().remove(orders);
                userIdOld = em.merge(userIdOld);
            }
            if (userIdNew != null && !userIdNew.equals(userIdOld)) {
                userIdNew.getOrdersCollection().add(orders);
                userIdNew = em.merge(userIdNew);
            }
            for (Payments paymentsCollectionOldPayments : paymentsCollectionOld) {
                if (!paymentsCollectionNew.contains(paymentsCollectionOldPayments)) {
                    paymentsCollectionOldPayments.setOrderId(null);
                    paymentsCollectionOldPayments = em.merge(paymentsCollectionOldPayments);
                }
            }
            for (Payments paymentsCollectionNewPayments : paymentsCollectionNew) {
                if (!paymentsCollectionOld.contains(paymentsCollectionNewPayments)) {
                    Orders oldOrderIdOfPaymentsCollectionNewPayments = paymentsCollectionNewPayments.getOrderId();
                    paymentsCollectionNewPayments.setOrderId(orders);
                    paymentsCollectionNewPayments = em.merge(paymentsCollectionNewPayments);
                    if (oldOrderIdOfPaymentsCollectionNewPayments != null && !oldOrderIdOfPaymentsCollectionNewPayments.equals(orders)) {
                        oldOrderIdOfPaymentsCollectionNewPayments.getPaymentsCollection().remove(paymentsCollectionNewPayments);
                        oldOrderIdOfPaymentsCollectionNewPayments = em.merge(oldOrderIdOfPaymentsCollectionNewPayments);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = orders.getOrderId();
                if (findOrders(id) == null) {
                    throw new NonexistentEntityException("The orders with id " + id + " no longer exists.");
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
            Orders orders;
            try {
                orders = em.getReference(Orders.class, id);
                orders.getOrderId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The orders with id " + id + " no longer exists.", enfe);
            }
            ServicePackages packageId = orders.getPackageId();
            if (packageId != null) {
                packageId.getOrdersCollection().remove(orders);
                packageId = em.merge(packageId);
            }
            Users userId = orders.getUserId();
            if (userId != null) {
                userId.getOrdersCollection().remove(orders);
                userId = em.merge(userId);
            }
            Collection<Payments> paymentsCollection = orders.getPaymentsCollection();
            for (Payments paymentsCollectionPayments : paymentsCollection) {
                paymentsCollectionPayments.setOrderId(null);
                paymentsCollectionPayments = em.merge(paymentsCollectionPayments);
            }
            em.remove(orders);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Orders> findOrdersEntities() {
        return findOrdersEntities(true, -1, -1);
    }

    public List<Orders> findOrdersEntities(int maxResults, int firstResult) {
        return findOrdersEntities(false, maxResults, firstResult);
    }

    private List<Orders> findOrdersEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Orders.class));
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

    public Orders findOrders(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Orders.class, id);
        } finally {
            em.close();
        }
    }

    public int getOrdersCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Orders> rt = cq.from(Orders.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
