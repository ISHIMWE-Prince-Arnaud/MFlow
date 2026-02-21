package daos;

import models.ArchiveRecord;
import models.Visit;
import models.VisitDetails;
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

    public VisitDetails getVisitDetails(int visitId) throws SQLException {
        String sql = "SELECT \n" +
                "    v.visit_id,\n" +
                "    v.created_at,\n" +
                "    v.visit_status,\n" +
                "\n" +
                "    p.full_name AS patient_name,\n" +
                "    p.gender,\n" +
                "    p.date_of_birth,\n" +
                "    p.phone,\n" +
                "\n" +
                "    r.full_name AS receptionist_name,\n" +
                "\n" +
                "    vit.temperature,\n" +
                "    vit.blood_pressure,\n" +
                "    vit.weight,\n" +
                "    n.full_name AS nurse_name,\n" +
                "\n" +
                "    d.notes,\n" +
                "    d.prescription,\n" +
                "    doc.full_name AS doctor_name,\n" +
                "\n" +
                "    ph.medication,\n" +
                "    ph.dispensed_at,\n" +
                "    phs.full_name AS pharmacist_name\n" +
                "FROM visits v\n" +
                "JOIN patients p ON v.patient_id = p.patient_id\n" +
                "JOIN staff r ON v.reception_id = r.staff_id\n" +
                "LEFT JOIN vitals vit ON v.visit_id = vit.visit_id\n" +
                "LEFT JOIN staff n ON vit.nurse_id = n.staff_id\n" +
                "LEFT JOIN diagnosis d ON v.visit_id = d.visit_id\n" +
                "LEFT JOIN staff doc ON d.doctor_id = doc.staff_id\n" +
                "LEFT JOIN pharmacy ph ON v.visit_id = ph.visit_id\n" +
                "LEFT JOIN staff phs ON ph.pharmacist_id = phs.staff_id\n" +
                "WHERE v.visit_id = ?";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, visitId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if (resultSet.next()) {
                    VisitDetails visitDetails = new VisitDetails();
                    visitDetails.setVisitId(resultSet.getInt("visit_id"));
                    visitDetails.setVisitStatus(resultSet.getString("visit_status"));

                    // Handle created_at
                    Timestamp createdAt = resultSet.getTimestamp("created_at");
                    if (createdAt != null) {
                        visitDetails.setVisitDate(createdAt.toLocalDateTime());
                    }

                    visitDetails.setPatientName(resultSet.getString("patient_name"));
                    visitDetails.setGender(resultSet.getString("gender"));

                    // Handle nullable date_of_birth
                    Timestamp dob = resultSet.getTimestamp("date_of_birth");
                    if (dob != null) {
                        visitDetails.setDateOfBirth(dob.toLocalDateTime().toLocalDate());
                    }

                    visitDetails.setPhone(resultSet.getString("phone"));
                    visitDetails.setReceptionistName(resultSet.getString("receptionist_name"));

                    // Nullable numeric fields (Double instead of double)
                    Double temperature = resultSet.getDouble("temperature");
                    if (resultSet.wasNull()) temperature = null;
                    visitDetails.setTemperature(temperature);

                    visitDetails.setBloodPressure(resultSet.getString("blood_pressure"));

                    Double weight = resultSet.getDouble("weight");
                    if (resultSet.wasNull()) weight = null;
                    visitDetails.setWeight(weight);

                    visitDetails.setNurseName(resultSet.getString("nurse_name"));
                    visitDetails.setDoctorName(resultSet.getString("doctor_name"));
                    visitDetails.setNotes(resultSet.getString("notes"));
                    visitDetails.setPrescription(resultSet.getString("prescription"));
                    visitDetails.setMedication(resultSet.getString("medication"));
                    visitDetails.setPharmacistName(resultSet.getString("pharmacist_name"));

                    // Nullable dispensed_at timestamp
                    Timestamp dispensedTs = resultSet.getTimestamp("dispensed_at");
                    if (dispensedTs != null) {
                        visitDetails.setDispensedAt(dispensedTs.toLocalDateTime());
                    }

                    return visitDetails;
                }

                return null;
            }
        }
    }

    public List<Visit> getVisitsByStatus(String status) {
        List<Visit> visits = new ArrayList<>();
        String sql = "SELECT v.visit_id, v.patient_id, v.reception_id, v.visit_status, v.created_at, p.full_name AS patient_name " +
                     "FROM visits v " +
                     "JOIN patients p ON v.patient_id = p.patient_id " +
                     "WHERE v.visit_status = ? " +
                     "ORDER BY v.created_at ASC";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Visit visit = getVisit(rs);
                    visit.setPatientName(rs.getString("patient_name"));
                    visits.add(visit);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return visits;
    }

    public List<Visit> getVisitsByReceptionistAndStatus(int receptionistId, String status) {
        List<Visit> visits = new ArrayList<>();
        String sql = "SELECT v.visit_id, v.patient_id, v.reception_id, v.visit_status, v.created_at, p.full_name AS patient_name " +
                     "FROM visits v " +
                     "JOIN patients p ON v.patient_id = p.patient_id " +
                     "WHERE v.reception_id = ? AND v.visit_status = ? " +
                     "ORDER BY v.created_at DESC";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, receptionistId);
            stmt.setString(2, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Visit visit = getVisit(rs);
                    visit.setPatientName(rs.getString("patient_name"));
                    visits.add(visit);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return visits;
    }
}
