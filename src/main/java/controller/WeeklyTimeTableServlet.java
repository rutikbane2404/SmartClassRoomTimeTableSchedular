package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.WeeklyTimeTableDAO;
import model.WeeklyTimeTable;

@WebServlet("/WeeklyTimeTableServlet")
public class WeeklyTimeTableServlet extends HttpServlet {

    // 🔥 HANDLE GET (EDIT + DELETE)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        WeeklyTimeTableDAO dao = new WeeklyTimeTableDAO();

        // 🔴 DELETE
        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteWeekly(id);

            response.sendRedirect("jsp/admin/viewWeekly.jsp");
        }

        // 🟡 EDIT (LOAD DATA)
        else if ("edit".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            WeeklyTimeTable t = dao.getById(id);

            request.setAttribute("timetable", t);

            RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/editWeekly.jsp");
            rd.forward(request, response);
        }
    }

    // 🔥 HANDLE POST (CREATE + UPDATE)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String timetableId = request.getParameter("timetableId");

        WeeklyTimeTableDAO dao = new WeeklyTimeTableDAO();

        // 🟡 UPDATE
        if (timetableId != null && !timetableId.isEmpty()) {

            WeeklyTimeTable t = new WeeklyTimeTable();

            t.setTimetableId(Integer.parseInt(timetableId));
            t.setClassId(Integer.parseInt(request.getParameter("classId")));
            t.setSubjectId(Integer.parseInt(request.getParameter("subjectId")));
            t.setFacultyId(Integer.parseInt(request.getParameter("facultyId")));
            t.setRoomId(Integer.parseInt(request.getParameter("roomId")));
            t.setDayOfWeek(request.getParameter("day"));
            t.setStartTime(request.getParameter("startTime"));
            t.setEndTime(request.getParameter("endTime"));

            String result = dao.updateWeekly(t);

            if ("SUCCESS".equals(result)) {
                response.sendRedirect("jsp/admin/viewWeekly.jsp");
            } else {
                response.sendRedirect("jsp/admin/editWeekly.jsp?error=" + result);
            }

            return;
        }

        // 🟢 CREATE
        String day = request.getParameter("day");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        if (day == null || day.isEmpty() ||
            startTime == null || endTime == null ||
            startTime.isEmpty() || endTime.isEmpty()) {

            response.sendRedirect("jsp/admin/createWeekly.jsp?error=Please fill all fields");
            return;
        }

        WeeklyTimeTable t = new WeeklyTimeTable();

        t.setClassId(Integer.parseInt(request.getParameter("classId")));
        t.setSubjectId(Integer.parseInt(request.getParameter("subjectId")));
        t.setFacultyId(Integer.parseInt(request.getParameter("facultyId")));
        t.setRoomId(Integer.parseInt(request.getParameter("roomId")));
        t.setDayOfWeek(day);
        t.setStartTime(startTime);
        t.setEndTime(endTime);

        String result = dao.addWeekly(t);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect("jsp/admin/viewWeekly.jsp");
        } else {
            response.sendRedirect("jsp/admin/createWeekly.jsp?error=" + result);
        }
    }
}