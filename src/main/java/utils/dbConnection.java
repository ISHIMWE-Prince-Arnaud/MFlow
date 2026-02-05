package utils;

import java.sql.*;

public class dbConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/mflow_db";
    private static final String USER = "postgres";
    private static final String PASSWORD = "ishkpro";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found.", e);
        }
    }

    private dbConnection() {}

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
