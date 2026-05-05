package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection — JDBC connection utility for portfolio_db
 * Update DB_URL, DB_USER, DB_PASSWORD to match your MySQL setup.
 */
public class DBConnection {

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/portfolio_db?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "Admin@123";
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. Add mysql-connector-j.jar to WEB-INF/lib", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private DBConnection() { /* utility class — no instantiation */ }
}
