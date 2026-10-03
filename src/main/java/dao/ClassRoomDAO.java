package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Classroom;
import util.DBConnection;

public class ClassRoomDAO {

    // =========================
    // GET ALL CLASSROOMS
    // =========================
    public List<Classroom> getAllRooms() {

        List<Classroom> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM classrooms ORDER BY room_id DESC";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Classroom c = new Classroom();

                c.setRoomId(
                rs.getInt("room_id"));

                c.setRoomNumber(
                rs.getString("room_number"));

                c.setCapacity(
                rs.getInt("capacity"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================
    // ADD CLASSROOM
    // =========================
    public boolean addRoom(Classroom c) {

        boolean status = false;

        try {

            Connection con =
            DBConnection.getConnection();

            String sql =
            "INSERT INTO classrooms(room_number,capacity) VALUES(?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1,
            c.getRoomNumber());

            ps.setInt(2,
            c.getCapacity());

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // DELETE CLASSROOM
    // =========================
    public boolean deleteRoom(int id) {

        boolean status = false;

        try {

            Connection con =
            DBConnection.getConnection();

            String sql =
            "DELETE FROM classrooms WHERE room_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // GET ROOM BY ID
    // =========================
    public Classroom getRoomById(int id) {

        Classroom c = null;

        try {

            Connection con =
            DBConnection.getConnection();

            String sql =
            "SELECT * FROM classrooms WHERE room_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                c = new Classroom();

                c.setRoomId(
                rs.getInt("room_id"));

                c.setRoomNumber(
                rs.getString("room_number"));

                c.setCapacity(
                rs.getInt("capacity"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

    // =========================
    // UPDATE CLASSROOM
    // =========================
    public boolean updateRoom(Classroom c) {

        boolean status = false;

        try {

            Connection con =
            DBConnection.getConnection();

            String sql =
            "UPDATE classrooms SET room_number=?, capacity=? WHERE room_id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1,
            c.getRoomNumber());

            ps.setInt(2,
            c.getCapacity());

            ps.setInt(3,
            c.getRoomId());

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}