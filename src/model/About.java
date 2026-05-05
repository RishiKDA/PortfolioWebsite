package model;

public class About {
    private int id;
    private String fullName;
    private String phone;
    private String email;
    private String objective;
    private String githubUrl;
    private String linkedinUrl;
    private String languagesSpoken;
    private String softSkills;

    public About() {}

    public int getId()                     { return id; }
    public void setId(int id)              { this.id = id; }
    public String getFullName()            { return fullName; }
    public void setFullName(String f)      { this.fullName = f; }
    public String getPhone()               { return phone; }
    public void setPhone(String p)         { this.phone = p; }
    public String getEmail()               { return email; }
    public void setEmail(String e)         { this.email = e; }
    public String getObjective()           { return objective; }
    public void setObjective(String o)     { this.objective = o; }
    public String getGithubUrl()           { return githubUrl; }
    public void setGithubUrl(String g)     { this.githubUrl = g; }
    public String getLinkedinUrl()         { return linkedinUrl; }
    public void setLinkedinUrl(String l)   { this.linkedinUrl = l; }
    public String getLanguagesSpoken()     { return languagesSpoken; }
    public void setLanguagesSpoken(String l){ this.languagesSpoken = l; }
    public String getSoftSkills()          { return softSkills; }
    public void setSoftSkills(String s)    { this.softSkills = s; }
}
