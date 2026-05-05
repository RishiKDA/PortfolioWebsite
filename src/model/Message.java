package model;

import java.sql.Timestamp;

public class Message {
    private int id;
    private String senderName;
    private String senderEmail;
    private String subject;
    private String message;
    private Timestamp sentAt;
    private boolean isRead;

    public Message() {}

    public int getId()                    { return id; }
    public void setId(int id)             { this.id = id; }
    public String getSenderName()         { return senderName; }
    public void setSenderName(String s)   { this.senderName = s; }
    public String getSenderEmail()        { return senderEmail; }
    public void setSenderEmail(String s)  { this.senderEmail = s; }
    public String getSubject()            { return subject; }
    public void setSubject(String s)      { this.subject = s; }
    public String getMessage()            { return message; }
    public void setMessage(String m)      { this.message = m; }
    public Timestamp getSentAt()          { return sentAt; }
    public void setSentAt(Timestamp t)    { this.sentAt = t; }
    public boolean isRead()               { return isRead; }
    public void setRead(boolean r)        { this.isRead = r; }
}
