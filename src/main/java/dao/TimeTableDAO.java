package dao;

import java.sql.*;
import java.util.*;
import model.TimeTable;
import util.DBConnection;

public class TimeTableDAO {

    // 🔥 CONFLICT CHECK (WORKS FOR BOTH MODES)
    public String checkConflict(TimeTable t) {

        try {
            Connection con = DBConnection.getConnection();

            String sql;

            // 🔹 DAY MODE → check with date
            if (t.getLectureDate() != null && !t.getLectureDate().isEmpty()) {

                sql = "SELECT * FROM timetable WHERE day_of_week=? AND lecture_date=? " +
                      "AND (faculty_id=? OR room_id=? OR class_id=?) " +
                      "AND (start_time < ? AND end_time > ?)";

            } else {
                // 🔹 WEEK MODE → no date
                sql = "SELECT * FROM timetable WHERE day_of_week=? " +
                      "AND (faculty_id=? OR room_id=? OR class_id=?) " +
                      "AND (start_time < ? AND end_time > ?)";
            }

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, t.getDayOfWeek());

            if (t.getLectureDate() != null && !t.getLectureDate().isEmpty()) {
                ps.setString(2, t.getLectureDate());
                ps.setInt(3, t.getFacultyId());
                ps.setInt(4, t.getRoomId());
                ps.setInt(5, t.getClassId());
                ps.setString(6, t.getEndTime());
                ps.setString(7, t.getStartTime());
            } else {
                ps.setInt(2, t.getFacultyId());
                ps.setInt(3, t.getRoomId());
                ps.setInt(4, t.getClassId());
                ps.setString(5, t.getEndTime());
                ps.setString(6, t.getStartTime());
            }

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return "⚠️ Conflict detected! Same time slot already used.";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // 🔥 INSERT METHOD (HANDLES BOTH MODES)
    public boolean addTimeTable(TimeTable t) {

        try {
            Connection con = DBConnection.getConnection();

            // 🔥 STEP 1: CHECK CONFLICT
            String checkQuery = "SELECT * FROM timetable WHERE day_of_week=? " +
                    "AND ( " +
                    "(start_time < ? AND end_time > ?) " +   // overlap logic
                    ") AND (class_id=? OR faculty_id=? OR room_id=?)";

            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setString(1, t.getDayOfWeek());
            checkPs.setString(2, t.getEndTime());
            checkPs.setString(3, t.getStartTime());
            checkPs.setInt(4, t.getClassId());
            checkPs.setInt(5, t.getFacultyId());
            checkPs.setInt(6, t.getRoomId());

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                System.out.println("❌ Conflict detected!");
                return false; // conflict
            }

            // 🔥 STEP 2: INSERT
            String insertQuery = "INSERT INTO timetable(class_id, subject_id, faculty_id, room_id, day_of_week, start_time, end_time, lecture_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(insertQuery);
            ps.setInt(1, t.getClassId());
            ps.setInt(2, t.getSubjectId());
            ps.setInt(3, t.getFacultyId());
            ps.setInt(4, t.getRoomId());
            ps.setString(5, t.getDayOfWeek());
            ps.setString(6, t.getStartTime());
            ps.setString(7, t.getEndTime());
            ps.setDate(8, java.sql.Date.valueOf(t.getLectureDate()));

            ps.executeUpdate();

            System.out.println("✅ Inserted successfully");
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 🔥 GET ALL TIMETABLE (UNCHANGED)
    public List<TimeTable> getAllTimeTable() {

        List<TimeTable> list = new ArrayList<>();

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

                TimeTable t = new TimeTable();

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
}