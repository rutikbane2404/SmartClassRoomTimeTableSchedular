package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String dbPassword = System.getenv("DB_PASSWORD");

            if (dbPassword == null || dbPassword.isEmpty()) {
                throw new RuntimeException(
                    "DB_PASSWORD environment variable is not set."
                );
            }

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/smartclassroomtimetableschedular",
                "root",
                dbPassword
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}