package models;

import java.time.LocalDateTime;

public class Diagnosis {

    private int diagnosisId;
    private int visitId;
    private int doctorId;
    private String notes;
    private String prescription;
    private LocalDateTime diagnosedAt;

    public Diagnosis() {};

    public Diagnosis(int diagnosisId, int visitId, int doctorId, String notes, String prescription, LocalDateTime diagnosedAt) {
        this.diagnosisId = diagnosisId;
        this.visitId = visitId;
        this.doctorId = doctorId;
        this.notes = notes;
        this.prescription = prescription;
        this.diagnosedAt = diagnosedAt;
    }

    @Override
    public String toString() {
        return "Diagnosis [diagnosisId=" + diagnosisId + ", visitId=" + visitId + ", doctorId=" + doctorId + "]";
    }

    public int getDiagnosisId() {
        return diagnosisId;
    }

    public void setDiagnosisId(int diagnosisId) {
        this.diagnosisId = diagnosisId;
    }

    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public LocalDateTime getDiagnosedAt() {
        return diagnosedAt;
    }

    public void setDiagnosedAt(LocalDateTime diagnosedAt) {
        this.diagnosedAt = diagnosedAt;
    }
}
