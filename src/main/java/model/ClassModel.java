package model;

public class ClassModel {

    private int classId;
    private String className;
    private int semester;
    private String department;

    // GET CLASS ID
    public int getClassId() {
        return classId;
    }

    // SET CLASS ID
    public void setClassId(int classId) {
        this.classId = classId;
    }

    // GET CLASS NAME
    public String getClassName() {
        return className;
    }

    // SET CLASS NAME
    public void setClassName(String className) {
        this.className = className;
    }

    // GET SEMESTER
    public int getSemester() {
        return semester;
    }

    // SET SEMESTER
    public void setSemester(int semester) {
        this.semester = semester;
    }

    // GET DEPARTMENT
    public String getDepartment() {
        return department;
    }

    // SET DEPARTMENT
    public void setDepartment(String department) {
        this.department = department;
    }
}