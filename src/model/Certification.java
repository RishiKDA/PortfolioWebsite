package model;

public class Certification {
    private int id;
    private String title;
    private String issuer;
    private String year;

    public Certification() {}

    public int getId()               { return id; }
    public void setId(int id)        { this.id = id; }
    public String getTitle()         { return title; }
    public void setTitle(String t)   { this.title = t; }
    public String getIssuer()        { return issuer; }
    public void setIssuer(String i)  { this.issuer = i; }
    public String getYear()          { return year; }
    public void setYear(String y)    { this.year = y; }
}
