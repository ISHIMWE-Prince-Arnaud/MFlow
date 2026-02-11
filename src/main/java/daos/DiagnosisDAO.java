package daos;

import models.Diagnosis;
import utils.dbConnection;

import java.sql.*;

public class DiagnosisDAO {

    public boolean create(Diagnosis diagnosis) {
        String sql = "INSERT INTO diagnosis (visit_id, doctor_id, notes, prescription) VALUES (?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, diagnosis.getVisitId());
            stmt.setInt(2, diagnosis.getDoctorId());
            stmt.setString(3, diagnosis.getNotes());
            stmt.setString(4, diagnosis.getPrescription());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
