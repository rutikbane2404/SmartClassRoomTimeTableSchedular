package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Student;
import util.DBConnection;

public class StudentDAO {

    Connection con;

    
    
    // 🔥 ADD STUDENT

    public boolean addStudent(
            String name,
            String email,
            String password,
            String phone,
            int classId){

        boolean status = false;

        try{

            con = DBConnection.getConnection();

            
            
            // 🔥 INSERT INTO USERS

            String userSql =

            "INSERT INTO users(name,email,password,role) " +

            "VALUES(?,?,?,?)";

            PreparedStatement userPs =
            con.prepareStatement(userSql,
            PreparedStatement.RETURN_GENERATED_KEYS);

            userPs.setString(1, name);
            userPs.setString(2, email);
            userPs.setString(3, password);
            userPs.setString(4, "STUDENT");

            int row1 = userPs.executeUpdate();

            
            
            // 🔥 GET GENERATED USER ID

            ResultSet rs =
            userPs.getGeneratedKeys();

            int userId = 0;

            if(rs.next()){

                userId = rs.getInt(1);
            }

            
            
            // 🔥 INSERT INTO STUDENTS

            String sql =

            "INSERT INTO students(student_id,class_id,phone) " +

            "VALUES(?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, userId);

            ps.setInt(2, classId);

            ps.setString(3, phone);

            int row2 = ps.executeUpdate();

            if(row1 > 0 && row2 > 0){

                status = true;
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return status;
    }

    
    
    // 🔥 GET ALL STUDENTS

    public List<Student> getAllStudents(){

        List<Student> list = new ArrayList<>();

        try{

            con = DBConnection.getConnection();

            String sql =

            "SELECT s.student_id,s.class_id,s.phone," +

            "u.name,u.email,u.password," +

            "c.class_name " +

            "FROM students s " +

            "JOIN users u " +

            "ON s.student_id=u.user_id " +

            "LEFT JOIN classes c " +

            "ON s.class_id=c.class_id " +

            "WHERE u.role='STUDENT'";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ResultSet rs =
            ps.executeQuery();

            while(rs.next()){

                Student s = new Student();

                s.setStudentId(
                rs.getInt("student_id"));

                s.setName(
                rs.getString("name"));

                s.setEmail(
                rs.getString("email"));

                s.setPassword(
                rs.getString("password"));

                s.setPhone(
                rs.getString("phone"));

                s.setClassId(
                rs.getInt("class_id"));

                s.setClassName(
                rs.getString("class_name"));

                list.add(s);
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return list;
    }

    
    
    // 🔥 DELETE STUDENT

    public boolean deleteStudent(int id){

        boolean status = false;

        try{

            Connection con =
            DBConnection.getConnection();

            // DELETE FEEDBACK

            String feedbackSql =
            "DELETE FROM feedback WHERE student_id=?";

            PreparedStatement feedbackPs =
            con.prepareStatement(feedbackSql);

            feedbackPs.setInt(1, id);

            feedbackPs.executeUpdate();

            // DELETE NOTIFICATIONS

            String notificationSql =
            "DELETE FROM notifications WHERE user_id=?";

            PreparedStatement notificationPs =
            con.prepareStatement(notificationSql);

            notificationPs.setInt(1, id);

            notificationPs.executeUpdate();

            // DELETE STUDENT

            String sql =
            "DELETE FROM students WHERE student_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            int row =
            ps.executeUpdate();

            // DELETE USER

            String userSql =
            "DELETE FROM users WHERE user_id=?";

            PreparedStatement userPs =
            con.prepareStatement(userSql);

            userPs.setInt(1, id);

            userPs.executeUpdate();

            if(row > 0){
                status = true;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    
    
    // 🔥 GET STUDENT BY ID

    public Student getStudentById(int id){

        Student s = new Student();

        try{

            con = DBConnection.getConnection();

            String sql =

            "SELECT s.student_id,s.class_id,s.phone," +

            "u.name,u.email,u.password," +

            "c.class_name " +

            "FROM students s " +

            "JOIN users u " +

            "ON s.student_id=u.user_id " +

            "LEFT JOIN classes c " +

            "ON s.class_id=c.class_id " +

            "WHERE s.student_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                s.setStudentId(
                rs.getInt("student_id"));

                s.setName(
                rs.getString("name"));

                s.setEmail(
                rs.getString("email"));

                s.setPassword(
                rs.getString("password"));

                s.setPhone(
                rs.getString("phone"));

                s.setClassId(
                rs.getInt("class_id"));

                s.setClassName(
                rs.getString("class_name"));
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return s;
    }

    
    
    // 🔥 UPDATE STUDENT

    public boolean updateStudent(Student s){

        boolean status = false;

        try{

            Connection con = DBConnection.getConnection();

            // UPDATE students table
            String sql =
            "UPDATE students SET phone=?, class_id=? WHERE student_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, s.getPhone());
            ps.setInt(2, s.getClassId());
            ps.setInt(3, s.getStudentId());

            int row = ps.executeUpdate();

            // UPDATE users table
            String userSql =
            "UPDATE users SET name=?, email=? WHERE user_id=?";

            PreparedStatement userPs = con.prepareStatement(userSql);

            userPs.setString(1, s.getName());
            userPs.setString(2, s.getEmail());
            userPs.setInt(3, s.getStudentId());

            userPs.executeUpdate();

            if(row > 0){
                status = true;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

}