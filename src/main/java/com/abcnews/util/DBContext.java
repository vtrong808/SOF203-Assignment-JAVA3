package com.abcnews.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private static final String HOSTNAME = "LAPTOP-7RD7637C";
    private static final String PORT = "1433";
    private static final String DBNAME = "ABCNewsDB";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "A1234b1234@";

    /**
     * Tạo chuỗi kết nối URL cho SQL Server.
     * Thêm 'encrypt=true;trustServerCertificate=true' để tránh lỗi SSL.
     * @return Chuỗi URL kết nối.
     */
    private static String getConnectionString() {
        return String.format("jdbc:sqlserver://%s:%s;databaseName=%s;encrypt=true;trustServerCertificate=true",
                HOSTNAME, PORT, DBNAME);
    }

    /**
     * Phương thức này nhận nhiệm vụ kết nối đến CSDL SQL Server.
     * @return một đối tượng Connection đã kết nối thành công.
     * @throws SQLException Nếu kết nối thất bại.
     * @throws ClassNotFoundException Nếu không tìm thấy driver JDBC.
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(getConnectionString(), USERNAME, PASSWORD);
    }
}