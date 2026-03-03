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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import model.Suppliers;

/**
 *
 * @author ASUS
 */
public class SuppliersJpaController implements Serializable {

    public SuppliersJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Suppliers suppliers) {
        if (suppliers.getServicePackagesCollection() == null) {
            suppliers.setServicePackagesCollection(new ArrayList<ServicePackages>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Collection<ServicePackages> attachedServicePackagesCollection = new ArrayList<ServicePackages>();
            for (ServicePackages servicePackagesCollectionServicePackagesToAttach : suppliers.getServicePackagesCollection()) {
                servicePackagesCollectionServicePackagesToAttach = em.getReference(servicePackagesCollectionServicePackagesToAttach.getClass(), servicePackagesCollectionServicePackagesToAttach.getPackageId());
                attachedServicePackagesCollection.add(servicePackagesCollectionServicePackagesToAttach);
            }
            suppliers.setServicePackagesCollection(attachedServicePackagesCollection);
            em.persist(suppliers);
            for (ServicePackages servicePackagesCollectionServicePackages : suppliers.getServicePackagesCollection()) {
                Suppliers oldSupplierIdOfServicePackagesCollectionServicePackages = servicePackagesCollectionServicePackages.getSupplierId();
                servicePackagesCollectionServicePackages.setSupplierId(suppliers);
                servicePackagesCollectionServicePackages = em.merge(servicePackagesCollectionServicePackages);
                if (oldSupplierIdOfServicePackagesCollectionServicePackages != null) {
                    oldSupplierIdOfServicePackagesCollectionServicePackages.getServicePackagesCollection().remove(servicePackagesCollectionServicePackages);
                    oldSupplierIdOfServicePackagesCollectionServicePackages = em.merge(oldSupplierIdOfServicePackagesCollectionServicePackages);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Suppliers suppliers)
            throws NonexistentEntityException, Exception {

        EntityManager em = null;

        try {
            em = getEntityManager();
            em.getTransaction().begin();

            em.merge(suppliers);

            em.getTransaction().commit();

        } catch (Exception ex) {

            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            Integer id = suppliers.getSupplierId();
            if (findSuppliers(id) == null) {
                throw new NonexistentEntityException(
                        "The suppliers with id " + id + " no longer exists."
                );
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
            Suppliers suppliers;
            try {
                suppliers = em.getReference(Suppliers.class, id);
                suppliers.getSupplierId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The suppliers with id " + id + " no longer exists.", enfe);
            }
            Collection<ServicePackages> servicePackagesCollection = suppliers.getServicePackagesCollection();
            for (ServicePackages servicePackagesCollectionServicePackages : servicePackagesCollection) {
                servicePackagesCollectionServicePackages.setSupplierId(null);
                servicePackagesCollectionServicePackages = em.merge(servicePackagesCollectionServicePackages);
            }
            em.remove(suppliers);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Suppliers> findSuppliersEntities() {
        return findSuppliersEntities(true, -1, -1);
    }

    public List<Suppliers> findSuppliersEntities(int maxResults, int firstResult) {
        return findSuppliersEntities(false, maxResults, firstResult);
    }

    private List<Suppliers> findSuppliersEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Suppliers.class));
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

    public Suppliers findSuppliers(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Suppliers.class, id);
        } finally {
            em.close();
        }
    }

    public int getSuppliersCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Suppliers> rt = cq.from(Suppliers.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

}
