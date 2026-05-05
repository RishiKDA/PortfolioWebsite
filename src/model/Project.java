package model;

import java.sql.Timestamp;

public class Project {
    private int id;
    private String title;
    private String description;
    private String techStack;
    private String githubUrl;
    private String liveUrl;
    private String imageUrl;
    private Timestamp createdAt;

    public Project() {}

    public int getId()                   { return id; }
    public void setId(int id)            { this.id = id; }
    public String getTitle()             { return title; }
    public void setTitle(String t)       { this.title = t; }
    public String getDescription()       { return description; }
    public void setDescription(String d) { this.description = d; }
    public String getTechStack()         { return techStack; }
    public void setTechStack(String t)   { this.techStack = t; }
    public String getGithubUrl()         { return githubUrl; }
    public void setGithubUrl(String g)   { this.githubUrl = g; }
    public String getLiveUrl()           { return liveUrl; }
    public void setLiveUrl(String l)     { this.liveUrl = l; }
    public String getImageUrl()          { return imageUrl; }
    public void setImageUrl(String i)    { this.imageUrl = i; }
    public Timestamp getCreatedAt()      { return createdAt; }
    public void setCreatedAt(Timestamp t){ this.createdAt = t; }
}
