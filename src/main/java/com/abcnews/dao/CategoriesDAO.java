package com.abcnews.dao;

import com.abcnews.model.Categories;
import com.abcnews.util.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    /**
     * Lấy tất cả các loại tin từ CSDL.
     * @return Danh sách các đối tượng Categories.
     */
    public List<Categories> getAllCategories() {
        List<Categories> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORIES ORDER BY [Name] ASC"; // Sắp xếp theo tên cho đẹp

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categories category = new Categories();
                category.setId(rs.getString("Id"));
                category.setName(rs.getString("Name"));
                categoryList.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryList;
    }
}