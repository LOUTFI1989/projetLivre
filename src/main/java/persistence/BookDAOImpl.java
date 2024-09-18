package persistence;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.spi.PersistenceUnitInfo;
import modele.Book;
import org.hibernate.jpa.HibernatePersistenceProvider;
import javautil.JPA_Connector;

import java.util.HashMap;
import java.util.List;

public class BookDAOImpl implements BookDAO {

    private EntityManagerFactory emf = null;
    private EntityManager em = null;

    public BookDAOImpl() {
        PersistenceUnitInfo PUI = new JPA_Connector();
        this.emf = new HibernatePersistenceProvider()
                .createContainerEntityManagerFactory(PUI, new HashMap<>());
        this.em = emf.createEntityManager();
    }



    public List<Book> getAllBooks() {
        EntityManager em = emf.createEntityManager();
        List<Book> books = null;
        try {
            // requête JPQL pour sélectionner tous les livres
            TypedQuery<Book> query = em.createQuery("SELECT b FROM Book b", Book.class);
            books = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }


    // Méthode pour obtenir un livre par ID
    public Book getBookById(int id) {
        EntityManager em = null;
        Book book = null;
        try {
            em = emf.createEntityManager();
            book = em.find(Book.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return book;
    }

    // Méthode pour ajouter un nouveau livre
    public void addBook(Book book) {

        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(book);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
            }


    // Méthode pour supprimer un livre par ID
    public void deleteBook(int id) {

        try {

            em.getTransaction().begin();
            Book book = em.find(Book.class, id);
            if (book != null) {
                em.remove(book);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
        }


    // Méthode pour ajouter ou mettre à jour un livre
    public void saveBook(Book book) {

        try {

            em.getTransaction().begin();
            if (book.getId() == 0) {
                // Si l'ID est 0, c'est un nouveau livre
                em.persist(book);
            } else {
                // Sinon, c'est une mise à jour
                em.merge(book);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
    }

    // Méthode pour mettre à jour un livre
    public void updateBook(Book book) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            Book existingBook = em.find(Book.class, book.getId());
            if (existingBook != null) {
                // Mettre à jour les attributs du livre existant
                existingBook.setTitle(book.getTitle());
                existingBook.setAuthor(book.getAuthor());
                existingBook.setGenre(book.getGenre());
                existingBook.setPrice(book.getPrice());
                em.merge(existingBook);
            }
            em.getTransaction().commit();

            em.getTransaction().commit();
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
        }
    }









//    public List<Book> getAllBooks() {
//        return em.createQuery("SELECT b from Book b", Book.class).getResultList();
//}
//
//    public List<Book> findAll() {
//        String jpql =   "SELECT b FROM Book b ";
//        this.em.getTransaction().begin();
//        Query query = this.em.createQuery(jpql);
//        var result = query.getResultList();
//        this.em.getTransaction().commit();
//        return result;
//    }

