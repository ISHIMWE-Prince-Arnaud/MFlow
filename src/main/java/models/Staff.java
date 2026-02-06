package models;

public class Staff {

    private int staffId;
    private String fullName;
    private String username;
    private String passwordHash;
    private String role;

    public Staff() {};

    public Staff(int staffId, String fullName, String username, String passwordHash, String role) {
        this.staffId = staffId;
        this.fullName = fullName;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
    }

    @Override
    public String toString() {
        return "Staff [staffId=" + staffId + ", fullName=" + fullName + ", username=" + username + ", role=" + role + "]";
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
