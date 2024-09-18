package controller;


import persistence.BookDAOImpl;
import modele.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    BookDAOImpl bookDAO= new BookDAOImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Replace this with actual authentication logic
        if ("admin".equals(username) && "admin".equals(password)) {
            request.getSession().setAttribute("user", username);
            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("WEB-INF/welcome-admin.jsp").forward(request, response);
            // Authenticated successfully
            request.getSession().setAttribute("user", username);
            response.sendRedirect("books");
        }else if ("client".equals(username) && "client".equals(password)) {
            // Authenticated successfully
            request.getSession().setAttribute("user", username);
            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("WEB-INF/welcome-client.jsp").forward(request, response);
            //response.sendRedirect("jsp/welcome-client.jsp");
        }else {
            // Authentication failed
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
 }
}
}
