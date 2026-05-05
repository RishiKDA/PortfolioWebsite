package dao;

import model.Experience;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExperienceDAO {

    public List<Experience> getAllExperience() {
        List<Experience> list = new ArrayList<>();
        String sql = "SELECT * FROM experience ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Experience ex = new Experience();
                ex.setId(rs.getInt("id"));
                ex.setRole(rs.getString("role"));
                ex.setCompany(rs.getString("company"));
                ex.setDuration(rs.getString("duration"));
                ex.setDescription(rs.getString("description"));
                list.add(ex);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
