package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ServiceOrder;
import model.dao.CustomerDao;
import model.dao.ServiceOrderDao;
import utils.DataSourceSearcher;

@WebServlet("/inicio")
public class Home extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//HttpSession session = req.getSession(false);
		HttpSession session = req.getSession();
		RequestDispatcher dispatcher = req.getRequestDispatcher("/home.jsp");

		CustomerDao customerDao = new CustomerDao(DataSourceSearcher.getInstance().getDataSource());
		req.setAttribute("customers", customerDao.getAllCustomers());

		ServiceOrderDao serviceOrderDao = new ServiceOrderDao(DataSourceSearcher.getInstance().getDataSource());
		req.setAttribute("serviceOrders", serviceOrderDao.getAllServiceOrders());

		dispatcher.forward(req, resp);
		session.removeAttribute("result");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/home.jsp");
		dispatcher.forward(req, resp);
	}
	
}
