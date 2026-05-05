# Rishi Kedia — Dynamic Portfolio Website

A fully dynamic, database-driven personal portfolio built with
**Java · JSP · Servlets · MySQL · JDBC · Apache Tomcat**

---

## COMPLETE SETUP GUIDE (Beginner Friendly)

---

### STEP 1 — Install Required Software

Install all four tools below before doing anything else.

#### 1A — Install JDK (Java Development Kit)
- Go to: https://www.oracle.com/java/technologies/downloads/
- Download **JDK 17** (LTS version recommended)
- Run the installer
- After install, open Command Prompt and type:
  ```
  java -version
  ```
  You should see something like: `java version "17.0.x"`

#### 1B — Install VS Code
- Go to: https://code.visualstudio.com/
- Download and install for Windows

#### 1C — Install VS Code Extensions
Open VS Code → press `Ctrl + Shift + X` → search and install:
- **Extension Pack for Java** (by Microsoft)
- **Tomcat for Java** (by Wei Shen)
- **Community Server Connectors** (by Red Hat) — optional

#### 1D — Install Apache Tomcat
- Go to: https://tomcat.apache.org/download-10.cgi
- Download **Tomcat 10** → **Core → zip**
- Extract the zip to: `C:\tomcat\`
- You should have: `C:\tomcat\bin\`, `C:\tomcat\webapps\`, etc.

#### 1E — Install MySQL
- Go to: https://dev.mysql.com/downloads/installer/
- Download **MySQL Installer** (community)
- During setup choose: **MySQL Server + MySQL Workbench**
- Set a root password — **remember it!**

---

### STEP 2 — Download Required JAR Files

You need two `.jar` files. Place both inside:
```
PortfolioProject/WebContent/WEB-INF/lib/
```
(Create the `lib` folder inside `WEB-INF` if it doesn't exist)

| JAR File | Download From |
|----------|--------------|
| `mysql-connector-j-8.x.x.jar` | https://dev.mysql.com/downloads/connector/j/ |
| `jbcrypt-0.4.jar` | https://github.com/jeremyh/jBCrypt/releases |

---

### STEP 3 — Setup the Database

1. Open **MySQL Workbench**
2. Connect using your root password
3. Click **File → Open SQL Script**
4. Select: `PortfolioProject/database/portfolio_db.sql`
5. Press the **lightning bolt ⚡ button** to run it
6. You should see `portfolio_db` appear in the left panel

---

### STEP 4 — Update Database Password in Code

Open this file:
```
src/util/DBConnection.java
```

Find this line:
```java
private static final String DB_PASSWORD = "your_mysql_password";
```

Replace `your_mysql_password` with **your actual MySQL root password**.

---

### STEP 5 — Open Project in VS Code

1. Open **VS Code**
2. Click **File → Open Folder**
3. Select your `PortfolioProject` folder
4. Wait for Java extension to load (bottom right shows loading)

---

### STEP 6 — Configure Tomcat in VS Code

1. In VS Code, press `Ctrl + Shift + P`
2. Type: `Tomcat: Add Tomcat Server`
3. Click it → Browse to your Tomcat folder: `C:\tomcat\`
4. Tomcat should appear in the **Tomcat Servers** panel on the left sidebar

---

### STEP 7 — Build and Deploy the Project

#### Option A — Using VS Code Tomcat Extension:
1. In the Explorer panel, right-click on `WebContent`
2. Select **"Run on Tomcat Server"**
3. Select your Tomcat instance
4. Wait for it to deploy

#### Option B — Manual Deploy:
1. Right-click your project → **Export as WAR**
2. Copy the `.war` file to: `C:\tomcat\webapps\`
3. Start Tomcat: open CMD → go to `C:\tomcat\bin\` → run:
   ```
   startup.bat
   ```

---

### STEP 8 — Run and Test

Open your browser and go to:
```
http://localhost:8080/PortfolioProject/
```

**Test checklist:**
- [ ] Homepage loads with Rishi Kedia's data
- [ ] Skills section shows animated progress bars
- [ ] Projects section shows project card with GitHub link
- [ ] Contact form sends a message

**Admin Panel:**
```
http://localhost:8080/PortfolioProject/login.jsp
```
- Username: `rishi`
- Password: `Admin@1234`

---

### FOLDER STRUCTURE (Quick Reference)

```
PortfolioProject/
│
├── database/
│   └── portfolio_db.sql
│
├── src/
│   ├── controller/
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── ProjectServlet.java
│   │   ├── SkillServlet.java
│   │   └── ContactServlet.java
│   ├── dao/
│   │   ├── UserDAO.java
│   │   ├── AboutDAO.java
│   │   ├── SkillDAO.java
│   │   ├── ProjectDAO.java
│   │   ├── EducationDAO.java
│   │   ├── ExperienceDAO.java
│   │   ├── CertificationDAO.java
│   │   └── MessageDAO.java
│   ├── model/
│   │   ├── User.java
│   │   ├── About.java
│   │   ├── Skill.java
│   │   ├── Project.java
│   │   ├── Education.java
│   │   ├── Experience.java
│   │   ├── Certification.java
│   │   └── Message.java
│   └── util/
│       ├── DBConnection.java
│       └── PasswordUtil.java
│
└── WebContent/
    ├── index.jsp
    ├── login.jsp
    ├── register.jsp
    ├── css/
    │   └── style.css
    ├── js/
    │   └── main.js
    ├── images/
    ├── pages/
    │   ├── public/
    │   │   ├── 404.jsp
    │   │   └── 500.jsp
    │   └── admin/
    │       ├── dashboard.jsp
    │       ├── manage_projects.jsp
    │       ├── manage_skills.jsp
    │       └── messages.jsp
    └── WEB-INF/
        ├── web.xml
        └── lib/
            ├── mysql-connector-j-8.x.x.jar
            └── jbcrypt-0.4.jar
```

---

### COMMON ERRORS AND FIXES

#### Error: 404 Page Not Found
**Cause:** Project not deployed or URL is wrong
**Fix:**
- Make sure Tomcat is running
- Check URL: `http://localhost:8080/PortfolioProject/`
- Make sure `index.jsp` is inside `WebContent/`

#### Error: JDBC / Cannot connect to database
**Cause:** Wrong password or MySQL not running
**Fix:**
- Open `DBConnection.java` and check `DB_PASSWORD`
- Open MySQL Workbench and confirm MySQL service is running
- In Windows → search "Services" → find MySQL → Start

#### Error: ClassNotFoundException: com.mysql.cj.jdbc.Driver
**Cause:** MySQL JAR not in `WEB-INF/lib/`
**Fix:**
- Download `mysql-connector-j.jar`
- Place it in `WebContent/WEB-INF/lib/`
- Restart Tomcat

#### Error: ClassNotFoundException: org.mindrot.jbcrypt.BCrypt
**Cause:** jBCrypt JAR missing
**Fix:**
- Download `jbcrypt-0.4.jar`
- Place it in `WebContent/WEB-INF/lib/`
- Restart Tomcat

#### Error: Servlet mapping not found
**Cause:** `web.xml` has wrong class name or URL
**Fix:**
- Open `WEB-INF/web.xml`
- Check `<servlet-class>` matches your package + class name exactly
- Example: `controller.LoginServlet`

#### Error: HTTP 500 on login
**Cause:** Database not imported or table doesn't exist
**Fix:**
- Open MySQL Workbench
- Run `portfolio_db.sql` again
- Check the `users` table has the seed data row

---

### DEFAULT ADMIN CREDENTIALS

| Field | Value |
|-------|-------|
| Username | `rishi` |
| Password | `Admin@1234` |
| Email | `kedia.rishi14@gmail.com` |

> To change the password: register a new admin at `/register.jsp`
> then use those credentials to log in.

---

### TECH STACK

| Layer | Technology |
|-------|-----------|
| Frontend | HTML5, CSS3, JavaScript |
| Templates | JSP (JavaServer Pages) |
| Backend | Java Servlets |
| Database | MySQL 8 |
| DB Connection | JDBC |
| Server | Apache Tomcat 10 |
| Security | BCrypt password hashing |
| IDE | VS Code + Java Extension Pack |

---

Built by **Rishi Kedia** — 2025
