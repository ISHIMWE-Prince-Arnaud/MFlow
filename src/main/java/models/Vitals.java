package models;

import java.time.LocalDateTime;

public class Vitals {
    private int vitalsId;
    private int visitId;
    private int nurseId;
    private double temperature;       // Celsius
    private String bloodPressure;     // e.g., "120/80"
    private double weight;            // kg
    private LocalDateTime recordedAt;

    public Vitals() { }

    public Vitals(int vitalsId, int visitId, int nurseId, double temperature,
                  String bloodPressure, double weight, LocalDateTime recordedAt) {
        this.vitalsId = vitalsId;
        this.visitId = visitId;
        this.nurseId = nurseId;
        this.temperature = temperature;
        this.bloodPressure = bloodPressure;
        this.weight = weight;
        this.recordedAt = recordedAt;
    }

    public int getVitalsId() { return vitalsId; }
    public void setVitalsId(int vitalsId) { this.vitalsId = vitalsId; }

    public int getVisitId() { return visitId; }
    public void setVisitId(int visitId) { this.visitId = visitId; }

    public int getNurseId() { return nurseId; }
    public void setNurseId(int nurseId) { this.nurseId = nurseId; }

    public double getTemperature() { return temperature; }
    public void setTemperature(double temperature) { this.temperature = temperature; }

    public String getBloodPressure() { return bloodPressure; }
    public void setBloodPressure(String bloodPressure) { this.bloodPressure = bloodPressure; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }

    public LocalDateTime getRecordedAt() { return recordedAt; }
    public void setRecordedAt(LocalDateTime recordedAt) { this.recordedAt = recordedAt; }

    @Override
    public String toString() {
        return "Vitals [vitalsId=" + vitalsId + ", visitId=" + visitId + ", nurseId=" + nurseId + "]";
    }
}