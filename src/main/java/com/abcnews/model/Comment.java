package com.abcnews.model;

import java.util.Date;

public class Comment {
    private int id;
    private String newsId;
    private String userId;
    private String content;
    private Date postedDate;

    // Thêm một trường để giữ tên của người dùng (lấy qua JOIN)
    private String userFullname;

    // Constructors
    public Comment() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNewsId() { return newsId; }
    public void setNewsId(String newsId) { this.newsId = newsId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getPostedDate() { return postedDate; }
    public void setPostedDate(Date postedDate) { this.postedDate = postedDate; }
    public String getUserFullname() { return userFullname; }
    public void setUserFullname(String userFullname) { this.userFullname = userFullname; }
}