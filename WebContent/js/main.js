/* ============================================================
   main.js — Portfolio JS
   ============================================================ */

// ── Theme Toggle ──────────────────────────────────────────────
const themeToggle = document.getElementById('themeToggle');
const root        = document.documentElement;

function applyTheme(theme) {
    root.setAttribute('data-theme', theme);
    localStorage.setItem('portfolio-theme', theme);
    if (themeToggle) {
        themeToggle.textContent = theme === 'dark' ? '☀️' : '🌙';
    }
}

// Init theme
const savedTheme = localStorage.getItem('portfolio-theme') || 'dark';
applyTheme(savedTheme);

if (themeToggle) {
    themeToggle.addEventListener('click', () => {
        const current = root.getAttribute('data-theme');
        applyTheme(current === 'dark' ? 'light' : 'dark');
    });
}

// ── Hamburger Menu ────────────────────────────────────────────
const hamburger = document.getElementById('hamburger');
const navLinks  = document.getElementById('navLinks');

if (hamburger && navLinks) {
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('open');
    });
    // Close on outside click
    document.addEventListener('click', (e) => {
        if (!hamburger.contains(e.target) && !navLinks.contains(e.target)) {
            navLinks.classList.remove('open');
        }
    });
}

// ── Active Nav Link ───────────────────────────────────────────
const navAnchors = document.querySelectorAll('.nav-links a[href^="#"]');
const sections   = document.querySelectorAll('section[id]');

function updateActiveNav() {
    let current = '';
    sections.forEach(sec => {
        if (window.scrollY >= sec.offsetTop - 120) {
            current = sec.getAttribute('id');
        }
    });
    navAnchors.forEach(a => {
        a.classList.remove('active');
        if (a.getAttribute('href') === '#' + current) a.classList.add('active');
    });
}

window.addEventListener('scroll', updateActiveNav, { passive: true });
updateActiveNav();

// ── Scroll Reveal ─────────────────────────────────────────────
const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
        if (e.isIntersecting) {
            e.target.classList.add('visible');
            observer.unobserve(e.target);
        }
    });
}, { threshold: 0.12 });

document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// ── Skill Bar Animation ───────────────────────────────────────
const skillObserver = new IntersectionObserver((entries) => {
    entries.forEach(e => {
        if (e.isIntersecting) {
            const bar = e.target.querySelector('.skill-bar');
            if (bar) {
                const pct = bar.getAttribute('data-pct');
                setTimeout(() => { bar.style.width = pct + '%'; }, 100);
            }
            skillObserver.unobserve(e.target);
        }
    });
}, { threshold: 0.3 });

document.querySelectorAll('.skill-card').forEach(el => skillObserver.observe(el));

// ── Skills Tab Filter ─────────────────────────────────────────
const tabBtns    = document.querySelectorAll('.tab-btn');
const skillCards = document.querySelectorAll('.skill-card');

tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        tabBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const filter = btn.getAttribute('data-filter');
        skillCards.forEach(card => {
            const show = filter === 'all' || card.getAttribute('data-category') === filter;
            card.style.display = show ? '' : 'none';
        });
    });
});

// ── Contact Form Validation ───────────────────────────────────
const contactForm = document.getElementById('contactForm');

if (contactForm) {
    contactForm.addEventListener('submit', function (e) {
        let valid = true;

        const name    = document.getElementById('name');
        const email   = document.getElementById('email');
        const subject = document.getElementById('subject');
        const message = document.getElementById('message');

        clearErrors();

        // Name
        if (!name || name.value.trim().length < 2) {
            showError('nameError', 'Please enter your full name (min 2 chars).');
            valid = false;
        }

        // Email
        const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!email || !emailRe.test(email.value.trim())) {
            showError('emailError', 'Please enter a valid email address.');
            valid = false;
        }

        // Subject
        if (!subject || subject.value.trim().length < 2) {
            showError('subjectError', 'Please enter a subject.');
            valid = false;
        }

        // Message
        if (!message || message.value.trim().length < 10) {
            showError('messageError', 'Message must be at least 10 characters.');
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
}

function showError(id, msg) {
    const el = document.getElementById(id);
    if (el) { el.textContent = msg; el.classList.add('show'); }
}

function clearErrors() {
    document.querySelectorAll('.form-error').forEach(el => {
        el.textContent = '';
        el.classList.remove('show');
    });
}

// ── Register Form Validation ──────────────────────────────────
const registerForm = document.getElementById('registerForm');

if (registerForm) {
    registerForm.addEventListener('submit', function (e) {
        let valid = true;
        clearErrors();

        const username = document.getElementById('username');
        const email    = document.getElementById('regEmail');
        const password = document.getElementById('password');
        const confirm  = document.getElementById('confirm_password');

        if (!username || username.value.trim().length < 3) {
            showError('usernameError', 'Username must be at least 3 characters.');
            valid = false;
        }
        const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!email || !emailRe.test(email.value.trim())) {
            showError('regEmailError', 'Enter a valid email.');
            valid = false;
        }
        if (!password || password.value.length < 8) {
            showError('passwordError', 'Password must be at least 8 characters.');
            valid = false;
        }
        if (!confirm || password.value !== confirm.value) {
            showError('confirmError', 'Passwords do not match.');
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
}

// ── Smooth scroll for anchor links ───────────────────────────
document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
        const target = document.querySelector(a.getAttribute('href'));
        if (target) {
            e.preventDefault();
            target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            navLinks && navLinks.classList.remove('open');
        }
    });
});

// ── Admin Modal ───────────────────────────────────────────────
function openModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.classList.add('open');
}

function closeModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.classList.remove('open');
}

// Close on overlay click
document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', e => {
        if (e.target === overlay) overlay.classList.remove('open');
    });
});

// Handle edit buttons via data attributes to avoid inline JS parsing issues
document.querySelectorAll('.edit-project-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.getElementById('editProjectId').value      = btn.dataset.id || '';
        document.getElementById('editTitle').value          = btn.dataset.title || '';
        document.getElementById('editDescription').value    = btn.dataset.description || '';
        document.getElementById('editTechStack').value      = btn.dataset.techstack || '';
        document.getElementById('editGithubUrl').value      = btn.dataset.githuburl || '';
        document.getElementById('editLiveUrl').value        = btn.dataset.liveurl || '';
        openModal('editProjectModal');
    });
});

document.querySelectorAll('.edit-skill-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.getElementById('editSkillId').value          = btn.dataset.id || '';
        document.getElementById('editSkillName').value        = btn.dataset.skillname || '';
        document.getElementById('editSkillCategory').value    = btn.dataset.category || '';
        document.getElementById('editSkillProficiency').value = btn.dataset.proficiency || '';
        const display = document.getElementById('editProfDisplay');
        if (display) display.textContent = btn.dataset.proficiency || '0';
        openModal('editSkillModal');
    });
});

// Populate edit modal for projects
function editProject(id, title, description, techStack, githubUrl, liveUrl) {
    document.getElementById('editProjectId').value      = id;
    document.getElementById('editTitle').value          = title;
    document.getElementById('editDescription').value    = description;
    document.getElementById('editTechStack').value      = techStack;
    document.getElementById('editGithubUrl').value      = githubUrl;
    document.getElementById('editLiveUrl').value        = liveUrl;
    openModal('editProjectModal');
}

// Populate edit modal for skills
function editSkill(id, name, category, proficiency) {
    document.getElementById('editSkillId').value          = id;
    document.getElementById('editSkillName').value        = name;
    document.getElementById('editSkillCategory').value    = category;
    document.getElementById('editSkillProficiency').value = proficiency;
    openModal('editSkillModal');
}

// Confirm delete
function confirmDelete(formId) {
    if (confirm('Are you sure you want to delete this? This action cannot be undone.')) {
        document.getElementById(formId).submit();
    }
}
