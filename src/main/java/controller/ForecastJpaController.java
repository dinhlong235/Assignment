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
import model.Forecast;
import model.Users;

/**
 *
 * @author ASUS
 */
public class ForecastJpaController implements Serializable {

    public ForecastJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Forecast forecast) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Users userId = forecast.getUserId();
            if (userId != null) {
                userId = em.getReference(userId.getClass(), userId.getUserId());
                forecast.setUserId(userId);
            }
            em.persist(forecast);
            if (userId != null) {
                userId.getForecastCollection().add(forecast);
                userId = em.merge(userId);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Forecast forecast) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Forecast persistentForecast = em.find(Forecast.class, forecast.getForecastId());
            Users userIdOld = persistentForecast.getUserId();
            Users userIdNew = forecast.getUserId();
            if (userIdNew != null) {
                userIdNew = em.getReference(userIdNew.getClass(), userIdNew.getUserId());
                forecast.setUserId(userIdNew);
            }
            forecast = em.merge(forecast);
            if (userIdOld != null && !userIdOld.equals(userIdNew)) {
                userIdOld.getForecastCollection().remove(forecast);
                userIdOld = em.merge(userIdOld);
            }
            if (userIdNew != null && !userIdNew.equals(userIdOld)) {
                userIdNew.getForecastCollection().add(forecast);
                userIdNew = em.merge(userIdNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = forecast.getForecastId();
                if (findForecast(id) == null) {
                    throw new NonexistentEntityException("The forecast with id " + id + " no longer exists.");
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
            Forecast forecast;
            try {
                forecast = em.getReference(Forecast.class, id);
                forecast.getForecastId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The forecast with id " + id + " no longer exists.", enfe);
            }
            Users userId = forecast.getUserId();
            if (userId != null) {
                userId.getForecastCollection().remove(forecast);
                userId = em.merge(userId);
            }
            em.remove(forecast);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Forecast> findForecastEntities() {
        return findForecastEntities(true, -1, -1);
    }

    public List<Forecast> findForecastEntities(int maxResults, int firstResult) {
        return findForecastEntities(false, maxResults, firstResult);
    }

    private List<Forecast> findForecastEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Forecast.class));
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

    public Forecast findForecast(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Forecast.class, id);
        } finally {
            em.close();
        }
    }

    public int getForecastCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Forecast> rt = cq.from(Forecast.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
