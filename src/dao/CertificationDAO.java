package dao;

import model.Certification;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CertificationDAO {

    public List<Certification> getAllCertifications() {
        List<Certification> list = new ArrayList<>();
        String sql = "SELECT * FROM certifications ORDER BY year DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Certification c = new Certification();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setIssuer(rs.getString("issuer"));
                c.setYear(rs.getString("year"));
                list.add(c);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
