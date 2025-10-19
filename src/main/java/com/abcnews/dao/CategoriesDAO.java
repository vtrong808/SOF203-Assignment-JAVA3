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

    public void addCategory(Categories category) {
        String sql = "INSERT INTO CATEGORIES (Id, [Name]) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getId());
            ps.setString(2, category.getName());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCategory(Categories category) {
        String sql = "UPDATE CATEGORIES SET [Name] = ? WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(String categoryId) {
        // Lưu ý: Cần xử lý các tin tức thuộc danh mục này trước khi xóa
        // Ví dụ: Chuyển các tin tức đó sang một danh mục mặc định hoặc không cho xóa
        // Ở đây, chúng ta tạm thời giả định có thể xóa được
        String sql = "DELETE FROM CATEGORIES WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}