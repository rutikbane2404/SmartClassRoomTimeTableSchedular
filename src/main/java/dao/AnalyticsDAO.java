package dao;

import java.sql.*;
import java.util.*;
import model.FacultyWorkload;
import util.DBConnection;

public class AnalyticsDAO {

    public List<FacultyWorkload> getFacultyWorkload() {

        List<FacultyWorkload> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT f.faculty_id, u.name, COUNT(t.timetable_id) AS total_lectures " +
                         "FROM faculty f " +
                         "JOIN users u ON f.faculty_id = u.user_id " +
                         "LEFT JOIN timetable t ON f.faculty_id = t.faculty_id " +
                         "GROUP BY f.faculty_id, u.name";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            double total = 0;
            int count = 0;

            while (rs.next()) {
                FacultyWorkload fw = new FacultyWorkload();

                fw.setFacultyId(rs.getInt("faculty_id"));
                fw.setFacultyName(rs.getString("name"));
                fw.setLectureCount(rs.getInt("total_lectures"));

                total += fw.getLectureCount();
                count++;

                list.add(fw);
            }

            double avg = (count == 0) ? 0 : total / count;

            // 🔥 Classification (Analytics Logic)
            for (FacultyWorkload fw : list) {

                if (fw.getLectureCount() > avg + 2) {
                    fw.setStatus("Overloaded");
                } else if (fw.getLectureCount() < avg - 2) {
                    fw.setStatus("Underutilized");
                } else {
                    fw.setStatus("Balanced");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}