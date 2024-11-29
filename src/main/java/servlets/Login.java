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

import java.io.IOException;
import java.util.Optional;

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
        HttpSession session = req.getSession(false);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/login.jsp");
        dispatcher.forward(req, resp);
        session.removeAttribute("result");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();

        UserDao userDao = new UserDao(DataSourceSearcher.getInstance().getDataSource());
        Optional<User> user = userDao.getUserByEmailAndPassword(email, password);
        System.out.println(user);
        if(user.isPresent()) {
            session.setMaxInactiveInterval(600);
            session.setAttribute("user", user.get());
            resp.sendRedirect(req.getContextPath() + "/inicio");
        }else{
            session.setAttribute("result", "error");
            resp.sendRedirect(req.getContextPath() + "/entrar");
        }
    }
}