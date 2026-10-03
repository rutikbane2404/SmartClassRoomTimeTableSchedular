package dao;

import java.sql.*;
import java.util.*;
import model.DailyTimeTable;
import util.DBConnection;

public class DailyTimeTableDAO {

    // 🔥 INSERT WITH CONFLICT CHECK
	public String addDaily(DailyTimeTable t) {

	    try {
	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT * FROM daily_timetable WHERE lecture_date=? " +
	                "AND (start_time < ? AND end_time > ?)";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, t.getLectureDate());
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

	        // INSERT
	        String insertQuery = "INSERT INTO daily_timetable(class_id, subject_id, faculty_id, room_id, lecture_date, start_time, end_time) VALUES (?, ?, ?, ?, ?, ?, ?)";

	        PreparedStatement insert = con.prepareStatement(insertQuery);
	        insert.setInt(1, t.getClassId());
	        insert.setInt(2, t.getSubjectId());
	        insert.setInt(3, t.getFacultyId());
	        insert.setInt(4, t.getRoomId());
	        insert.setString(5, t.getLectureDate());
	        insert.setString(6, t.getStartTime());
	        insert.setString(7, t.getEndTime());

	        insert.executeUpdate();

	        return "SUCCESS";

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "ERROR";
	}

    // 🔥 GET ALL DAILY
    public List<DailyTimeTable> getAllDaily() {

        List<DailyTimeTable> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT d.*, c.class_name, s.subject_name, u.name AS faculty_name, r.room_number " +
                    "FROM daily_timetable d " +
                    "JOIN classes c ON d.class_id = c.class_id " +
                    "JOIN subjects s ON d.subject_id = s.subject_id " +
                    "JOIN faculty f ON d.faculty_id = f.faculty_id " +
                    "JOIN users u ON f.faculty_id = u.user_id " +
                    "JOIN classrooms r ON d.room_id = r.room_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                DailyTimeTable t = new DailyTimeTable();

                t.setTimetableId(rs.getInt("timetable_id"));
                t.setLectureDate(rs.getString("lecture_date"));
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
    
    public boolean deleteDaily(int id) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM daily_timetable WHERE timetable_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public DailyTimeTable getById(int id) {

        DailyTimeTable t = new DailyTimeTable();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM daily_timetable WHERE timetable_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                t.setTimetableId(rs.getInt("timetable_id"));
                t.setClassId(rs.getInt("class_id"));
                t.setSubjectId(rs.getInt("subject_id"));
                t.setFacultyId(rs.getInt("faculty_id"));
                t.setRoomId(rs.getInt("room_id"));
                t.setLectureDate(rs.getString("lecture_date"));
                t.setStartTime(rs.getString("start_time"));
                t.setEndTime(rs.getString("end_time"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return t;
    }
    
    public String updateDaily(DailyTimeTable t) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM daily_timetable WHERE lecture_date=? " +
                    "AND (start_time < ? AND end_time > ?) " +
                    "AND timetable_id != ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getLectureDate());
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

            String updateQuery = "UPDATE daily_timetable SET class_id=?, subject_id=?, faculty_id=?, room_id=?, lecture_date=?, start_time=?, end_time=? WHERE timetable_id=?";

            PreparedStatement update = con.prepareStatement(updateQuery);
            update.setInt(1, t.getClassId());
            update.setInt(2, t.getSubjectId());
            update.setInt(3, t.getFacultyId());
            update.setInt(4, t.getRoomId());
            update.setString(5, t.getLectureDate());
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