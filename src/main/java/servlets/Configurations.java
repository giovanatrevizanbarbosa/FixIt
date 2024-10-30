package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.dao.CustomerDao;
import model.dao.PaymentMethodDao;
import utils.DataSourceSearcher;

import java.io.IOException;

@WebServlet("/configuracoes")
public class Configurations extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/configurations.jsp");
		PaymentMethodDao paymentMethodDao = new PaymentMethodDao(DataSourceSearcher.getInstance().getDataSource());
		req.setAttribute("paymentMethods", paymentMethodDao.getAllPaymentMethods());
		dispatcher.forward(req, resp);
		session.removeAttribute("result");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/configurations.jsp");
		dispatcher.forward(req, resp);
	}
	
}
