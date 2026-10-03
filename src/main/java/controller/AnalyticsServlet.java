package controller;

import dao.AnalyticsDAO;
import model.FacultyWorkload;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AnalyticsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AnalyticsDAO dao = new AnalyticsDAO();
        List<FacultyWorkload> list = dao.getFacultyWorkload();

        request.setAttribute("workloadList", list);

        RequestDispatcher rd =
        	    request.getRequestDispatcher("jsp/admin/FacultyWorkload.jsp");
        	rd.forward(request, response);
    }
}