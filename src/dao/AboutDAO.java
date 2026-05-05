package dao;

import model.*;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// ─────────────────────────────────────────────
// AboutDAO
// ─────────────────────────────────────────────
public class AboutDAO {

    public About getAbout() {
        String sql = "SELECT * FROM about LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                About a = new About();
                a.setId(rs.getInt("id"));
                a.setFullName(rs.getString("full_name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setObjective(rs.getString("objective"));
                a.setGithubUrl(rs.getString("github_url"));
                a.setLinkedinUrl(rs.getString("linkedin_url"));
                a.setLanguagesSpoken(rs.getString("languages_spoken"));
                a.setSoftSkills(rs.getString("soft_skills"));
                return a;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}
