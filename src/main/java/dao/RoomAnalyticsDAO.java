package dao;

import java.sql.*;
import java.util.*;
import model.RoomUtilization;
import util.DBConnection;

public class RoomAnalyticsDAO {

    public List<RoomUtilization> getRoomUtilization() {

        List<RoomUtilization> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT c.room_id, c.room_number, " +

                // Lecture count (OLD)
                "IFNULL(w.weekly_count,0) AS weekly_count, " +
                "IFNULL(d.daily_count,0) AS daily_count, " +

                // Time calculation (NEW)
                "IFNULL(w.weekly_hours,0) AS weekly_hours, " +
                "IFNULL(d.daily_hours,0) AS daily_hours " +

                "FROM classrooms c " +

                // WEEKLY DATA
                "LEFT JOIN (" +
                "   SELECT room_id, " +
                "   COUNT(*) AS weekly_count, " +
                "   SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time))/60 AS weekly_hours " +
                "   FROM timetable GROUP BY room_id" +
                ") w ON c.room_id = w.room_id " +

                // DAILY DATA
                "LEFT JOIN (" +
                "   SELECT room_id, " +
                "   COUNT(*) AS daily_count, " +
                "   SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time))/60 AS daily_hours " +
                "   FROM daily_timetable GROUP BY room_id" +
                ") d ON c.room_id = d.room_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Max hours assumption (5 days × 8 hours)
            int TOTAL_HOURS = 40;

            while (rs.next()) {

                RoomUtilization r = new RoomUtilization();

                // ===== Lecture Count =====
                int weeklyCount = rs.getInt("weekly_count");
                int dailyCount = rs.getInt("daily_count");
                int totalCount = weeklyCount + dailyCount;

                // ===== Time Usage (NEW) =====
                double weeklyHours = rs.getDouble("weekly_hours");
                double dailyHours = rs.getDouble("daily_hours");
                double totalHours = weeklyHours + dailyHours;

                // ===== Utilization % (BASED ON HOURS) =====
                double percent = (TOTAL_HOURS == 0) ? 0 :
                        (totalHours / TOTAL_HOURS) * 100;

                // ===== SET VALUES =====
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomName(rs.getString("room_number"));

                // Old fields
                r.setWeeklyLectures(weeklyCount);
                r.setDailyLectures(dailyCount);
                r.setTotalLectures(totalCount);

                // New fields
                r.setWeeklyHours(weeklyHours);
                r.setDailyHours(dailyHours);
                r.setTotalHours(totalHours);

                r.setUtilizationPercent(percent);

                list.add(r);

                // DEBUG (optional)
                System.out.println("Room: " + r.getRoomName() +
                        " | WeeklyHours: " + weeklyHours +
                        " | DailyHours: " + dailyHours);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}