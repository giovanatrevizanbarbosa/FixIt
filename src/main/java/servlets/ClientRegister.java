package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.dao.ClientDao;
import utils.DataSourceSearcher;
import utils.PasswordEncoder;

@WebServlet("/client-register")
public class ClientRegister extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ClientRegister() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	RequestDispatcher dispatcher = req.getRequestDispatcher("/client-register.jsp");
		dispatcher.forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String cpf = req.getParameter("cpf");
        String phone = req.getParameter("phone");

        Customer customer = new Customer();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPassword(PasswordEncoder.encode(password));
        customer.setCpf(cpf);
        customer.setPhone(phone);

        RequestDispatcher dispatcher = null;
        
        ClientDao clientDao = new ClientDao(DataSourceSearcher.getInstance().getDataSource());
        
        if(clientDao.save(customer)){
            req.setAttribute("result", "registered");
            dispatcher = req.getRequestDispatcher("client-register.jsp");
        }else{
            req.setAttribute("result", "notRegistered");
            dispatcher = req.getRequestDispatcher("client-register.jsp");
        }

        dispatcher.forward(req, resp);
    }
}
