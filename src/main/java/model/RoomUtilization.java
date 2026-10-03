package model;

public class RoomUtilization {

    private int roomId;
    private String roomName;
    private int weeklyLectures;
    private int dailyLectures;
    private int totalLectures;
    private double utilizationPercent;
    private double weeklyHours;
    private double dailyHours;
    private double totalHours;

    public int getRoomId() {
        return roomId;
    }

    public double getWeeklyHours() {
		return weeklyHours;
	}

	public void setWeeklyHours(double weeklyHours) {
		this.weeklyHours = weeklyHours;
	}

	public double getDailyHours() {
		return dailyHours;
	}

	public void setDailyHours(double dailyHours) {
		this.dailyHours = dailyHours;
	}

	public double getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(double totalHours) {
		this.totalHours = totalHours;
	}

	public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getWeeklyLectures() {
        return weeklyLectures;
    }

    public void setWeeklyLectures(int weeklyLectures) {
        this.weeklyLectures = weeklyLectures;
    }

    public int getDailyLectures() {
        return dailyLectures;
    }

    public void setDailyLectures(int dailyLectures) {
        this.dailyLectures = dailyLectures;
    }

    public int getTotalLectures() {
        return totalLectures;
    }

    public void setTotalLectures(int totalLectures) {
        this.totalLectures = totalLectures;
    }

    public double getUtilizationPercent() {
        return utilizationPercent;
    }

    public void setUtilizationPercent(double utilizationPercent) {
        this.utilizationPercent = utilizationPercent;
    }
}