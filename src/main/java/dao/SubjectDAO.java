package dao;

import java.sql.*;
import java.util.*;
import model.Subject;
import util.DBConnection;

public class SubjectDAO {

    // ADD SUBJECT
    public void addSubject(Subject s) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO subjects(subject_name, subject_code, credits, faculty_id) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, s.getSubjectName());
            ps.setString(2, s.getSubjectCode());
            ps.setInt(3, s.getCredits());
            ps.setInt(4, s.getFacultyId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET ALL SUBJECTS
    public List<Subject> getAllSubjects() {
        List<Subject> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT s.*, u.name AS faculty_name " +
                         "FROM subjects s " +
                         "LEFT JOIN faculty f ON s.faculty_id = f.faculty_id " +
                         "LEFT JOIN users u ON f.faculty_id = u.user_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Subject s = new Subject();

                s.setSubjectId(rs.getInt("subject_id"));
                s.setSubjectName(rs.getString("subject_name"));
                s.setSubjectCode(rs.getString("subject_code"));
                s.setCredits(rs.getInt("credits"));
                s.setFacultyId(rs.getInt("faculty_id"));

                // NEW FIELD
                s.setFacultyName(rs.getString("faculty_name"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // DELETE SUBJECT
    public void deleteSubject(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM subjects WHERE subject_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
 // UPDATE SUBJECT
    public void updateSubject(Subject s) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE subjects SET subject_name=?, subject_code=?, credits=?, faculty_id=? WHERE subject_id=?";
            
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, s.getSubjectName());
            ps.setString(2, s.getSubjectCode());
            ps.setInt(3, s.getCredits());
            ps.setInt(4, s.getFacultyId());
            ps.setInt(5, s.getSubjectId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}

