package dao;

import java.sql.*;
import java.util.*;

import model.ClassModel;
import util.DBConnection;

public class ClassDAO {

    // GET ALL CLASSES
    public List<ClassModel> getAllClasses() {

        List<ClassModel> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM classes";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                ClassModel c = new ClassModel();

                c.setClassId(rs.getInt("class_id"));
                c.setClassName(rs.getString("class_name"));
                c.setSemester(rs.getInt("semester"));
                c.setDepartment(rs.getString("department"));

                list.add(c);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    // GET CLASS BY ID
    public ClassModel getClassById(int id){

        ClassModel c = null;

        try{

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT * FROM classes WHERE class_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                c = new ClassModel();

                c.setClassId(rs.getInt("class_id"));
                c.setClassName(rs.getString("class_name"));
                c.setSemester(rs.getInt("semester"));
                c.setDepartment(rs.getString("department"));
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return c;
    }

    // ADD CLASS
    public boolean addClass(ClassModel c){

        boolean status = false;

        try{

            Connection con = DBConnection.getConnection();

            String sql =
            "INSERT INTO classes(class_name, semester, department) VALUES(?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, c.getClassName());
            ps.setInt(2, c.getSemester());
            ps.setString(3, c.getDepartment());

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    // UPDATE CLASS
    public boolean updateClass(ClassModel c){

        boolean status = false;

        try{

            Connection con = DBConnection.getConnection();

            String sql =
            "UPDATE classes SET class_name=?, semester=?, department=? WHERE class_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, c.getClassName());
            ps.setInt(2, c.getSemester());
            ps.setString(3, c.getDepartment());
            ps.setInt(4, c.getClassId());

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    // DELETE CLASS
    public boolean deleteClass(int id){

        boolean status = false;

        try{

            Connection con = DBConnection.getConnection();

            String sql =
            "DELETE FROM classes WHERE class_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }
}