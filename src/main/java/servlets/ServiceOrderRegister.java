package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import model.dao.CustomerDao;
import model.dao.PaymentMethodDao;
import model.dao.ServiceOrderDao;
import utils.DataSourceSearcher;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;

@WebServlet("/nova-ordem-de-servico")
public class ServiceOrderRegister extends HttpServlet{
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public ServiceOrderRegister() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/service-order-register.jsp");

        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(DataSourceSearcher.getInstance().getDataSource());
        req.setAttribute("paymentMethods", paymentMethodDao.getAllPaymentMethods());

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
        req.setAttribute("customers", customerDao.getAllCustomers());

        dispatcher.forward(req, resp);
        session.removeAttribute("result");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String formToken = req.getParameter("formToken");
        String sessionToken = (String) session.getAttribute("formToken");

        if (formToken == null || !formToken.equals(sessionToken)) {
            resp.sendRedirect("nova-ordem-de-servico");
            return;
        }

        session.removeAttribute("formToken");

        String description = req.getParameter("description");
        LocalDate emissionDate = LocalDate.parse(req.getParameter("emissionDate"));
        Double price = Double.valueOf(req.getParameter("price"));
        String observation = req.getParameter("observation");
        Long paymentMethodId = Long.valueOf(req.getParameter("paymentMethod"));
        Long customerId = Long.valueOf(req.getParameter("customer"));

        ServiceOrder serviceOrder = new ServiceOrder();
        serviceOrder.setDescription(description);
        serviceOrder.setEmissionDate(emissionDate);
        serviceOrder.setPrice(price);
        serviceOrder.setObservation(observation);
        serviceOrder.setStatus(Status.IN_APPROVAL);

        CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
        serviceOrder.setCustomer(customerDao.getCustomerById(customerId).get());

        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(DataSourceSearcher.getInstance().getDataSource());
        serviceOrder.setPaymentMethod(paymentMethodDao.getPaymentMethodById(paymentMethodId).get());

        ServiceOrderDao serviceOrderDao = new ServiceOrderDao(DataSourceSearcher.getInstance().getDataSource());
        if(serviceOrderDao.save(serviceOrder)){
            session.setAttribute("result", "registered");
            resp.sendRedirect("inicio");
        }else{
            session.setAttribute("result", "notRegistered");
            resp.sendRedirect("nova-ordem-de-servico");
        }
    }
}
