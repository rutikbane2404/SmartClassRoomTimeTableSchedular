package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.FacultyDAO;
import model.Faculty;

public class FacultyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        FacultyDAO dao = new FacultyDAO();

        // DELETE
        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteFaculty(id);

            response.sendRedirect("jsp/admin/ManageFaculty.jsp");
            return;
        }

        // UPDATE
        if ("update".equals(action)) {

            Faculty f = new Faculty();

            f.setFacultyId(Integer.parseInt(request.getParameter("id")));
            f.setName(request.getParameter("name"));
            f.setEmail(request.getParameter("email"));
            f.setDepartment(request.getParameter("department"));

            dao.updateFaculty(f);

            response.sendRedirect("jsp/admin/ManageFaculty.jsp");
            return;
        }

        // ADD
        if ("add".equals(action)) {

            dao.addFaculty(
                request.getParameter("name"),
                request.getParameter("email"),
                request.getParameter("password"),
                request.getParameter("department")
            );

            response.sendRedirect("jsp/admin/RegisterFaculty.jsp?success=1");
        }
    }
}