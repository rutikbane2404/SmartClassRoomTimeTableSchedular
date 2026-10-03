package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        UserDAO dao = new UserDAO();

        User user = dao.login(email, password, role);

        if(user != null){

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // 🔥 ROLE BASED REDIRECT

            if(role.equals("ADMIN")){

                response.sendRedirect("jsp/admin/AdminDashboard.jsp");

            } else if(role.equals("FACULTY")){

                response.sendRedirect("jsp/faculty/FacultyDashboard.jsp");

            } else if(role.equals("STUDENT")){

                response.sendRedirect("jsp/student/StudentDashboard.jsp");
            }

        } else {

            response.sendRedirect("jsp/auth/Login.jsp?error=1");
        }
    }
}