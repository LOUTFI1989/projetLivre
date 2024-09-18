package javautil;


import modele.Book;

public class BookValidator {
    public static boolean validate(Book book) {
        if (book == null) {
            return false;
        }

        if (book.getTitle() == null || book.getTitle().trim().isEmpty()) {
            return false;
        }
        if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
            return false;
        }
        if (book.getGenre() == null || book.getGenre().trim().isEmpty()) {
            return false;
        }
        if (book.getPrice() <= 0) {
            return false;
        }

        return true;
}
}