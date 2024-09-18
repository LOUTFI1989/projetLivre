package controller;

import java.io.IOException;
import java.util.List;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persistence.BookDAOImpl;
import modele.Book;

@WebServlet("/shop")
public class ShoppingServletForBooks extends HttpServlet {
    private BookDAOImpl bookDAO = new BookDAOImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        // Récupérer la locale depuis la requête
        String localeParam = request.getParameter("locale");
        // Vérifier si une locale a été spécifiée dans la requête, sinon utiliser celle dans la session
        HttpSession session = request.getSession();
        String locale = (localeParam != null && !localeParam.isEmpty()) ? localeParam : (String) session.getAttribute("locale");

        if (locale != null && !locale.isEmpty()) {
            locale = "fr_FR"; // Locale par défaut
            //request.setAttribute("locale", locale);
        }

        // Stocker la locale dans la session pour une utilisation future
        session.setAttribute("locale", locale);


        Vector<Book> buylist = (Vector<Book>) session.getAttribute("shoppingcart");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("/error.jsp");
            return;
        }

        if (!action.equals("CHECKOUT")) {
            if (action.equals("-")) {
                String del = request.getParameter("delindex");
                int d = Integer.parseInt(del);
                if (buylist != null) {
                    buylist.removeElementAt(d);
                }
            } else if (action.equals("+")) {

//               String username = request.getParameter("username");
//             if (username != null && !username.isEmpty()) {
//                 request.getSession().setAttribute("user", username);
//                 session.setAttribute("shoppingcart", buylist);

                boolean match = false;
                Book aBook = getBook(request);
                if (buylist == null) {
                    buylist = new Vector<>();
                    buylist.addElement(aBook);
                } else {
                    for (int i = 0; i < buylist.size(); i++) {
                        Book book = buylist.elementAt(i);
                        if (book.getId().equals(aBook.getId())) {
                            book.setQuantity(book.getQuantity() + aBook.getQuantity());
                            buylist.setElementAt(book, i);
                            match = true;
                            break;
                        }
                    }
                    if (!match) {
                        buylist.addElement(aBook);
                    }
                }
            }

            session.setAttribute("shoppingcart", buylist);
            String username = request.getParameter("username");
            if (username != null && !username.isEmpty()) {
                request.getSession().setAttribute("user", username);
            }

            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);
            request.setAttribute("locale", locale); //  la locale est transmise à la JSP
            String url = "/WEB-INF/welcome-client.jsp";
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher(url);
            rd.forward(request, response);

        } else if (action.equals("CHECKOUT")) {
            double total = 0;
            if (buylist != null) {
                for (Book anOrder : buylist) {
                    double price = anOrder.getPrice();
                    int qty = anOrder.getQuantity();
                    total += (price * qty);
                }
            }

            String amount = String.format("%.2f", total);
            request.setAttribute("amount", amount);

            String url = "/WEB-INF/checkout.jsp";
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher(url);
            rd.forward(request, response);
        }else if (action.equals("Continuer")){
            String username = request.getParameter("username");
            if (username != null && !username.isEmpty()) {
                request.getSession().setAttribute("user", username);
            }
            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);
            String url = "/WEB-INF/welcome-client.jsp";
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher(url);
            rd.forward(request, response);
        } else if (action.equals("confirm")){
            String username = request.getParameter("username");

            if (username != null && !username.isEmpty()) {
                request.getSession().setAttribute("user", username);

                // Forward to the confirmation page after setting the username
                String url = "${pageContext.request.contextPath}/confirmation.jsp";
                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher(url);
                rd.forward(request, response);
            } else {
                // Handle the case where the username is null or empty
                request.setAttribute("error", "Username cannot be empty.");
                String url = "/login.jsp"; // Assuming there's a login page
                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher(url);
                rd.forward(request, response);
            }
        } else {
            // Handle other actions or invalid action values
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");

        }}


    private Book getBook(HttpServletRequest req) {
        String bookId = req.getParameter("bookId");
        String qty = req.getParameter("qty_" + bookId);

        // Logging pour le debug
        System.out.println("bookId: " + bookId);
        System.out.println("qty: " + qty);
        if (bookId == null || qty == null) {
            throw new IllegalArgumentException("Required parameters 'bookId' or 'qty' are missing");
        }

        Book book = bookDAO.getBookById((int) Long.parseLong(bookId)); // Supposant que vous avez une méthode pour récupérer un livre par ID
        book.setQuantity(Integer.parseInt(qty));
        return book;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      processRequest(request, response);

    }


    @Override
    public String getServletInfo() {
        return "Shopping Servlet for Books";
    }
}
