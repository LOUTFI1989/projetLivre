package persistence;

import modele.Book;

import java.util.List;

public interface BookDAO {


    // Méthode pour obtenir tous les livres
    List<Book> getAllBooks();

    // Méthode pour obtenir un livre par ID
    Book getBookById(int id);

    // Méthode pour ajouter un nouveau livre
    void addBook(Book book);

    // Méthode pour supprimer un livre par ID
    void deleteBook(int id);

    // Méthode pour enregistrer (ajouter ou mettre à jour) un livre
    void saveBook(Book book);

    // Méthode pour mettre à jour un livre
    void updateBook(Book book);
}
