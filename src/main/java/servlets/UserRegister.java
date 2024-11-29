package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.dao.UserDao;
import utils.DataSourceSearcher;
import utils.PasswordEncoder;

import java.io.IOException;

    @WebServlet("/novo-funcionario")
public class UserRegister extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public UserRegister() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/user-register.jsp");
		dispatcher.forward(req, resp);
        session.removeAttribute("result");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String formToken = req.getParameter("formToken");
        String sessionToken = (String) session.getAttribute("formToken");

        if (formToken == null || !formToken.equals(sessionToken)) {
            resp.sendRedirect("novo-funcionario");
            return;
        }

        session.removeAttribute("formToken");

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Boolean admin = Boolean.valueOf(req.getParameter("admin"));

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setAdmin(admin);

        UserDao userDao = new UserDao(DataSourceSearcher.getInstance().getDataSource());
        if(userDao.save(user) != -1L){
            session.setAttribute("result", "registered");
            resp.sendRedirect("inicio");
        }else{
            session.setAttribute("result", "notRegistered");
            resp.sendRedirect("novo-funcionario");
        }
    }
}
