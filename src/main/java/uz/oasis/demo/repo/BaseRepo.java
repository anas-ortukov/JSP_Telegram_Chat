package uz.oasis.demo.repo;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

public class BaseRepo <T, I> {

    private final Class<T> entityClass;

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("TG_PROJECT_PST");
    private static final EntityManager em = emf.createEntityManager();

    @SuppressWarnings("unchecked")
    public BaseRepo() {
        Type type = getClass().getGenericSuperclass();
        if (type instanceof ParameterizedType parameterizedType) {
            entityClass = (Class<T>) parameterizedType.getActualTypeArguments()[0];
        }else {
            throw new RuntimeException();
        }
    }

    public void begin() {
        em.getTransaction().begin();
    }
    public void commit() {
        em.getTransaction().commit();
    }

    public List<T> findAll() {
        return em.createQuery("from "+entityClass.getSimpleName(), entityClass).getResultList();
    }

    public T findById(I id) {
        return em.find(entityClass, id);
    }

    public void delete(T entity) {
        begin();
        em.remove(entity);
        commit();
    }

    public void deleteById(I id) {
        begin();
        em.remove(em.find(entityClass, id));
        commit();
    }

    public void save(T entity) {
        begin();
        em.persist(entity);
        commit();
    }

}
