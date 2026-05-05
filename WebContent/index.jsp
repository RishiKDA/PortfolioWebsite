<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.AboutDAO, dao.SkillDAO, dao.ProjectDAO, dao.EducationDAO, dao.ExperienceDAO, dao.CertificationDAO" %>
<%@ page import="model.About, model.Skill, model.Project, model.Education, model.Experience, model.Certification" %>
<%@ page import="java.util.List" %>
<%
    AboutDAO aboutDAO     = new AboutDAO();
    SkillDAO skillDAO     = new SkillDAO();
    ProjectDAO projectDAO = new ProjectDAO();
    EducationDAO eduDAO   = new EducationDAO();
    ExperienceDAO expDAO  = new ExperienceDAO();
    CertificationDAO certDAO = new CertificationDAO();

    About about           = aboutDAO.getAbout();
    List<Skill> skills    = skillDAO.getAllSkills();
    List<Project> projects = projectDAO.getAllProjects();
    List<Education> edus  = eduDAO.getAllEducation();
    List<Experience> exps = expDAO.getAllExperience();
    List<Certification> certs = certDAO.getAllCertifications();

    List<Skill> languages  = skillDAO.getSkillsByCategory("language");
    List<Skill> libraries  = skillDAO.getSkillsByCategory("library");
    List<Skill> tools      = skillDAO.getSkillsByCategory("tool");

    String name = about != null ? about.getFullName() : "Rishi Kedia";
    String obj  = about != null ? about.getObjective() : "";
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= name %> — Portfolio</title>
    <meta name="description" content="<%= name %> — Aspiring Data Engineer & Developer">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
</head>
<body>

<!-- ── Navigation ─────────────────────────────────────────── -->
<nav class="navbar">
    <a href="#home" class="nav-logo">RK<span>.</span></a>
    <ul class="nav-links" id="navLinks">
        <li><a href="#home">Home</a></li>
        <li><a href="#about">About</a></li>
        <li><a href="#skills">Skills</a></li>
        <li><a href="#projects">Projects</a></li>
        <li><a href="#education">Education</a></li>
        <li><a href="#contact">Contact</a></li>
    </ul>
    <div class="nav-actions">
        <button class="theme-toggle" id="themeToggle" title="Toggle theme">🌙</button>
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-outline btn-sm">Admin</a>
        <button class="hamburger" id="hamburger" aria-label="Menu">
            <span></span><span></span><span></span>
        </button>
    </div>
</nav>

<!-- ── Hero ───────────────────────────────────────────────── -->
<section id="home" class="hero">
    <div class="hero-bg"></div>
    <div class="hero-grid"></div>
    <div class="hero-content">
        <div class="hero-label">Portfolio 2025</div>
        <h1 class="hero-name">
            <%= name.split(" ")[0] %><br>
            <span class="accent"><%= name.contains(" ") ? name.split(" ")[1] : "" %></span>
        </h1>
        <p class="hero-title">Data Engineer &amp; Developer</p>
        <p class="hero-bio"><%= obj %></p>
        <div class="hero-cta">
            <a href="#projects" class="btn btn-primary">View Projects</a>
            <a href="#contact" class="btn btn-outline">Get In Touch</a>
            <% if (about != null && about.getGithubUrl() != null) { %>
            <a href="<%= about.getGithubUrl() %>" target="_blank" class="btn btn-outline">GitHub ↗</a>
            <% } %>
        </div>
    </div>
</section>

<!-- ── About ──────────────────────────────────────────────── -->
<section id="about">
    <div class="section">
        <p class="section-label">01 — About</p>
        <h2 class="section-title">Who I Am</h2>
        <div class="section-divider"></div>

        <div style="display:grid; grid-template-columns: 1fr 1fr; gap: 3rem; align-items:start;">
            <div class="reveal">
                <div class="card">
                    <p style="font-size:1rem; line-height:1.9; color: var(--text-muted); margin-bottom:1.5rem;"><%= obj %></p>

                    <% if (about != null) { %>
                    <div style="display:flex; flex-direction:column; gap:0.75rem; font-family: var(--font-mono); font-size:0.82rem;">
                        <div style="display:flex; gap:1rem;">
                            <span style="color: var(--cyan); min-width:70px;">Phone</span>
                            <span style="color: var(--text-muted);"><%= about.getPhone() %></span>
                        </div>
                        <div style="display:flex; gap:1rem;">
                            <span style="color: var(--cyan); min-width:70px;">Email</span>
                            <span style="color: var(--text-muted);"><%= about.getEmail() %></span>
                        </div>
                        <div style="display:flex; gap:1rem;">
                            <span style="color: var(--cyan); min-width:70px;">Languages</span>
                            <span style="color: var(--text-muted);"><%= about.getLanguagesSpoken() %></span>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

            <div class="reveal" style="transition-delay:0.15s;">
                <!-- Experience -->
                <% if (!exps.isEmpty()) { %>
                <h3 style="font-family: var(--font-display); font-size:1.1rem; font-weight:700; color:var(--text); margin-bottom:1rem;">Experience</h3>
                <% for (Experience ex : exps) { %>
                <div class="card" style="margin-bottom:1rem;">
                    <div style="font-family:var(--font-mono); font-size:0.72rem; color:var(--cyan); margin-bottom:0.4rem;"><%= ex.getDuration() %></div>
                    <div style="font-family:var(--font-display); font-size:1rem; font-weight:700; color:var(--text); margin-bottom:0.25rem;"><%= ex.getRole() %></div>
                    <div style="font-size:0.85rem; color:var(--text-muted); margin-bottom:0.75rem;"><%= ex.getCompany() %></div>
                    <p style="font-size:0.85rem; color:var(--text-muted); line-height:1.7;"><%= ex.getDescription() %></p>
                </div>
                <% } %>
                <% } %>

                <!-- Soft Skills -->
                <% if (about != null && about.getSoftSkills() != null) { %>
                <h3 style="font-family: var(--font-display); font-size:1.1rem; font-weight:700; color:var(--text); margin: 1.5rem 0 1rem;">Soft Skills</h3>
                <div class="soft-grid">
                    <% for (String soft : about.getSoftSkills().split(",")) { %>
                    <span class="soft-chip"><%= soft.trim() %></span>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</section>

<!-- ── Skills ─────────────────────────────────────────────── -->
<section id="skills" style="background: var(--bg-2); border-top:1px solid var(--border); border-bottom:1px solid var(--border);">
    <div class="section">
        <p class="section-label">02 — Skills</p>
        <h2 class="section-title">Technical Skills</h2>
        <div class="section-divider"></div>

        <div class="skills-tabs">
            <button class="tab-btn active" data-filter="all">All</button>
            <button class="tab-btn" data-filter="language">Languages</button>
            <button class="tab-btn" data-filter="library">Libraries</button>
            <button class="tab-btn" data-filter="tool">Tools</button>
        </div>

        <div class="skills-grid">
            <% int skillIdx = 0; for (Skill s : skills) { %>
            <div class="skill-card reveal" data-category="<%= s.getCategory() %>" style="transition-delay: <%= skillIdx * 0.07 %>s;">
                <div class="skill-name"><%= s.getSkillName() %></div>
                <div class="skill-bar-wrap">
                    <div class="skill-bar" data-pct="<%= s.getProficiency() %>"></div>
                </div>
                <div class="skill-pct"><%= s.getProficiency() %>%</div>
            </div>
            <% skillIdx++; } %>
        </div>
    </div>
</section>

<!-- ── Projects ───────────────────────────────────────────── -->
<section id="projects">
    <div class="section">
        <p class="section-label">03 — Projects</p>
        <h2 class="section-title">Featured Work</h2>
        <div class="section-divider"></div>

        <div class="projects-grid">
            <% int pIdx = 1; for (Project p : projects) { %>
            <div class="project-card reveal" style="transition-delay: <%= (pIdx-1) * 0.1 %>s;">
                <div class="project-number">Project #<%= String.format("%02d", pIdx) %></div>
                <div class="project-title"><%= p.getTitle() %></div>
                <p class="project-desc"><%= p.getDescription() %></p>
                <% if (p.getTechStack() != null) { %>
                <div class="project-tags">
                    <% for (String tech : p.getTechStack().split(",")) { %>
                    <span class="tag"><%= tech.trim() %></span>
                    <% } %>
                </div>
                <% } %>
                <div class="project-links">
                    <% if (p.getGithubUrl() != null && !p.getGithubUrl().isEmpty()) { %>
                    <a href="<%= p.getGithubUrl() %>" target="_blank" class="btn btn-outline btn-sm">GitHub ↗</a>
                    <% } %>
                    <% if (p.getLiveUrl() != null && !p.getLiveUrl().isEmpty()) { %>
                    <a href="<%= p.getLiveUrl() %>" target="_blank" class="btn btn-primary btn-sm">Live Demo ↗</a>
                    <% } %>
                </div>
            </div>
            <% pIdx++; } %>
        </div>
    </div>
</section>

<!-- ── Education ──────────────────────────────────────────── -->
<section id="education" style="background: var(--bg-2); border-top:1px solid var(--border); border-bottom:1px solid var(--border);">
    <div class="section">
        <p class="section-label">04 — Education</p>
        <h2 class="section-title">Academic Background</h2>
        <div class="section-divider"></div>

        <div style="display:grid; grid-template-columns:1fr 1fr; gap:3rem;">
            <div>
                <div class="timeline reveal">
                    <% for (Education edu : edus) { %>
                    <div class="timeline-item">
                        <div class="timeline-year"><%= edu.getStartYear() %> — <%= edu.getEndYear() %></div>
                        <div class="timeline-title"><%= edu.getDegree() %></div>
                        <div class="timeline-sub"><%= edu.getInstitution() %></div>
                        <% if (edu.getCgpa() != null) { %>
                        <div style="font-family:var(--font-mono); font-size:0.8rem; color:var(--cyan); margin-bottom:0.5rem;">CGPA: <%= edu.getCgpa() %></div>
                        <% } %>
                        <p class="timeline-body"><%= edu.getDescription() %></p>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Certifications -->
            <div class="reveal" style="transition-delay:0.15s;">
                <h3 style="font-family:var(--font-display); font-size:1.1rem; font-weight:700; color:var(--text); margin-bottom:1.25rem;">Certifications</h3>
                <div class="cert-list">
                    <% for (Certification c : certs) { %>
                    <div class="cert-item">
                        <div class="cert-icon">🏆</div>
                        <div>
                            <div class="cert-title"><%= c.getTitle() %></div>
                            <div class="cert-meta"><%= c.getIssuer() %> · <%= c.getYear() %></div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ── Contact ────────────────────────────────────────────── -->
<section id="contact">
    <div class="section">
        <p class="section-label">05 — Contact</p>
        <h2 class="section-title">Get In Touch</h2>
        <div class="section-divider"></div>

        <%
            String contactSuccess = (String) session.getAttribute("contactSuccess");
            if (contactSuccess != null) {
                session.removeAttribute("contactSuccess");
        %>
        <div class="alert alert-success"><%= contactSuccess %></div>
        <% } %>

        <div class="contact-grid">
            <!-- Contact Info -->
            <div class="contact-info reveal">
                <% if (about != null) { %>
                <div class="contact-info-item">
                    <div class="contact-icon">📱</div>
                    <div>
                        <div class="contact-info-label">Phone</div>
                        <div class="contact-info-val"><%= about.getPhone() %></div>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="contact-icon">✉️</div>
                    <div>
                        <div class="contact-info-label">Email</div>
                        <div class="contact-info-val"><a href="mailto:<%= about.getEmail() %>"><%= about.getEmail() %></a></div>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="contact-icon">🐙</div>
                    <div>
                        <div class="contact-info-label">GitHub</div>
                        <div class="contact-info-val"><a href="<%= about.getGithubUrl() %>" target="_blank">github.com/RishiKDA</a></div>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="contact-icon">💼</div>
                    <div>
                        <div class="contact-info-label">LinkedIn</div>
                        <div class="contact-info-val"><a href="<%= about.getLinkedinUrl() %>" target="_blank">LinkedIn Profile</a></div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Contact Form -->
            <form id="contactForm" action="<%= request.getContextPath() %>/ContactServlet" method="post" class="reveal" style="transition-delay:0.1s;">
                <% String contactError = (String) request.getAttribute("contactError");
                   if (contactError != null) { %>
                <div class="alert alert-danger"><%= contactError %></div>
                <% } %>

                <div class="form-group">
                    <label for="name">Your Name</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Full Name" required>
                    <div class="form-error" id="nameError"></div>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="you@example.com" required>
                    <div class="form-error" id="emailError"></div>
                </div>
                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject" class="form-control" placeholder="What's this about?">
                    <div class="form-error" id="subjectError"></div>
                </div>
                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" class="form-control" placeholder="Your message..."></textarea>
                    <div class="form-error" id="messageError"></div>
                </div>
                <button type="submit" class="btn btn-primary">Send Message →</button>
            </form>
        </div>
    </div>
</section>

<!-- ── Footer ─────────────────────────────────────────────── -->
<footer>
    <p>Designed &amp; Built by <strong><%= name %></strong> · <%= new java.util.Date().getYear() + 1900 %></p>
    <p style="margin-top:0.5rem; font-size:0.7rem; opacity:0.5;">Java · JSP · Servlets · MySQL · Tomcat</p>
</footer>

<script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
