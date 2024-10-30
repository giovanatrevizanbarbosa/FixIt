package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.Customer;
import model.State;
import model.dao.AddressDao;
import model.dao.CustomerDao;
import utils.DataSourceSearcher;
import utils.PasswordEncoder;

@WebServlet("/novo-cliente")
public class CustomerRegister extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CustomerRegister() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        req.setAttribute("states", State.values());
        RequestDispatcher dispatcher = req.getRequestDispatcher("/customer-register.jsp");
		dispatcher.forward(req, resp);
        session.removeAttribute("result");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String formToken = req.getParameter("formToken");
        String sessionToken = (String) session.getAttribute("formToken");

        if (formToken == null || !formToken.equals(sessionToken)) {
            resp.sendRedirect("novo-cliente");
            return;
        }

        session.removeAttribute("formToken");

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String cpf = req.getParameter("cpf");
        String phone = req.getParameter("phone");

        String street = req.getParameter("street");
        String number = req.getParameter("number");
        String cep = req.getParameter("cep");
        String complement = req.getParameter("complement");
        String neighborhood = req.getParameter("neighborhood");
        String city = req.getParameter("city");
        String state = req.getParameter("state");

        Address address = new Address();
        address.setStreet(street);
        address.setNumber(number);
        address.setCep(cep.replaceAll("[-. ]", ""));
        address.setComplement(complement);
        address.setNeighborhood(neighborhood);
        address.setCity(city);
        address.setState(State.valueOf(state));

        AddressDao addressDao = new AddressDao(DataSourceSearcher.getInstance().getDataSource());

        if(addressDao.save(address) != null){
            Customer customer = new Customer();
            customer.setName(name);
            customer.setEmail(email);
            customer.setPassword(PasswordEncoder.encode(password));
            customer.setCpf(cpf.replaceAll("[-. ]", ""));
            customer.setPhone(phone.replaceAll("[-.() ]", ""));
            customer.setAddress(address);

            CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
            if(customerDao.save(customer) != -1L){
                session.setAttribute("result", "registered");
                resp.sendRedirect("inicio");
            }else{
                session.setAttribute("result", "notRegistered");
                resp.sendRedirect("novo-cliente");
            }
        }else{
            session.setAttribute("result", "notRegistered");
            resp.sendRedirect("novo-cliente");
        }
    }
}
