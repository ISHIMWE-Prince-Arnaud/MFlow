package models;

import java.time.LocalDateTime;

public class Pharmacy {
    private int pharmacyId;
    private int visitId;
    private int pharmacistId;
    private String medication;
    private LocalDateTime dispensedAt;

    public Pharmacy() {};

    public Pharmacy(int pharmacyId, int visitId, int pharmacistId,  String medication, LocalDateTime dispensedAt) {
        this.pharmacyId = pharmacyId;
        this.visitId = visitId;
        this.pharmacistId = pharmacistId;
        this.medication = medication;
        this.dispensedAt = dispensedAt;
    }

    @Override
    public String toString() {
        return "Pharmacy [pharmacyId=" + pharmacyId + ", visitId=" + visitId + ", pharmacistId=" + pharmacistId + "]";
    }

    public int getPharmacyId() {
        return pharmacyId;
    }

    public void setPharmacyId(int pharmacyId) {
        this.pharmacyId = pharmacyId;
    }

    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public int getPharmacistId() {
        return pharmacistId;
    }

    public void setPharmacistId(int pharmacistId) {
        this.pharmacistId = pharmacistId;
    }

    public String getMedication() {
        return medication;
    }

    public void setMedication(String medication) {
        this.medication = medication;
    }

    public LocalDateTime getDispensedAt() {
        return dispensedAt;
    }

    public void setDispensedAt(LocalDateTime dispensedAt) {
        this.dispensedAt = dispensedAt;
    }
}
