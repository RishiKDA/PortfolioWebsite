package model;

public class Skill {
    private int id;
    private String skillName;
    private String category;
    private int proficiency;

    public Skill() {}

    public Skill(int id, String skillName, String category, int proficiency) {
        this.id = id; this.skillName = skillName;
        this.category = category; this.proficiency = proficiency;
    }

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }
    public String getSkillName()        { return skillName; }
    public void setSkillName(String s)  { this.skillName = s; }
    public String getCategory()         { return category; }
    public void setCategory(String c)   { this.category = c; }
    public int getProficiency()         { return proficiency; }
    public void setProficiency(int p)   { this.proficiency = p; }
}
