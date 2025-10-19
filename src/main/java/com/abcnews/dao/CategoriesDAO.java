package com.abcnews.dao;

import com.abcnews.model.Categories;
import com.abcnews.util.DBContext;
import java.sql.*;

public class CategoriesDAO {
    public Categories findById(String id) {
        String sql = "SELECT * FROM CATEGORIES WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Categories category = new Categories();
                    category.setId(rs.getString("Id"));
                    category.setName(rs.getString("Name"));
                    return category;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}