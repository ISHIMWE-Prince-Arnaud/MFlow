package models;

import java.time.LocalDateTime;

public class ArchiveRecord {
    private int visitId;
    private String patientName;
    private String doctorName;
    private String medication;
    private LocalDateTime visitDate;

    public ArchiveRecord() {}

    public ArchiveRecord(int visitId, String patientName, String doctorName, String medication, LocalDateTime visitDate) {
        this.visitId = visitId;
        this.patientName = patientName;
        this.doctorName = doctorName;
        this.medication = medication;
        this.visitDate = visitDate;
    }

    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getMedication() {
        return medication;
    }

    public void setMedication(String medication) {
        this.medication = medication;
    }

    public LocalDateTime getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(LocalDateTime visitDate) {
        this.visitDate = visitDate;
    }
}
