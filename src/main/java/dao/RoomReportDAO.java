package dao;

import java.sql.*;

import model.RoomReport;
import util.DBConnection;

public class RoomReportDAO {

    public RoomReport generateReport() {

        RoomReport report = new RoomReport();

        try {

            Connection con = DBConnection.getConnection();

            // =========================
            // BUSIEST ROOM
            // =========================

            String busiestSql =
            "SELECT c.room_number, COUNT(*) AS total " +
            "FROM timetable t " +
            "JOIN classrooms c ON t.room_id = c.room_id " +
            "GROUP BY c.room_number " +
            "ORDER BY total DESC LIMIT 1";

            PreparedStatement ps1 =
            con.prepareStatement(busiestSql);

            ResultSet rs1 = ps1.executeQuery();

            if(rs1.next()){

                String room =
                rs1.getString("room_number");

                report.setBusiestRoom(
                    room +
                    " is the most utilized classroom based on total occupied lectures."
                );
            }

            // =========================
            // PEAK TIME
            // =========================

            String peakSql =
            "SELECT start_time, COUNT(*) AS total " +
            "FROM timetable " +
            "GROUP BY start_time " +
            "ORDER BY total DESC LIMIT 1";

            PreparedStatement ps2 =
            con.prepareStatement(peakSql);

            ResultSet rs2 = ps2.executeQuery();

            if(rs2.next()){

                String time =
                rs2.getString("start_time");

                report.setPeakTime(
                    "Peak classroom occupancy occurs around "
                    + time +
                    ". Most rooms are occupied during this period."
                );
            }

            // =========================
            // UNDERUTILIZED ROOM
            // =========================

            String underSql =
            "SELECT c.room_number, COUNT(t.room_id) AS total " +
            "FROM classrooms c " +
            "LEFT JOIN timetable t " +
            "ON c.room_id = t.room_id " +
            "GROUP BY c.room_number " +
            "ORDER BY total ASC LIMIT 1";

            PreparedStatement ps3 =
            con.prepareStatement(underSql);

            ResultSet rs3 = ps3.executeQuery();

            if(rs3.next()){

                String room =
                rs3.getString("room_number");

                report.setUnderutilizedRoom(
                    room +
                    " is comparatively underutilized and has several free slots available for allocation."
                );
            }

            // =========================
            // USAGE PATTERN
            // =========================

            report.setUsagePattern(
                "Most classrooms are heavily occupied during mid-day sessions while evening slots remain comparatively less busy."
            );

        } catch(Exception e){
            e.printStackTrace();
        }

        return report;
    }
}