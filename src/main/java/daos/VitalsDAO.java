package daos;

import models.Vitals;
import utils.dbConnection;

import java.sql.*;

public class VitalsDAO {

    public boolean create(Vitals vitals) {
        String sql = "INSERT INTO vitals (visit_id, nurse_id, temperature, blood_pressure, weight) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vitals.getVisitId());
            stmt.setInt(2, vitals.getNurseId());
            stmt.setDouble(3, vitals.getTemperature());
            stmt.setString(4, vitals.getBloodPressure());
            stmt.setDouble(5, vitals.getWeight());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
