package com.abcnews.listener;

import com.abcnews.dao.CategoriesDAO;
import com.abcnews.model.Categories;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.List;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Phương thức này được gọi khi ứng dụng khởi động
        ServletContext context = sce.getServletContext();
        CategoriesDAO categoriesDAO = new CategoriesDAO();
        List<Categories> categoryList = categoriesDAO.getAllCategories();

        // Lưu danh sách vào application scope để mọi JSP có thể truy cập
        context.setAttribute("appCategories", categoryList);
        System.out.println("=> Đã tải danh sách loại tin vào Application Scope.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Được gọi khi ứng dụng dừng, không cần làm gì ở đây
    }
}