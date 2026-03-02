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
import java.util.List;
import model.Orders;
import model.Payments;
import model.Users;

/**
 *
 * @author ASUS
 */
public class PaymentsJpaController implements Serializable {

    public PaymentsJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Payments payments) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Orders orderId = payments.getOrderId();
            if (orderId != null) {
                orderId = em.getReference(orderId.getClass(), orderId.getOrderId());
                payments.setOrderId(orderId);
            }
            Users userId = payments.getUserId();
            if (userId != null) {
                userId = em.getReference(userId.getClass(), userId.getUserId());
                payments.setUserId(userId);
            }
            em.persist(payments);
            if (orderId != null) {
                orderId.getPaymentsCollection().add(payments);
                orderId = em.merge(orderId);
            }
            if (userId != null) {
                userId.getPaymentsCollection().add(payments);
                userId = em.merge(userId);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Payments payments) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Payments persistentPayments = em.find(Payments.class, payments.getPaymentId());
            Orders orderIdOld = persistentPayments.getOrderId();
            Orders orderIdNew = payments.getOrderId();
            Users userIdOld = persistentPayments.getUserId();
            Users userIdNew = payments.getUserId();
            if (orderIdNew != null) {
                orderIdNew = em.getReference(orderIdNew.getClass(), orderIdNew.getOrderId());
                payments.setOrderId(orderIdNew);
            }
            if (userIdNew != null) {
                userIdNew = em.getReference(userIdNew.getClass(), userIdNew.getUserId());
                payments.setUserId(userIdNew);
            }
            payments = em.merge(payments);
            if (orderIdOld != null && !orderIdOld.equals(orderIdNew)) {
                orderIdOld.getPaymentsCollection().remove(payments);
                orderIdOld = em.merge(orderIdOld);
            }
            if (orderIdNew != null && !orderIdNew.equals(orderIdOld)) {
                orderIdNew.getPaymentsCollection().add(payments);
                orderIdNew = em.merge(orderIdNew);
            }
            if (userIdOld != null && !userIdOld.equals(userIdNew)) {
                userIdOld.getPaymentsCollection().remove(payments);
                userIdOld = em.merge(userIdOld);
            }
            if (userIdNew != null && !userIdNew.equals(userIdOld)) {
                userIdNew.getPaymentsCollection().add(payments);
                userIdNew = em.merge(userIdNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = payments.getPaymentId();
                if (findPayments(id) == null) {
                    throw new NonexistentEntityException("The payments with id " + id + " no longer exists.");
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
            Payments payments;
            try {
                payments = em.getReference(Payments.class, id);
                payments.getPaymentId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The payments with id " + id + " no longer exists.", enfe);
            }
            Orders orderId = payments.getOrderId();
            if (orderId != null) {
                orderId.getPaymentsCollection().remove(payments);
                orderId = em.merge(orderId);
            }
            Users userId = payments.getUserId();
            if (userId != null) {
                userId.getPaymentsCollection().remove(payments);
                userId = em.merge(userId);
            }
            em.remove(payments);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Payments> findPaymentsEntities() {
        return findPaymentsEntities(true, -1, -1);
    }

    public List<Payments> findPaymentsEntities(int maxResults, int firstResult) {
        return findPaymentsEntities(false, maxResults, firstResult);
    }

    private List<Payments> findPaymentsEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Payments.class));
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

    public Payments findPayments(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Payments.class, id);
        } finally {
            em.close();
        }
    }

    public int getPaymentsCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Payments> rt = cq.from(Payments.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
