package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RoomReportDAO;
import model.RoomReport;

@WebServlet("/GenerateRoomReportServlet")
public class GenerateRoomReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)

            throws ServletException, IOException {

        RoomReportDAO dao =
        new RoomReportDAO();

        RoomReport report =
        dao.generateReport();

        request.setAttribute(
            "report",
            report
        );

        RequestDispatcher rd =
        request.getRequestDispatcher(
            "jsp/admin/RoomAnalyticsReport.jsp"
        );

        rd.forward(request, response);
    }
}