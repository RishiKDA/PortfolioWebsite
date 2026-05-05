package model;

public class Education {
    private int id;
    private String degree;
    private String institution;
    private String startYear;
    private String endYear;
    private String cgpa;
    private String description;

    public Education() {}

    public int getId()                   { return id; }
    public void setId(int id)            { this.id = id; }
    public String getDegree()            { return degree; }
    public void setDegree(String d)      { this.degree = d; }
    public String getInstitution()       { return institution; }
    public void setInstitution(String i) { this.institution = i; }
    public String getStartYear()         { return startYear; }
    public void setStartYear(String s)   { this.startYear = s; }
    public String getEndYear()           { return endYear; }
    public void setEndYear(String e)     { this.endYear = e; }
    public String getCgpa()              { return cgpa; }
    public void setCgpa(String c)        { this.cgpa = c; }
    public String getDescription()       { return description; }
    public void setDescription(String d) { this.description = d; }
}
