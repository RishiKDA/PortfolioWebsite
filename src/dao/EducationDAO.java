package dao;

import model.Education;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EducationDAO {

    public List<Education> getAllEducation() {
        List<Education> list = new ArrayList<>();
        String sql = "SELECT * FROM education ORDER BY start_year DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Education e = new Education();
                e.setId(rs.getInt("id"));
                e.setDegree(rs.getString("degree"));
                e.setInstitution(rs.getString("institution"));
                e.setStartYear(rs.getString("start_year"));
                e.setEndYear(rs.getString("end_year"));
                e.setCgpa(rs.getString("cgpa"));
                e.setDescription(rs.getString("description"));
                list.add(e);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
