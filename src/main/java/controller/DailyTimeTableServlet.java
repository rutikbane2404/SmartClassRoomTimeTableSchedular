package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DailyTimeTableDAO;
import model.DailyTimeTable;

@WebServlet("/DailyTimeTableServlet")
public class DailyTimeTableServlet extends HttpServlet {

    // 🔥 GET → EDIT + DELETE
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        DailyTimeTableDAO dao = new DailyTimeTableDAO();

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteDaily(id);

            response.sendRedirect("jsp/admin/viewDaily.jsp");
        }

        else if ("edit".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            DailyTimeTable t = dao.getById(id);

            request.setAttribute("timetable", t);

            RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/editDaily.jsp");
            rd.forward(request, response);
        }
    }

    // 🔥 POST → CREATE + UPDATE
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String timetableId = request.getParameter("timetableId");

        DailyTimeTableDAO dao = new DailyTimeTableDAO();

        // 🟡 UPDATE
        if (timetableId != null && !timetableId.isEmpty()) {

            DailyTimeTable t = new DailyTimeTable();

            t.setTimetableId(Integer.parseInt(timetableId));
            t.setClassId(Integer.parseInt(request.getParameter("classId")));
            t.setSubjectId(Integer.parseInt(request.getParameter("subjectId")));
            t.setFacultyId(Integer.parseInt(request.getParameter("facultyId")));
            t.setRoomId(Integer.parseInt(request.getParameter("roomId")));
            t.setLectureDate(request.getParameter("lectureDate"));
            t.setStartTime(request.getParameter("startTime"));
            t.setEndTime(request.getParameter("endTime"));

            String result = dao.updateDaily(t);

            if ("SUCCESS".equals(result)) {
                response.sendRedirect("jsp/admin/viewDaily.jsp");
            } else {
                response.sendRedirect("jsp/admin/editDaily.jsp?error=" + result);
            }

            return;
        }

        // 🟢 CREATE
        DailyTimeTable t = new DailyTimeTable();

        t.setClassId(Integer.parseInt(request.getParameter("classId")));
        t.setSubjectId(Integer.parseInt(request.getParameter("subjectId")));
        t.setFacultyId(Integer.parseInt(request.getParameter("facultyId")));
        t.setRoomId(Integer.parseInt(request.getParameter("roomId")));
        t.setLectureDate(request.getParameter("lectureDate"));
        t.setStartTime(request.getParameter("startTime"));
        t.setEndTime(request.getParameter("endTime"));

        String result = dao.addDaily(t);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect("jsp/admin/viewDaily.jsp");
        } else {
            response.sendRedirect("jsp/admin/createDaily.jsp?error=" + result);
        }
    }
}