package dao;

import java.sql.*;
import java.util.*;
import model.WeeklyTimeTable;
import util.DBConnection;

public class WeeklyTimeTableDAO {

    // 🔥 INSERT WITH DETAILED CONFLICT
    public String addWeekly(WeeklyTimeTable t) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM timetable WHERE day_of_week=? " +
                    "AND (start_time < ? AND end_time > ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getDayOfWeek());
            ps.setString(2, t.getEndTime());
            ps.setString(3, t.getStartTime());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                if (rs.getInt("faculty_id") == t.getFacultyId()) {
                    return "Faculty already busy at this time";
                }
                if (rs.getInt("room_id") == t.getRoomId()) {
                    return "Room already allocated at this time";
                }
                if (rs.getInt("class_id") == t.getClassId()) {
                    return "Class already has a lecture at this time";
                }
            }

            // 🔥 INSERT
            String insertQuery = "INSERT INTO timetable(class_id, subject_id, faculty_id, room_id, day_of_week, start_time, end_time) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement insert = con.prepareStatement(insertQuery);
            insert.setInt(1, t.getClassId());
            insert.setInt(2, t.getSubjectId());
            insert.setInt(3, t.getFacultyId());
            insert.setInt(4, t.getRoomId());
            insert.setString(5, t.getDayOfWeek());
            insert.setString(6, t.getStartTime());
            insert.setString(7, t.getEndTime());

            insert.executeUpdate();

            return "SUCCESS";

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "ERROR";
    }

    // 🔥 GET ALL WEEKLY
    public List<WeeklyTimeTable> getAllWeekly() {

        List<WeeklyTimeTable> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT t.*, c.class_name, s.subject_name, u.name AS faculty_name, r.room_number " +
                    "FROM timetable t " +
                    "JOIN classes c ON t.class_id = c.class_id " +
                    "JOIN subjects s ON t.subject_id = s.subject_id " +
                    "JOIN faculty f ON t.faculty_id = f.faculty_id " +
                    "JOIN users u ON f.faculty_id = u.user_id " +
                    "JOIN classrooms r ON t.room_id = r.room_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                WeeklyTimeTable t = new WeeklyTimeTable();

                t.setTimetableId(rs.getInt("timetable_id"));
                t.setDayOfWeek(rs.getString("day_of_week"));
                t.setStartTime(rs.getString("start_time"));
                t.setEndTime(rs.getString("end_time"));

                t.setClassName(rs.getString("class_name"));
                t.setSubjectName(rs.getString("subject_name"));
                t.setFacultyName(rs.getString("faculty_name"));
                t.setRoomNumber(rs.getString("room_number"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean deleteWeekly(int id) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM timetable WHERE timetable_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public WeeklyTimeTable getById(int id) {

        WeeklyTimeTable t = new WeeklyTimeTable();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM timetable WHERE timetable_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                t.setTimetableId(rs.getInt("timetable_id"));
                t.setClassId(rs.getInt("class_id"));
                t.setSubjectId(rs.getInt("subject_id"));
                t.setFacultyId(rs.getInt("faculty_id"));
                t.setRoomId(rs.getInt("room_id"));
                t.setDayOfWeek(rs.getString("day_of_week"));
                t.setStartTime(rs.getString("start_time"));
                t.setEndTime(rs.getString("end_time"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return t;
    }
    
    public String updateWeekly(WeeklyTimeTable t) {

        try {
            Connection con = DBConnection.getConnection();

            // 🔥 CONFLICT CHECK (IGNORE SAME RECORD)
            String sql = "SELECT * FROM timetable WHERE day_of_week=? " +
                    "AND (start_time < ? AND end_time > ?) " +
                    "AND timetable_id != ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getDayOfWeek());
            ps.setString(2, t.getEndTime());
            ps.setString(3, t.getStartTime());
            ps.setInt(4, t.getTimetableId());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                if (rs.getInt("faculty_id") == t.getFacultyId()) {
                    return "Faculty already busy at this time";
                }
                if (rs.getInt("room_id") == t.getRoomId()) {
                    return "Room already allocated at this time";
                }
                if (rs.getInt("class_id") == t.getClassId()) {
                    return "Class already has a lecture at this time";
                }
            }

            // 🔥 UPDATE QUERY
            String updateQuery = "UPDATE timetable SET class_id=?, subject_id=?, faculty_id=?, room_id=?, day_of_week=?, start_time=?, end_time=? WHERE timetable_id=?";

            PreparedStatement update = con.prepareStatement(updateQuery);
            update.setInt(1, t.getClassId());
            update.setInt(2, t.getSubjectId());
            update.setInt(3, t.getFacultyId());
            update.setInt(4, t.getRoomId());
            update.setString(5, t.getDayOfWeek());
            update.setString(6, t.getStartTime());
            update.setString(7, t.getEndTime());
            update.setInt(8, t.getTimetableId());

            update.executeUpdate();

            return "SUCCESS";

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "ERROR";
    }
    
}