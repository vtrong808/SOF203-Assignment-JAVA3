package com.abcnews.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestConnection {

    public static void main(String[] args) {
        System.out.println("Testing database connection and listing tables...");

        // Sử dụng try-with-resources để đảm bảo kết nối được đóng tự động
        try (Connection connection = DBContext.getConnection()) {
            if (connection != null) {
                System.out.println("Connection Successful!");
                System.out.println("------------------------------------");

                // Lấy đối tượng DatabaseMetaData từ connection
                DatabaseMetaData metaData = connection.getMetaData();

                // Lấy danh sách các bảng trong CSDL hiện tại
                // Tham số: catalog, schemaPattern, tableNamePattern, types
                String[] types = {"TABLE"};
                try (ResultSet rs = metaData.getTables(connection.getCatalog(), "dbo", "%", types)) {

                    System.out.println("Tables in database '" + connection.getCatalog() + "':");
                    while (rs.next()) {
                        // Tên bảng nằm ở cột thứ 3 với tên là "TABLE_NAME"
                        String tableName = rs.getString("TABLE_NAME");
                        System.out.println(" -> " + tableName);
                    }
                }

            } else {
                System.out.println("Failed to make connection!");
            }
        } catch (SQLException e) {
            System.err.println("Connection Failed! SQL State: " + e.getSQLState() + ", Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found!");
            e.printStackTrace();
        }
    }
}