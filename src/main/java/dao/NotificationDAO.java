package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class NotificationDAO {

    // INSERT NOTIFICATION
    public void sendNotificationToAllStudents(

            String message

    ) {

        try {

            Connection con =
            DBConnection.getConnection();

            // GET ALL STUDENTS
            String studentSql =

            "SELECT user_id FROM users " +
            "WHERE role='STUDENT'";

            PreparedStatement psStudents =
            con.prepareStatement(studentSql);

            ResultSet rs =
            psStudents.executeQuery();

            // INSERT NOTIFICATION
            String notifySql =

            "INSERT INTO notifications" +

            "(user_id, message, status) " +

            "VALUES (?, ?, 'UNREAD')";

            PreparedStatement psNotify =
            con.prepareStatement(notifySql);

            while(rs.next()){

                int userId =
                rs.getInt("user_id");

                psNotify.setInt(1, userId);

                psNotify.setString(2, message);

                psNotify.executeUpdate();
            }

            System.out.println(
            "Notifications Sent");

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}