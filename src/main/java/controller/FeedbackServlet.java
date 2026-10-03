package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBConnection;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int studentId = Integer.parseInt(
            request.getParameter("studentId"));

            int facultyId = Integer.parseInt(
            request.getParameter("facultyId"));

            String subject = request.getParameter("subject");

            String feedback = request.getParameter("feedback");

            int rating = Integer.parseInt(
            request.getParameter("rating"));

            Connection con = DBConnection.getConnection();

            String sql =
            "INSERT INTO feedback(student_id, faculty_id, subject, feedback_text, rating) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setInt(2, facultyId);
            ps.setString(3, subject);
            ps.setString(4, feedback);
            ps.setInt(5, rating);

            ps.executeUpdate();

            response.sendRedirect(
            "jsp/student/StudentDashboard.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}