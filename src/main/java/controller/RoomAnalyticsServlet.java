package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.RoomAnalyticsDAO;
import model.RoomUtilization;

public class RoomAnalyticsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomAnalyticsDAO dao = new RoomAnalyticsDAO();
        List<RoomUtilization> list = dao.getRoomUtilization();

        request.setAttribute("roomList", list);

        request.getRequestDispatcher("jsp/admin/RoomAnalytics.jsp")
               .forward(request, response);
    }
}