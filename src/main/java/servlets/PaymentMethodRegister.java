package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.Customer;
import model.PaymentMethod;
import model.State;
import model.dao.AddressDao;
import model.dao.CustomerDao;
import model.dao.PaymentMethodDao;
import utils.DataSourceSearcher;
import utils.PasswordEncoder;

import java.io.IOException;

@WebServlet("/novo-metodo-de-pagamento")
public class PaymentMethodRegister extends HttpServlet{
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public PaymentMethodRegister() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/payment-method-register.jsp");
        session.removeAttribute("result");
		dispatcher.forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String formToken = req.getParameter("formToken");
        String sessionToken = (String) session.getAttribute("formToken");

        if (formToken == null || !formToken.equals(sessionToken)) {
            resp.sendRedirect("novo-metodo-de-pagamento");
            return;
        }

        session.removeAttribute("formToken");

        String name = req.getParameter("name");

        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setName(name);
        PaymentMethodDao paymentMethodDao = new PaymentMethodDao(DataSourceSearcher.getInstance().getDataSource());

        if(paymentMethodDao.save(paymentMethod)){
            session.setAttribute("result", "registered");
            resp.sendRedirect("configuracoes");
        }else{
            session.setAttribute("result", "registered");
            resp.sendRedirect("novo-metodo-de-pagamento");
        }
    }
}
