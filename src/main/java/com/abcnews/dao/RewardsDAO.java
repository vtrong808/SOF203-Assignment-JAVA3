package com.abcnews.dao;

import com.abcnews.model.Rewards;
import com.abcnews.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RewardsDAO {

    public List<Rewards> getAllRewards() {
        List<Rewards> rewardsList = new ArrayList<>();
        String sql = "SELECT * FROM REWARDS ORDER BY PointsRequired ASC"; // Sắp xếp theo điểm tăng dần

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Rewards reward = new Rewards();
                reward.setId(rs.getString("Id"));
                reward.setName(rs.getString("Name"));
                reward.setPointsRequired(rs.getInt("PointsRequired"));
                reward.setImage(rs.getString("Image"));
                rewardsList.add(reward);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rewardsList;
    }
}