package daos;

import models.ArchiveRecord;
import models.Visit;
import utils.dbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    public boolean updateStatus(int visitId, String status) {
        String sql = "UPDATE visits SET visit_status = ? WHERE visit_id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, visitId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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

    public List<ArchiveRecord> getArchivedRecords() {
        List<ArchiveRecord> records = new ArrayList<>();

        String sql = "SELECT v.visit_id,\n" +
                "       p.full_name AS patient_name,\n" +
                "       s.full_name AS doctor_name,\n" +
                "       ph.medication,\n" +
                "       v.created_at\n" +
                "FROM visits v\n" +
                "JOIN patients p ON v.patient_id = p.patient_id\n" +
                "LEFT JOIN diagnosis d ON v.visit_id = d.visit_id\n" +
                "LEFT JOIN staff s ON d.doctor_id = s.staff_id\n" +
                "LEFT JOIN pharmacy ph ON v.visit_id = ph.visit_id\n" +
                "WHERE v.visit_status = 'COMPLETED'\n" +
                "ORDER BY v.created_at DESC;";

        try(Connection connection = dbConnection.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ArchiveRecord record = new ArchiveRecord();
                record.setVisitId(resultSet.getInt("visit_id"));
                record.setPatientName(resultSet.getString("patient_name"));
                record.setDoctorName(resultSet.getString("doctor_name"));
                record.setMedication(resultSet.getString("medication"));
                record.setVisitDate(resultSet.getTimestamp("created_at").toLocalDateTime());

                records.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return records;
    }
}
