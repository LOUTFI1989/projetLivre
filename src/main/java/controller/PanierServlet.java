package controller;

import modele.Book;

import java.io.IOException;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/panier")
public class PanierServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session == null) {
            response.sendRedirect("/error.jsp");
            return;
        }

        Vector<Book> buylist = (Vector<Book>) session.getAttribute("shoppingcart");
        String action = request.getParameter("action");
        if ("confirm".equals(action)) {

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

            String username = request.getParameter("username");
            if (username != null && !username.isEmpty()) {
                request.getSession().setAttribute("user", username);


                // Forward to the confirmation page after setting the username
                String url = "/WEB-INF/confirmation.jsp";
                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher(url);
                rd.forward(request, response);
            } else {
                // Handle the case where the username is null or empty
                request.setAttribute("error", "Username cannot be empty.");
                String url = "/WEB-INF/confirmation.jsp"; // Assuming there's a login page
                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher(url);
                rd.forward(request, response);
            }
        } else {
            // Handle other actions or invalid action values
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for confirming the user and handling checkout confirmation.";
}
}