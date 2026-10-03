package model;

public class RoomReport {

    private String busiestRoom;
    private String peakTime;
    private String underutilizedRoom;
    private String usagePattern;

    public String getBusiestRoom() {
        return busiestRoom;
    }

    public void setBusiestRoom(String busiestRoom) {
        this.busiestRoom = busiestRoom;
    }

    public String getPeakTime() {
        return peakTime;
    }

    public void setPeakTime(String peakTime) {
        this.peakTime = peakTime;
    }

    public String getUnderutilizedRoom() {
        return underutilizedRoom;
    }

    public void setUnderutilizedRoom(String underutilizedRoom) {
        this.underutilizedRoom = underutilizedRoom;
    }

    public String getUsagePattern() {
        return usagePattern;
    }

    public void setUsagePattern(String usagePattern) {
        this.usagePattern = usagePattern;
    }
}