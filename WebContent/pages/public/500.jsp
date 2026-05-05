<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 — Server Error</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
        }
        .error-code {
            font-family: var(--font-display);
            font-size: clamp(6rem, 20vw, 12rem);
            font-weight: 800;
            color: #ff6b6b;
            line-height: 1;
            opacity: 0.12;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -55%);
            pointer-events: none;
            letter-spacing: -0.05em;
        }
        .error-content { position: relative; z-index: 1; }
        .error-title {
            font-family: var(--font-display);
            font-size: 2rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 1rem;
        }
        .error-msg {
            color: var(--text-muted);
            font-size: 1rem;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="error-code">500</div>
    <div class="error-content">
        <div class="error-title">Internal Server Error</div>
        <p class="error-msg">Something went wrong on our end. Please try again later.</p>
        <a href="<%= request.getContextPath() %>/" class="btn btn-primary">← Go Home</a>
    </div>
    <script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
