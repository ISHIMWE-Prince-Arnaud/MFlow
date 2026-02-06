package models;

import java.time.LocalDateTime;

public class Visit {

    private int visitId;
    private int patientId;
    private int receptionId;
    private String visitStatus;
    private LocalDateTime createdAt;

    public Visit() {};

    public Visit(int visitId, int patientId, int receptionId, String visitStatus, LocalDateTime createdAt) {
        this.visitId = visitId;
        this.patientId = patientId;
        this.receptionId = receptionId;
        this.visitStatus = visitStatus;
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Visit [visitId=" + visitId + ", patientId=" + patientId + ", receptionId=" + receptionId + "]";
    }

    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public int getReceptionId() {
        return receptionId;
    }

    public void setReceptionId(int receptionId) {
        this.receptionId = receptionId;
    }

    public String getVisitStatus() {
        return visitStatus;
    }

    public void setVisitStatus(String visitStatus) {
        this.visitStatus = visitStatus;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
