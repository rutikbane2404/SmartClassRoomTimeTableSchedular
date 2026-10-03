package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.StudentDAO;
import model.Student;

public class StudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        StudentDAO dao = new StudentDAO();

        // ================= DELETE =================
        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteStudent(id);

            response.sendRedirect("jsp/admin/ManageStudent.jsp");
            return;
        }

        // ================= UPDATE =================
        if ("update".equals(action)) {

            Student s = new Student();

            s.setStudentId(Integer.parseInt(request.getParameter("id")));
            s.setName(request.getParameter("name"));
            s.setEmail(request.getParameter("email"));
            s.setPhone(request.getParameter("phone"));
            s.setClassId(Integer.parseInt(request.getParameter("classId")));

            dao.updateStudent(s);

            response.sendRedirect("jsp/admin/ManageStudent.jsp");
            return;
        }

        // ================= ADD =================
        if ("add".equals(action)) {

            dao.addStudent(
                request.getParameter("name"),
                request.getParameter("email"),
                request.getParameter("password"),
                request.getParameter("phone"),
                Integer.parseInt(request.getParameter("classId"))
            );

            response.sendRedirect("jsp/admin/StudentRegistration.jsp?success=1");
        }
    }
}