package daos;

import models.Pharmacy;
import utils.dbConnection;

import java.sql.*;

public class PharmacyDAO {

    public boolean create(Pharmacy pharmacy) {
        String sql = "INSERT INTO pharmacy (visit_id, pharmacist_id, medication) VALUES (?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, pharmacy.getVisitId());
            stmt.setInt(2, pharmacy.getPharmacistId());
            stmt.setString(3, pharmacy.getMedication());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
