package testDb;

import persistence.BookDAOImpl;


public class test {
    public static void main(String[] args) {

     BookDAOImpl bookDAO = new BookDAOImpl();
    System.out.println(bookDAO.getAllBooks());
//        Book book = new Book();
//        book.setId((long) 7);
//        book.setAuthor("zak");
//        book.setGenre("fiction");
//        book.setPrice(42);
//        book.setTitle("zakBokk");
//        bookDAO.saveBook(book);

    }
}

