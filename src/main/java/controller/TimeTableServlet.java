package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.TimeTableDAO;
import model.TimeTable;

public class TimeTableServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 STEP 1: GET FORM DATA
        String classId = request.getParameter("classId");
        String subjectId = request.getParameter("subjectId");
        String facultyId = request.getParameter("facultyId");
        String roomId = request.getParameter("roomId");
        String day = request.getParameter("day");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String lectureDate = request.getParameter("lectureDate"); // for day-wise

        // 🔥 STEP 2: VALIDATION (VERY IMPORTANT)
        if (classId == null || subjectId == null || facultyId == null ||
            roomId == null || day == null ||
            startTime == null || endTime == null ||
            classId.isEmpty() || subjectId.isEmpty() || facultyId.isEmpty() ||
            roomId.isEmpty() || day.isEmpty() ||
            startTime.isEmpty() || endTime.isEmpty()) {

            response.sendRedirect("jsp/admin/CreateTimeTable.jsp?error=empty_fields");
            return;
        }

        // 🔥 EXTRA: TIME VALIDATION
        if (startTime.equals("00:00") || endTime.equals("00:00")) {
            response.sendRedirect("jsp/admin/CreateTimeTable.jsp?error=invalid_time");
            return;
        }

        // 🔥 STEP 3: SET MODEL
        TimeTable t = new TimeTable();

        t.setClassId(Integer.parseInt(classId));
        t.setSubjectId(Integer.parseInt(subjectId));
        t.setFacultyId(Integer.parseInt(facultyId));
        t.setRoomId(Integer.parseInt(roomId));
        t.setDayOfWeek(day);
        t.setStartTime(startTime);
        t.setEndTime(endTime);

        // Optional (for day-wise)
        if (lectureDate != null && !lectureDate.isEmpty()) {
            t.setLectureDate(lectureDate);
        }

        // 🔥 STEP 4: CALL DAO
        TimeTableDAO dao = new TimeTableDAO();

        boolean success = dao.addTimeTable(t);

        // 🔥 STEP 5: HANDLE RESULT
        if (success) {
            response.sendRedirect("jsp/admin/ViewTimeTable.jsp");
        } else {
            response.sendRedirect("jsp/admin/CreateTimeTable.jsp?error=conflict");
        }
    }
}