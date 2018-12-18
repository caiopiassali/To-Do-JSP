package br.com.todo.utils;

import java.sql.*;

public class ConnectionFactory {

    public static Connection getConnection() throws SQLException, Exception {
        try {
            Class.forName("org.postgresql.Driver");

            return DriverManager.getConnection("jdbc:postgresql://localhost:5432/todo","postgres","123456");
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public static void closeConnection(Connection conn, Statement stmt, ResultSet rs) throws Exception{
        close(conn, stmt, rs);
    }

    public static void closeConnection(Connection conn, Statement stmt) throws Exception {
        close(conn, stmt,null);
    }

    public static void closeConnection(Connection conn) throws Exception {
        close(conn, null,null);
    }

    private static void close(Connection conn, Statement stmt, ResultSet rs) throws Exception {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

}
