package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClassRoomDAO;
import model.Classroom;

public class ClassroomServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
        request.getParameter("action");

        ClassRoomDAO dao =
        new ClassRoomDAO();

        // =========================
        // ADD CLASSROOM
        // =========================
        if(action.equals("add")) {

            String roomNumber =
            request.getParameter("roomNumber");

            int capacity =
            Integer.parseInt(
            request.getParameter("capacity"));

            Classroom c =
            new Classroom();

            c.setRoomNumber(roomNumber);
            c.setCapacity(capacity);

            boolean status =
            dao.addRoom(c);

            if(status){

                response.sendRedirect(
                "jsp/admin/ManageClassrooms.jsp");

            }else{

                response.sendRedirect(
                "jsp/admin/AddClassroom.jsp?error=1");
            }
        }

        // =========================
        // UPDATE CLASSROOM
        // =========================
        else if(action.equals("update")) {

            int id =
            Integer.parseInt(
            request.getParameter("id"));

            String roomNumber =
            request.getParameter("roomNumber");

            int capacity =
            Integer.parseInt(
            request.getParameter("capacity"));

            Classroom c =
            new Classroom();

            c.setRoomId(id);
            c.setRoomNumber(roomNumber);
            c.setCapacity(capacity);

            boolean status =
            dao.updateRoom(c);

            if(status){

                response.sendRedirect(
                "jsp/admin/ManageClassrooms.jsp");

            }else{

                response.sendRedirect(
                "jsp/admin/editClassroom.jsp?id="
                + id + "&error=1");
            }
        }

        // =========================
        // DELETE CLASSROOM
        // =========================
        else if(action.equals("delete")) {

            int id =
            Integer.parseInt(
            request.getParameter("id"));

            boolean status =
            dao.deleteRoom(id);

            response.sendRedirect(
            "jsp/admin/ManageClassrooms.jsp");
        }
    }
}