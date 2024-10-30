package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.dao.CustomerDao;
import utils.DataSourceSearcher;
import utils.PasswordEncoder;

import java.io.IOException;

@WebServlet("/entrar")
public class Login extends HttpServlet {
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public Login() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/login.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Customer customer = new Customer();
        customer.setEmail(email);
        customer.setPassword(PasswordEncoder.encode(password));

        RequestDispatcher dispatcher = null;

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
        if(customerDao.getCustomerByEmailAndPassword(email, password) != null) {
            session.setAttribute("customer", customer);
            resp.sendRedirect(req.getContextPath() + "/inicio");
        }else{
            resp.sendRedirect(req.getContextPath() + "/inicio");
        }
    }
}