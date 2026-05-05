package model;

public class Experience {
    private int id;
    private String role;
    private String company;
    private String duration;
    private String description;

    public Experience() {}

    public int getId()                   { return id; }
    public void setId(int id)            { this.id = id; }
    public String getRole()              { return role; }
    public void setRole(String r)        { this.role = r; }
    public String getCompany()           { return company; }
    public void setCompany(String c)     { this.company = c; }
    public String getDuration()          { return duration; }
    public void setDuration(String d)    { this.duration = d; }
    public String getDescription()       { return description; }
    public void setDescription(String d) { this.description = d; }
}
