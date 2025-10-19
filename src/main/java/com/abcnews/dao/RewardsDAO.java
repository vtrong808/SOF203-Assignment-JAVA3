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

    public Rewards findRewardById(String id) {
        String sql = "SELECT * FROM REWARDS WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Rewards reward = new Rewards();
                    reward.setId(rs.getString("Id"));
                    reward.setName(rs.getString("Name"));
                    reward.setPointsRequired(rs.getInt("PointsRequired"));
                    reward.setImage(rs.getString("Image"));
                    return reward;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addReward(Rewards reward) {
        String sql = "INSERT INTO REWARDS (Id, [Name], PointsRequired, Image) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reward.getId());
            ps.setString(2, reward.getName());
            ps.setInt(3, reward.getPointsRequired());
            ps.setString(4, reward.getImage());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateReward(Rewards reward) {
        String sql = "UPDATE REWARDS SET [Name] = ?, PointsRequired = ?, Image = ? WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reward.getName());
            ps.setInt(2, reward.getPointsRequired());
            ps.setString(3, reward.getImage());
            ps.setString(4, reward.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteReward(String rewardId) {
        String sql = "DELETE FROM REWARDS WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rewardId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}