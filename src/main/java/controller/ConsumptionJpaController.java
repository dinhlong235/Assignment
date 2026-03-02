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
import model.Consumption;
import model.Users;

/**
 *
 * @author ASUS
 */
public class ConsumptionJpaController implements Serializable {

    public ConsumptionJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Consumption consumption) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Users userId = consumption.getUserId();
            if (userId != null) {
                userId = em.getReference(userId.getClass(), userId.getUserId());
                consumption.setUserId(userId);
            }
            em.persist(consumption);
            if (userId != null) {
                userId.getConsumptionCollection().add(consumption);
                userId = em.merge(userId);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Consumption consumption) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Consumption persistentConsumption = em.find(Consumption.class, consumption.getConsumptionId());
            Users userIdOld = persistentConsumption.getUserId();
            Users userIdNew = consumption.getUserId();
            if (userIdNew != null) {
                userIdNew = em.getReference(userIdNew.getClass(), userIdNew.getUserId());
                consumption.setUserId(userIdNew);
            }
            consumption = em.merge(consumption);
            if (userIdOld != null && !userIdOld.equals(userIdNew)) {
                userIdOld.getConsumptionCollection().remove(consumption);
                userIdOld = em.merge(userIdOld);
            }
            if (userIdNew != null && !userIdNew.equals(userIdOld)) {
                userIdNew.getConsumptionCollection().add(consumption);
                userIdNew = em.merge(userIdNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = consumption.getConsumptionId();
                if (findConsumption(id) == null) {
                    throw new NonexistentEntityException("The consumption with id " + id + " no longer exists.");
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
            Consumption consumption;
            try {
                consumption = em.getReference(Consumption.class, id);
                consumption.getConsumptionId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The consumption with id " + id + " no longer exists.", enfe);
            }
            Users userId = consumption.getUserId();
            if (userId != null) {
                userId.getConsumptionCollection().remove(consumption);
                userId = em.merge(userId);
            }
            em.remove(consumption);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Consumption> findConsumptionEntities() {
        return findConsumptionEntities(true, -1, -1);
    }

    public List<Consumption> findConsumptionEntities(int maxResults, int firstResult) {
        return findConsumptionEntities(false, maxResults, firstResult);
    }

    private List<Consumption> findConsumptionEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Consumption.class));
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

    public Consumption findConsumption(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Consumption.class, id);
        } finally {
            em.close();
        }
    }

    public int getConsumptionCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Consumption> rt = cq.from(Consumption.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
