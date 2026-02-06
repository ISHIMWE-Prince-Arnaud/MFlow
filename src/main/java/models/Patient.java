package models;

import java.time.LocalDate;

public class Patient {
    private int patientId;
    private String fullName;
    private String gender;
    private LocalDate dateOfBirth;
    private String phone;

    public Patient() {};

    public Patient(int patientId, String fullName, String gender, LocalDate dateOfBirth, String phone) {
        this.patientId = patientId;
        this.fullName = fullName;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Patient [patientId=" + patientId + ", fullName=" + fullName + "]";
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
