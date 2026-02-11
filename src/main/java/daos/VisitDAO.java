package daos;

import models.Visit;
import utils.dbConnection;

import java.sql.*;

public class VisitDAO {

    public boolean create(Visit visit) {
        String sql = "INSERT INTO visits (patient_id, reception_id, visit_status) VALUES (?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, visit.getPatientId());
            stmt.setInt(2, visit.getReceptionId());
            stmt.setString(3, visit.getVisitStatus());

            int affected = stmt.executeUpdate();
            if (affected == 0) return false;

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    visit.setVisitId(rs.getInt(1));
                }
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Visit read(int visitId) {
        String sql = "SELECT * FROM visits WHERE visit_id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, visitId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return getVisit(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    private static Visit getVisit(ResultSet rs) throws SQLException {
        Visit v = new Visit();
        v.setVisitId(rs.getInt("visit_id"));
        v.setPatientId(rs.getInt("patient_id"));
        v.setReceptionId(rs.getInt("reception_id"));
        v.setVisitStatus(rs.getString("visit_status"));
        v.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return v;
    }
}
