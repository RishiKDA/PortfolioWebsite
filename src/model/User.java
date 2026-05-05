package model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String username;
    private String email;
    private String passwordHash;
    private Timestamp createdAt;

    public User() {}

    public User(int id, String username, String email, String passwordHash, Timestamp createdAt) {
        this.id = id; this.username = username; this.email = email;
        this.passwordHash = passwordHash; this.createdAt = createdAt;
    }

    public int getId()                { return id; }
    public void setId(int id)         { this.id = id; }
    public String getUsername()       { return username; }
    public void setUsername(String u) { this.username = u; }
    public String getEmail()          { return email; }
    public void setEmail(String e)    { this.email = e; }
    public String getPasswordHash()   { return passwordHash; }
    public void setPasswordHash(String p) { this.passwordHash = p; }
    public Timestamp getCreatedAt()   { return createdAt; }
    public void setCreatedAt(Timestamp t) { this.createdAt = t; }
}
