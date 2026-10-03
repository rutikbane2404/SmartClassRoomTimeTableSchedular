package dao;

import java.sql.*;
import java.util.*;
import model.Faculty;
import util.DBConnection;

public class FacultyDAO {

    // 🔥 ADD FACULTY (users + faculty)
	public boolean addFaculty(String name, String email, String password, String department) {

	    boolean status = false;

	    Connection con = null;
	    PreparedStatement psUser = null;
	    PreparedStatement psFaculty = null;
	    ResultSet rs = null;

	    try {

	        con = DBConnection.getConnection();

	        // =========================
	        // STEP 1: INSERT INTO USERS
	        // =========================

	        String userSql =
	        "INSERT INTO users(name, email, password, role) VALUES(?,?,?,?)";

	        psUser = con.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);

	        psUser.setString(1, name);
	        psUser.setString(2, email);
	        psUser.setString(3, password);
	        psUser.setString(4, "FACULTY");

	        int userInserted = psUser.executeUpdate();

	        if(userInserted > 0){

	            rs = psUser.getGeneratedKeys();

	            if(rs.next()){

	                int userId = rs.getInt(1);

	                // =========================
	                // STEP 2: INSERT INTO FACULTY
	                // =========================

	                String facultySql =
	                "INSERT INTO faculty(faculty_id, department) VALUES(?,?)";

	                psFaculty = con.prepareStatement(facultySql);

	                psFaculty.setInt(1, userId);
	                psFaculty.setString(2, department);

	                int facultyInserted = psFaculty.executeUpdate();

	                if(facultyInserted > 0){
	                    status = true;
	                }
	            }
	        }

	    } catch(Exception e){
	        e.printStackTrace();
	    }

	    return status;
	}

    // 🔥 GET ALL FACULTY (JOIN)
    public List<Faculty> getAllFaculty() {
        List<Faculty> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT u.user_id, u.name, u.email, f.department " +
                         "FROM users u JOIN faculty f ON u.user_id = f.faculty_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Faculty f = new Faculty();
                f.setFacultyId(rs.getInt("user_id"));
                f.setName(rs.getString("name"));
                f.setEmail(rs.getString("email"));
                f.setDepartment(rs.getString("department"));

                list.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔥 DELETE FACULTY
    public boolean deleteFaculty(int id){

        boolean status = false;

        try{

            Connection con =
            DBConnection.getConnection();

            // =========================
            // DELETE FEEDBACK
            // =========================

            String feedbackSql =
            "DELETE FROM feedback WHERE faculty_id=?";

            PreparedStatement feedbackPs =
            con.prepareStatement(feedbackSql);

            feedbackPs.setInt(1, id);

            feedbackPs.executeUpdate();

            // =========================
            // DELETE DAILY TIMETABLE
            // =========================

            String dailySql =
            "DELETE FROM daily_timetable WHERE faculty_id=?";

            PreparedStatement dailyPs =
            con.prepareStatement(dailySql);

            dailyPs.setInt(1, id);

            dailyPs.executeUpdate();

            // =========================
            // DELETE WEEKLY TIMETABLE
            // =========================

            String timetableSql =
            "DELETE FROM timetable WHERE faculty_id=?";

            PreparedStatement timetablePs =
            con.prepareStatement(timetableSql);

            timetablePs.setInt(1, id);

            timetablePs.executeUpdate();

            // =========================
            // DELETE NOTIFICATIONS
            // =========================

            String notificationSql =
            		"DELETE FROM notifications WHERE user_id=?";

            PreparedStatement notificationPs =
            con.prepareStatement(notificationSql);

            notificationPs.setInt(1, id);

            notificationPs.executeUpdate();

            // =========================
            // DELETE FACULTY
            // =========================

            String facultySql =
            "DELETE FROM faculty WHERE faculty_id=?";

            PreparedStatement facultyPs =
            con.prepareStatement(facultySql);

            facultyPs.setInt(1, id);

            facultyPs.executeUpdate();

            // =========================
            // DELETE USER
            // =========================

            String userSql =
            "DELETE FROM users WHERE user_id=?";

            PreparedStatement userPs =
            con.prepareStatement(userSql);

            userPs.setInt(1, id);

            int row =
            userPs.executeUpdate();

            if(row > 0){
                status = true;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    // 🔥 UPDATE FACULTY
    public void updateFaculty(Faculty f) {
        try {
            Connection con = DBConnection.getConnection();

            // update users
            PreparedStatement ps1 = con.prepareStatement(
                "UPDATE users SET name=?, email=? WHERE user_id=?"
            );
            ps1.setString(1, f.getName());
            ps1.setString(2, f.getEmail());
            ps1.setInt(3, f.getFacultyId());
            ps1.executeUpdate();

            // update faculty
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE faculty SET department=? WHERE faculty_id=?"
            );
            ps2.setString(1, f.getDepartment());
            ps2.setInt(2, f.getFacultyId());
            ps2.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}