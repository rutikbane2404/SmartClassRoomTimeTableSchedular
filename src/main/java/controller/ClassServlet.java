package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClassDAO;
import model.ClassModel;

@WebServlet("/ClassServlet")
public class ClassServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
        request.getParameter("action");

        ClassDAO dao =
        new ClassDAO();

        if(action.equals("add")){

            ClassModel c =
            new ClassModel();

            c.setClassName(
            request.getParameter("className"));

            c.setSemester(
            Integer.parseInt(
            request.getParameter("semester")));

            c.setDepartment(
            request.getParameter("department"));

            dao.addClass(c);

            response.sendRedirect(
            "jsp/admin/ManageClasses.jsp");
        }

        else if(action.equals("update")){

            ClassModel c =
            new ClassModel();

            c.setClassId(
            Integer.parseInt(
            request.getParameter("id")));

            c.setClassName(
            request.getParameter("className"));

            c.setSemester(
            Integer.parseInt(
            request.getParameter("semester")));

            c.setDepartment(
            request.getParameter("department"));

            dao.updateClass(c);

            response.sendRedirect(
            "jsp/admin/ManageClasses.jsp");
        }

        else if(action.equals("delete")){

            int id =
            Integer.parseInt(
            request.getParameter("id"));

            dao.deleteClass(id);

            response.sendRedirect(
            "jsp/admin/ManageClasses.jsp");
        }
    }
}