package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.SubjectDAO;
import model.Subject;

public class SubjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        SubjectDAO dao = new SubjectDAO();

        if (action.equals("add")) {
            String name = request.getParameter("subjectName");
            String code = request.getParameter("subjectCode");
            int credits = Integer.parseInt(request.getParameter("credits"));
            int facultyId = Integer.parseInt(request.getParameter("facultyId"));

            Subject s = new Subject();
            s.setSubjectName(name);
            s.setSubjectCode(code);
            s.setCredits(credits);
            s.setFacultyId(facultyId);

            dao.addSubject(s);
        }

        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteSubject(id);
        }
        
        if (action.equals("update")) {

            int id = Integer.parseInt(request.getParameter("subjectId"));
            String name = request.getParameter("subjectName");
            String code = request.getParameter("subjectCode");
            int credits = Integer.parseInt(request.getParameter("credits"));
            int facultyId = Integer.parseInt(request.getParameter("facultyId"));

            Subject s = new Subject();
            s.setSubjectId(id);
            s.setSubjectName(name);
            s.setSubjectCode(code);
            s.setCredits(credits);
            s.setFacultyId(facultyId);

            dao.updateSubject(s);
        }

        response.sendRedirect("jsp/admin/ManageSubjects.jsp");
    }
}