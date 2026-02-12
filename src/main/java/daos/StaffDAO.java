package daos;

import models.Staff;
import utils.dbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    // Create (insert) a new staff member
    public boolean create(Staff staff) {
        String sql = "INSERT INTO staff (full_name, username, password_hash, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, staff.getFullName());
            stmt.setString(2, staff.getUsername());
            stmt.setString(3, staff.getPasswordHash());
            stmt.setString(4, staff.getRole());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }

            // Set generated staffId back to POJO
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    staff.setStaffId(rs.getInt(1));
                }
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read by staffId
    public Staff read(int staffId) {
        String sql = "SELECT * FROM staff WHERE staff_id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToStaff(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Read by username (useful for login)
    public static Staff readByUsername(String username) {
        String sql = "SELECT * FROM staff WHERE username = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToStaff(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update staff
    public boolean update(Staff staff) {
        String sql = "UPDATE staff SET full_name = ?, username = ?, password_hash = ?, role = ? WHERE staff_id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, staff.getFullName());
            stmt.setString(2, staff.getUsername());
            stmt.setString(3, staff.getPasswordHash());
            stmt.setString(4, staff.getRole());
            stmt.setInt(5, staff.getStaffId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete staff
    public boolean delete(int staffId) {
        String sql = "DELETE FROM staff WHERE staff_id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // List all staff
    public List<Staff> listAll() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM staff ORDER BY staff_id";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                staffList.add(mapRowToStaff(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    // Helper method to map ResultSet to Staff POJO
    private static Staff mapRowToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setStaffId(rs.getInt("staff_id"));
        staff.setFullName(rs.getString("full_name"));
        staff.setUsername(rs.getString("username"));
        staff.setPasswordHash(rs.getString("password_hash"));
        staff.setRole(rs.getString("role"));
        return staff;
    }
}
