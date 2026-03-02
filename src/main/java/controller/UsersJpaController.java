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
import model.Consumption;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import model.Orders;
import model.Forecast;
import model.Payments;
import model.Users;

/**
 *
 * @author ASUS
 */
public class UsersJpaController implements Serializable {

    public UsersJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Users users) {
        if (users.getConsumptionCollection() == null) {
            users.setConsumptionCollection(new ArrayList<Consumption>());
        }
        if (users.getOrdersCollection() == null) {
            users.setOrdersCollection(new ArrayList<Orders>());
        }
        if (users.getForecastCollection() == null) {
            users.setForecastCollection(new ArrayList<Forecast>());
        }
        if (users.getPaymentsCollection() == null) {
            users.setPaymentsCollection(new ArrayList<Payments>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Collection<Consumption> attachedConsumptionCollection = new ArrayList<Consumption>();
            for (Consumption consumptionCollectionConsumptionToAttach : users.getConsumptionCollection()) {
                consumptionCollectionConsumptionToAttach = em.getReference(consumptionCollectionConsumptionToAttach.getClass(), consumptionCollectionConsumptionToAttach.getConsumptionId());
                attachedConsumptionCollection.add(consumptionCollectionConsumptionToAttach);
            }
            users.setConsumptionCollection(attachedConsumptionCollection);
            Collection<Orders> attachedOrdersCollection = new ArrayList<Orders>();
            for (Orders ordersCollectionOrdersToAttach : users.getOrdersCollection()) {
                ordersCollectionOrdersToAttach = em.getReference(ordersCollectionOrdersToAttach.getClass(), ordersCollectionOrdersToAttach.getOrderId());
                attachedOrdersCollection.add(ordersCollectionOrdersToAttach);
            }
            users.setOrdersCollection(attachedOrdersCollection);
            Collection<Forecast> attachedForecastCollection = new ArrayList<Forecast>();
            for (Forecast forecastCollectionForecastToAttach : users.getForecastCollection()) {
                forecastCollectionForecastToAttach = em.getReference(forecastCollectionForecastToAttach.getClass(), forecastCollectionForecastToAttach.getForecastId());
                attachedForecastCollection.add(forecastCollectionForecastToAttach);
            }
            users.setForecastCollection(attachedForecastCollection);
            Collection<Payments> attachedPaymentsCollection = new ArrayList<Payments>();
            for (Payments paymentsCollectionPaymentsToAttach : users.getPaymentsCollection()) {
                paymentsCollectionPaymentsToAttach = em.getReference(paymentsCollectionPaymentsToAttach.getClass(), paymentsCollectionPaymentsToAttach.getPaymentId());
                attachedPaymentsCollection.add(paymentsCollectionPaymentsToAttach);
            }
            users.setPaymentsCollection(attachedPaymentsCollection);
            em.persist(users);
            for (Consumption consumptionCollectionConsumption : users.getConsumptionCollection()) {
                Users oldUserIdOfConsumptionCollectionConsumption = consumptionCollectionConsumption.getUserId();
                consumptionCollectionConsumption.setUserId(users);
                consumptionCollectionConsumption = em.merge(consumptionCollectionConsumption);
                if (oldUserIdOfConsumptionCollectionConsumption != null) {
                    oldUserIdOfConsumptionCollectionConsumption.getConsumptionCollection().remove(consumptionCollectionConsumption);
                    oldUserIdOfConsumptionCollectionConsumption = em.merge(oldUserIdOfConsumptionCollectionConsumption);
                }
            }
            for (Orders ordersCollectionOrders : users.getOrdersCollection()) {
                Users oldUserIdOfOrdersCollectionOrders = ordersCollectionOrders.getUserId();
                ordersCollectionOrders.setUserId(users);
                ordersCollectionOrders = em.merge(ordersCollectionOrders);
                if (oldUserIdOfOrdersCollectionOrders != null) {
                    oldUserIdOfOrdersCollectionOrders.getOrdersCollection().remove(ordersCollectionOrders);
                    oldUserIdOfOrdersCollectionOrders = em.merge(oldUserIdOfOrdersCollectionOrders);
                }
            }
            for (Forecast forecastCollectionForecast : users.getForecastCollection()) {
                Users oldUserIdOfForecastCollectionForecast = forecastCollectionForecast.getUserId();
                forecastCollectionForecast.setUserId(users);
                forecastCollectionForecast = em.merge(forecastCollectionForecast);
                if (oldUserIdOfForecastCollectionForecast != null) {
                    oldUserIdOfForecastCollectionForecast.getForecastCollection().remove(forecastCollectionForecast);
                    oldUserIdOfForecastCollectionForecast = em.merge(oldUserIdOfForecastCollectionForecast);
                }
            }
            for (Payments paymentsCollectionPayments : users.getPaymentsCollection()) {
                Users oldUserIdOfPaymentsCollectionPayments = paymentsCollectionPayments.getUserId();
                paymentsCollectionPayments.setUserId(users);
                paymentsCollectionPayments = em.merge(paymentsCollectionPayments);
                if (oldUserIdOfPaymentsCollectionPayments != null) {
                    oldUserIdOfPaymentsCollectionPayments.getPaymentsCollection().remove(paymentsCollectionPayments);
                    oldUserIdOfPaymentsCollectionPayments = em.merge(oldUserIdOfPaymentsCollectionPayments);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Users users) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Users persistentUsers = em.find(Users.class, users.getUserId());
            Collection<Consumption> consumptionCollectionOld = persistentUsers.getConsumptionCollection();
            Collection<Consumption> consumptionCollectionNew = users.getConsumptionCollection();
            Collection<Orders> ordersCollectionOld = persistentUsers.getOrdersCollection();
            Collection<Orders> ordersCollectionNew = users.getOrdersCollection();
            Collection<Forecast> forecastCollectionOld = persistentUsers.getForecastCollection();
            Collection<Forecast> forecastCollectionNew = users.getForecastCollection();
            Collection<Payments> paymentsCollectionOld = persistentUsers.getPaymentsCollection();
            Collection<Payments> paymentsCollectionNew = users.getPaymentsCollection();
            Collection<Consumption> attachedConsumptionCollectionNew = new ArrayList<Consumption>();
            for (Consumption consumptionCollectionNewConsumptionToAttach : consumptionCollectionNew) {
                consumptionCollectionNewConsumptionToAttach = em.getReference(consumptionCollectionNewConsumptionToAttach.getClass(), consumptionCollectionNewConsumptionToAttach.getConsumptionId());
                attachedConsumptionCollectionNew.add(consumptionCollectionNewConsumptionToAttach);
            }
            consumptionCollectionNew = attachedConsumptionCollectionNew;
            users.setConsumptionCollection(consumptionCollectionNew);
            Collection<Orders> attachedOrdersCollectionNew = new ArrayList<Orders>();
            for (Orders ordersCollectionNewOrdersToAttach : ordersCollectionNew) {
                ordersCollectionNewOrdersToAttach = em.getReference(ordersCollectionNewOrdersToAttach.getClass(), ordersCollectionNewOrdersToAttach.getOrderId());
                attachedOrdersCollectionNew.add(ordersCollectionNewOrdersToAttach);
            }
            ordersCollectionNew = attachedOrdersCollectionNew;
            users.setOrdersCollection(ordersCollectionNew);
            Collection<Forecast> attachedForecastCollectionNew = new ArrayList<Forecast>();
            for (Forecast forecastCollectionNewForecastToAttach : forecastCollectionNew) {
                forecastCollectionNewForecastToAttach = em.getReference(forecastCollectionNewForecastToAttach.getClass(), forecastCollectionNewForecastToAttach.getForecastId());
                attachedForecastCollectionNew.add(forecastCollectionNewForecastToAttach);
            }
            forecastCollectionNew = attachedForecastCollectionNew;
            users.setForecastCollection(forecastCollectionNew);
            Collection<Payments> attachedPaymentsCollectionNew = new ArrayList<Payments>();
            for (Payments paymentsCollectionNewPaymentsToAttach : paymentsCollectionNew) {
                paymentsCollectionNewPaymentsToAttach = em.getReference(paymentsCollectionNewPaymentsToAttach.getClass(), paymentsCollectionNewPaymentsToAttach.getPaymentId());
                attachedPaymentsCollectionNew.add(paymentsCollectionNewPaymentsToAttach);
            }
            paymentsCollectionNew = attachedPaymentsCollectionNew;
            users.setPaymentsCollection(paymentsCollectionNew);
            users = em.merge(users);
            for (Consumption consumptionCollectionOldConsumption : consumptionCollectionOld) {
                if (!consumptionCollectionNew.contains(consumptionCollectionOldConsumption)) {
                    consumptionCollectionOldConsumption.setUserId(null);
                    consumptionCollectionOldConsumption = em.merge(consumptionCollectionOldConsumption);
                }
            }
            for (Consumption consumptionCollectionNewConsumption : consumptionCollectionNew) {
                if (!consumptionCollectionOld.contains(consumptionCollectionNewConsumption)) {
                    Users oldUserIdOfConsumptionCollectionNewConsumption = consumptionCollectionNewConsumption.getUserId();
                    consumptionCollectionNewConsumption.setUserId(users);
                    consumptionCollectionNewConsumption = em.merge(consumptionCollectionNewConsumption);
                    if (oldUserIdOfConsumptionCollectionNewConsumption != null && !oldUserIdOfConsumptionCollectionNewConsumption.equals(users)) {
                        oldUserIdOfConsumptionCollectionNewConsumption.getConsumptionCollection().remove(consumptionCollectionNewConsumption);
                        oldUserIdOfConsumptionCollectionNewConsumption = em.merge(oldUserIdOfConsumptionCollectionNewConsumption);
                    }
                }
            }
            for (Orders ordersCollectionOldOrders : ordersCollectionOld) {
                if (!ordersCollectionNew.contains(ordersCollectionOldOrders)) {
                    ordersCollectionOldOrders.setUserId(null);
                    ordersCollectionOldOrders = em.merge(ordersCollectionOldOrders);
                }
            }
            for (Orders ordersCollectionNewOrders : ordersCollectionNew) {
                if (!ordersCollectionOld.contains(ordersCollectionNewOrders)) {
                    Users oldUserIdOfOrdersCollectionNewOrders = ordersCollectionNewOrders.getUserId();
                    ordersCollectionNewOrders.setUserId(users);
                    ordersCollectionNewOrders = em.merge(ordersCollectionNewOrders);
                    if (oldUserIdOfOrdersCollectionNewOrders != null && !oldUserIdOfOrdersCollectionNewOrders.equals(users)) {
                        oldUserIdOfOrdersCollectionNewOrders.getOrdersCollection().remove(ordersCollectionNewOrders);
                        oldUserIdOfOrdersCollectionNewOrders = em.merge(oldUserIdOfOrdersCollectionNewOrders);
                    }
                }
            }
            for (Forecast forecastCollectionOldForecast : forecastCollectionOld) {
                if (!forecastCollectionNew.contains(forecastCollectionOldForecast)) {
                    forecastCollectionOldForecast.setUserId(null);
                    forecastCollectionOldForecast = em.merge(forecastCollectionOldForecast);
                }
            }
            for (Forecast forecastCollectionNewForecast : forecastCollectionNew) {
                if (!forecastCollectionOld.contains(forecastCollectionNewForecast)) {
                    Users oldUserIdOfForecastCollectionNewForecast = forecastCollectionNewForecast.getUserId();
                    forecastCollectionNewForecast.setUserId(users);
                    forecastCollectionNewForecast = em.merge(forecastCollectionNewForecast);
                    if (oldUserIdOfForecastCollectionNewForecast != null && !oldUserIdOfForecastCollectionNewForecast.equals(users)) {
                        oldUserIdOfForecastCollectionNewForecast.getForecastCollection().remove(forecastCollectionNewForecast);
                        oldUserIdOfForecastCollectionNewForecast = em.merge(oldUserIdOfForecastCollectionNewForecast);
                    }
                }
            }
            for (Payments paymentsCollectionOldPayments : paymentsCollectionOld) {
                if (!paymentsCollectionNew.contains(paymentsCollectionOldPayments)) {
                    paymentsCollectionOldPayments.setUserId(null);
                    paymentsCollectionOldPayments = em.merge(paymentsCollectionOldPayments);
                }
            }
            for (Payments paymentsCollectionNewPayments : paymentsCollectionNew) {
                if (!paymentsCollectionOld.contains(paymentsCollectionNewPayments)) {
                    Users oldUserIdOfPaymentsCollectionNewPayments = paymentsCollectionNewPayments.getUserId();
                    paymentsCollectionNewPayments.setUserId(users);
                    paymentsCollectionNewPayments = em.merge(paymentsCollectionNewPayments);
                    if (oldUserIdOfPaymentsCollectionNewPayments != null && !oldUserIdOfPaymentsCollectionNewPayments.equals(users)) {
                        oldUserIdOfPaymentsCollectionNewPayments.getPaymentsCollection().remove(paymentsCollectionNewPayments);
                        oldUserIdOfPaymentsCollectionNewPayments = em.merge(oldUserIdOfPaymentsCollectionNewPayments);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = users.getUserId();
                if (findUsers(id) == null) {
                    throw new NonexistentEntityException("The users with id " + id + " no longer exists.");
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
            Users users;
            try {
                users = em.getReference(Users.class, id);
                users.getUserId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The users with id " + id + " no longer exists.", enfe);
            }
            Collection<Consumption> consumptionCollection = users.getConsumptionCollection();
            for (Consumption consumptionCollectionConsumption : consumptionCollection) {
                consumptionCollectionConsumption.setUserId(null);
                consumptionCollectionConsumption = em.merge(consumptionCollectionConsumption);
            }
            Collection<Orders> ordersCollection = users.getOrdersCollection();
            for (Orders ordersCollectionOrders : ordersCollection) {
                ordersCollectionOrders.setUserId(null);
                ordersCollectionOrders = em.merge(ordersCollectionOrders);
            }
            Collection<Forecast> forecastCollection = users.getForecastCollection();
            for (Forecast forecastCollectionForecast : forecastCollection) {
                forecastCollectionForecast.setUserId(null);
                forecastCollectionForecast = em.merge(forecastCollectionForecast);
            }
            Collection<Payments> paymentsCollection = users.getPaymentsCollection();
            for (Payments paymentsCollectionPayments : paymentsCollection) {
                paymentsCollectionPayments.setUserId(null);
                paymentsCollectionPayments = em.merge(paymentsCollectionPayments);
            }
            em.remove(users);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Users> findUsersEntities() {
        return findUsersEntities(true, -1, -1);
    }

    public List<Users> findUsersEntities(int maxResults, int firstResult) {
        return findUsersEntities(false, maxResults, firstResult);
    }

    private List<Users> findUsersEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Users.class));
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

    public Users findUsers(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Users.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsersCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Users> rt = cq.from(Users.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
