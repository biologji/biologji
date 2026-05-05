Ja i gjithë kodi i plotë:

<!DOCTYPE html>
<html lang="sq">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Biologji — Specializimi & Organizimi i Qelizave</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400&family=DM+Sans:wght@300;400;500&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
  :root {
    --bg: #020a14;
    --surface: #041426;
    --card: #071e35;
    --accent1: #00d4ff;
    --accent2: #00ff9d;
    --accent3: #ff6b35;
    --accent4: #c77dff;
    --text: #e8f4f8;
    --muted: #7a9ab0;
    --glow1: rgba(0,212,255,0.15);
    --glow2: rgba(0,255,157,0.12);
  }

  * { margin: 0; padding: 0; box-sizing: border-box; }
  html { scroll-behavior: smooth; }
  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--bg);
    color: var(--text);
    overflow-x: hidden;
    cursor: none;
  }

  .cursor {
    width: 12px; height: 12px;
    background: var(--accent1);
    border-radius: 50%;
    position: fixed; top: 0; left: 0;
    pointer-events: none;
    z-index: 9999;
    transition: transform 0.1s ease;
    mix-blend-mode: screen;
  }
  .cursor-ring {
    width: 40px; height: 40px;
    border: 1px solid rgba(0,212,255,0.5);
    border-radius: 50%;
    position: fixed; top: 0; left: 0;
    pointer-events: none;
    z-index: 9998;
    transition: transform 0.3s ease, width 0.3s, height 0.3s;
  }

  #bg-canvas {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    z-index: 0;
    pointer-events: none;
  }

  nav {
    position: fixed;
    top: 0; left: 0; right: 0;
    z-index: 100;
    padding: 20px 5%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: linear-gradient(to bottom, rgba(2,10,20,0.95), transparent);
    backdrop-filter: blur(10px);
  }
  .nav-logo {
    font-family: 'Space Mono', monospace;
    font-size: 0.75rem;
    color: var(--accent1);
    letter-spacing: 3px;
    text-transform: uppercase;
  }
  .nav-links {
    display: flex;
    gap: 32px;
    list-style: none;
  }
  .nav-links a {
    color: var(--muted);
    text-decoration: none;
    font-size: 0.85rem;
    letter-spacing: 1px;
    transition: color 0.3s;
  }
  .nav-links a:hover { color: var(--accent1); }

  .hero {
    position: relative;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 100px 5% 60px;
    z-index: 1;
    overflow: hidden;
  }

  .hero-tag {
    font-family: 'Space Mono', monospace;
    font-size: 0.7rem;
    color: var(--accent2);
    letter-spacing: 4px;
    text-transform: uppercase;
    margin-bottom: 24px;
    opacity: 0;
    animation: fadeUp 0.8s 0.3s forwards;
  }

  .hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(2.5rem, 7vw, 6rem);
    font-weight: 900;
    line-height: 1.05;
    margin-bottom: 20px;
    opacity: 0;
    animation: fadeUp 0.8s 0.5s forwards;
  }
  .hero h1 .line1 { display: block; }
  .hero h1 .line2 {
    display: block;
    background: linear-gradient(135deg, var(--accent1), var(--accent4));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .hero h1 .line3 {
    display: block;
    font-style: italic;
    font-size: 60%;
    color: var(--accent2);
    -webkit-text-fill-color: var(--accent2);
    background: none;
    -webkit-background-clip: unset;
    background-clip: unset;
  }

  .hero-desc {
    max-width: 600px;
    font-size: 1.05rem;
    line-height: 1.7;
    color: var(--muted);
    margin-bottom: 48px;
    opacity: 0;
    animation: fadeUp 0.8s 0.7s forwards;
  }

  .hero-stats {
    display: flex;
    gap: 48px;
    opacity: 0;
    animation: fadeUp 0.8s 0.9s forwards;
  }
  .stat { text-align: center; }
  .stat-num {
    font-family: 'Space Mono', monospace;
    font-size: 2rem;
    color: var(--accent1);
    display: block;
  }
  .stat-label {
    font-size: 0.75rem;
    color: var(--muted);
    letter-spacing: 2px;
    text-transform: uppercase;
  }

  .floating-cell {
    position: absolute;
    border-radius: 50%;
    animation: floatAround linear infinite;
    pointer-events: none;
    mix-blend-mode: screen;
  }

  section {
    position: relative;
    z-index: 1;
    padding: 100px 5%;
  }

  .section-tag {
    font-family: 'Space Mono', monospace;
    font-size: 0.65rem;
    letter-spacing: 4px;
    text-transform: uppercase;
    margin-bottom: 12px;
  }

  .section-title {
    font-family: 'Playfair Display', serif;
    font-size: clamp(1.8rem, 4vw, 3rem);
    line-height: 1.2;
    margin-bottom: 20px;
  }

  .section-sub {
    font-size: 1rem;
    color: var(--muted);
    max-width: 600px;
    line-height: 1.7;
    margin-bottom: 60px;
  }

  .divider {
    width: 100%;
    height: 1px;
    background: linear-gradient(to right, transparent, var(--accent1), transparent);
    opacity: 0.2;
    margin: 0;
  }

  #structure {
    background: radial-gradient(ellipse at 50% 0%, rgba(0,212,255,0.05) 0%, transparent 70%);
  }

  .cell-3d-container {
    display: flex;
    align-items: center;
    gap: 80px;
    flex-wrap: wrap;
  }

  .cell-3d-wrapper {
    position: relative;
    width: 380px;
    height: 380px;
    flex-shrink: 0;
  }

  .cell-scene {
    width: 100%;
    height: 100%;
    perspective: 800px;
    perspective-origin: 50% 50%;
  }

  .cell-body {
    position: relative;
    width: 100%;
    height: 100%;
    transform-style: preserve-3d;
    animation: rotateSlow 20s linear infinite;
  }

  .cell-membrane {
    position: absolute;
    inset: 0;
    border-radius: 50%;
    border: 2px solid rgba(0,212,255,0.3);
    background: radial-gradient(ellipse at 35% 35%, rgba(0,212,255,0.08), rgba(0,100,180,0.05));
    box-shadow: 0 0 40px rgba(0,212,255,0.1), inset 0 0 60px rgba(0,212,255,0.05);
    animation: pulseMembrane 4s ease-in-out infinite;
  }

  .cell-nucleus {
    position: absolute;
    top: 50%; left: 50%;
    transform: translate(-50%,-50%);
    width: 120px; height: 120px;
    border-radius: 50%;
    background: radial-gradient(ellipse at 35% 35%, rgba(199,125,255,0.6), rgba(100,0,200,0.3));
    border: 1px solid rgba(199,125,255,0.5);
    box-shadow: 0 0 30px rgba(199,125,255,0.4);
    animation: pulseNucleus 3s ease-in-out infinite;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.6rem;
    color: rgba(255,255,255,0.7);
    letter-spacing: 1px;
    font-family: 'Space Mono', monospace;
  }

  .organelle {
    position: absolute;
    border-radius: 50%;
    animation: orbitFloat linear infinite;
  }

  .org-mito {
    width: 50px; height: 25px;
    background: linear-gradient(135deg, rgba(255,107,53,0.7), rgba(200,50,0,0.4));
    border: 1px solid rgba(255,107,53,0.5);
    box-shadow: 0 0 15px rgba(255,107,53,0.3);
    border-radius: 30px;
    top: 22%; left: 65%;
    animation-duration: 8s;
    animation-delay: -2s;
  }
  .org-er {
    width: 60px; height: 15px;
    background: rgba(0,255,157,0.3);
    border: 1px solid rgba(0,255,157,0.4);
    border-radius: 20px;
    top: 65%; left: 20%;
    animation-duration: 10s;
    animation-delay: -5s;
    box-shadow: 0 0 15px rgba(0,255,157,0.2);
  }
  .org-golgi {
    width: 45px; height: 20px;
    background: rgba(255,200,0,0.3);
    border: 1px solid rgba(255,200,0,0.4);
    border-radius: 15px;
    top: 72%; left: 62%;
    animation-duration: 12s;
    animation-delay: -3s;
    box-shadow: 0 0 12px rgba(255,200,0,0.25);
  }
  .org-ribo {
    width: 12px; height: 12px;
    background: rgba(0,212,255,0.5);
    border-radius: 50%;
    top: 35%; left: 25%;
    animation-duration: 6s;
    animation-delay: -1s;
    box-shadow: 0 0 8px rgba(0,212,255,0.4);
  }
  .org-lyso {
    width: 20px; height: 20px;
    background: rgba(255,0,100,0.4);
    border-radius: 50%;
    top: 50%; left: 75%;
    animation-duration: 9s;
    animation-delay: -4s;
    box-shadow: 0 0 12px rgba(255,0,100,0.3);
  }

  .cell-info-panel {
    flex: 1;
    min-width: 280px;
  }

  .org-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    margin-top: 20px;
  }

  .org-card {
    background: var(--card);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 16px;
    padding: 28px;
    position: relative;
    overflow: hidden;
    transition: transform 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
    cursor: default;
  }
  .org-card::before {
    content: '';
    position: absolute;
    top: -50%; left: -50%;
    width: 200%; height: 200%;
    background: radial-gradient(circle at 0% 0%, var(--card-glow, rgba(0,212,255,0.08)), transparent 60%);
    opacity: 0;
    transition: opacity 0.4s;
  }
  .org-card:hover { transform: translateY(-6px); box-shadow: 0 20px 60px rgba(0,0,0,0.4); }
  .org-card:hover::before { opacity: 1; }

  .org-card-icon {
    width: 48px; height: 48px;
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.4rem;
    margin-bottom: 16px;
  }

  .org-card h4 {
    font-family: 'Playfair Display', serif;
    font-size: 1.1rem;
    margin-bottom: 8px;
  }
  .org-card p {
    font-size: 0.875rem;
    color: var(--muted);
    line-height: 1.6;
  }
  .org-card .tag {
    display: inline-block;
    margin-top: 12px;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-family: 'Space Mono', monospace;
    letter-spacing: 1px;
  }

  #specialization {
    background: radial-gradient(ellipse at 80% 50%, rgba(0,255,157,0.04) 0%, transparent 60%);
  }

  .spec-timeline {
    position: relative;
    padding-left: 40px;
  }
  .spec-timeline::before {
    content: '';
    position: absolute;
    left: 0; top: 0; bottom: 0;
    width: 1px;
    background: linear-gradient(to bottom, transparent, var(--accent2), transparent);
    opacity: 0.3;
  }

  .spec-item {
    position: relative;
    padding: 32px 0 32px 48px;
    border-bottom: 1px solid rgba(255,255,255,0.04);
  }
  .spec-item::before {
    content: '';
    position: absolute;
    left: -5px; top: 38px;
    width: 10px; height: 10px;
    border-radius: 50%;
    background: var(--accent2);
    box-shadow: 0 0 15px var(--accent2);
  }

  .spec-num {
    font-family: 'Space Mono', monospace;
    font-size: 0.65rem;
    color: var(--accent2);
    letter-spacing: 3px;
    margin-bottom: 8px;
  }
  .spec-item h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.4rem;
    margin-bottom: 12px;
  }
  .spec-item p {
    color: var(--muted);
    line-height: 1.7;
    font-size: 0.9rem;
    max-width: 700px;
  }

  .cell-types-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
    margin-top: 60px;
  }

  .cell-type-card {
    background: var(--card);
    border: 1px solid rgba(255,255,255,0.05);
    border-radius: 12px;
    padding: 24px 20px;
    text-align: center;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
  }
  .cell-type-card:hover {
    transform: scale(1.03);
    border-color: var(--type-color, var(--accent1));
    box-shadow: 0 0 30px rgba(0,212,255,0.1);
  }
  .cell-type-card .cell-emoji {
    font-size: 2.5rem;
    display: block;
    margin-bottom: 12px;
  }
  .cell-type-card h4 {
    font-size: 0.9rem;
    margin-bottom: 8px;
    font-weight: 500;
  }
  .cell-type-card p {
    font-size: 0.75rem;
    color: var(--muted);
    line-height: 1.5;
  }

  #diseases {
    background: radial-gradient(ellipse at 20% 50%, rgba(255,107,53,0.04) 0%, transparent 60%);
  }

  .disease-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 24px;
  }

  .disease-card {
    background: var(--card);
    border-radius: 20px;
    padding: 32px;
    position: relative;
    overflow: hidden;
    border: 1px solid rgba(255,255,255,0.05);
    transition: all 0.4s ease;
  }
  .disease-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 30px 80px rgba(0,0,0,0.5);
  }
  .disease-card::after {
    content: '';
    position: absolute;
    bottom: 0; left: 0; right: 0;
    height: 3px;
    background: var(--d-color, var(--accent3));
  }

  .disease-severity {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-family: 'Space Mono', monospace;
    letter-spacing: 1px;
    margin-bottom: 20px;
    background: rgba(255,107,53,0.1);
    border: 1px solid rgba(255,107,53,0.2);
    color: var(--accent3);
  }
  .severity-dot {
    width: 6px; height: 6px;
    border-radius: 50%;
    background: var(--accent3);
    animation: pulseDot 1.5s infinite;
  }

  .disease-card h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.4rem;
    margin-bottom: 8px;
  }
  .disease-organ {
    font-family: 'Space Mono', monospace;
    font-size: 0.7rem;
    color: var(--muted);
    letter-spacing: 2px;
    text-transform: uppercase;
    margin-bottom: 16px;
  }
  .disease-card p {
    font-size: 0.875rem;
    color: var(--muted);
    line-height: 1.7;
    margin-bottom: 20px;
  }

  .symptom-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }
  .symptom-tag {
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    color: var(--muted);
  }

  #organs {
    background: radial-gradient(ellipse at 50% 100%, rgba(199,125,255,0.04) 0%, transparent 60%);
  }

  .organs-visual {
    display: flex;
    gap: 60px;
    align-items: flex-start;
    flex-wrap: wrap;
  }

  .body-diagram {
    position: relative;
    width: 260px;
    flex-shrink: 0;
  }

  .organ-item {
    display: flex;
    gap: 20px;
    padding: 20px 0;
    border-bottom: 1px solid rgba(255,255,255,0.04);
    align-items: flex-start;
    transition: all 0.3s;
  }
  .organ-item:hover { padding-left: 10px; }
  .organ-icon {
    width: 44px; height: 44px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.3rem;
    flex-shrink: 0;
  }
  .organ-item h4 {
    font-size: 0.95rem;
    font-weight: 500;
    margin-bottom: 4px;
  }
  .organ-item p {
    font-size: 0.8rem;
    color: var(--muted);
    line-height: 1.5;
  }

  #keypoints {
    background: radial-gradient(ellipse at 50% 50%, rgba(0,212,255,0.03) 0%, transparent 70%);
  }

  .keypoints-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 20px;
  }

  .kp-card {
    background: var(--card);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 16px;
    padding: 28px;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
  }
  .kp-card:hover { transform: translateY(-4px); border-color: rgba(0,212,255,0.3); }
  .kp-number {
    font-family: 'Space Mono', monospace;
    font-size: 3rem;
    color: rgba(255,255,255,0.04);
    position: absolute;
    top: 10px; right: 20px;
    font-weight: 700;
    line-height: 1;
  }
  .kp-card h4 {
    font-family: 'Playfair Display', serif;
    font-size: 1.05rem;
    margin-bottom: 10px;
    position: relative;
  }
  .kp-card p {
    font-size: 0.85rem;
    color: var(--muted);
    line-height: 1.6;
    position: relative;
  }

  footer {
    position: relative;
    z-index: 1;
    padding: 60px 5% 40px;
    border-top: 1px solid rgba(255,255,255,0.06);
    text-align: center;
  }
  footer p { color: var(--muted); font-size: 0.85rem; }
  .footer-logo {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    margin-bottom: 16px;
    background: linear-gradient(135deg, var(--accent1), var(--accent4));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .scroll-hint {
    position: absolute;
    bottom: 40px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    opacity: 0;
    animation: fadeUp 0.8s 1.4s forwards;
  }
  .scroll-hint span {
    font-size: 0.65rem;
    color: var(--muted);
    letter-spacing: 3px;
    text-transform: uppercase;
    font-family: 'Space Mono', monospace;
  }
  .scroll-line {
    width: 1px;
    height: 40px;
    background: linear-gradient(to bottom, var(--accent1), transparent);
    animation: scrollAnim 1.5s ease-in-out infinite;
  }

  .progress-bar {
    position: fixed;
    top: 0; left: 0;
    height: 2px;
    background: linear-gradient(to right, var(--accent2), var(--accent1));
    z-index: 200;
    transition: width 0.1s;
    box-shadow: 0 0 10px var(--accent1);
  }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }
  @keyframes floatAround {
    0% { transform: translateY(0) rotate(0deg); }
    25% { transform: translateY(-20px) rotate(90deg); }
    50% { transform: translateY(-10px) rotate(180deg); }
    75% { transform: translateY(-30px) rotate(270deg); }
    100% { transform: translateY(0) rotate(360deg); }
  }
  @keyframes rotateSlow {
    0% { transform: rotateY(0deg) rotateX(10deg); }
    100% { transform: rotateY(360deg) rotateX(10deg); }
  }
  @keyframes orbitFloat {
    0% { transform: translate(0,0); }
    25% { transform: translate(8px,-8px); }
    50% { transform: translate(0,-15px); }
    75% { transform: translate(-8px,-8px); }
    100% { transform: translate(0,0); }
  }
  @keyframes pulseMembrane {
    0%,100% { box-shadow: 0 0 40px rgba(0,212,255,0.1), inset 0 0 60px rgba(0,212,255,0.05); }
    50% { box-shadow: 0 0 80px rgba(0,212,255,0.25), inset 0 0 80px rgba(0,212,255,0.1); }
  }
  @keyframes pulseNucleus {
    0%,100% { box-shadow: 0 0 30px rgba(199,125,255,0.4); }
    50% { box-shadow: 0 0 60px rgba(199,125,255,0.7); }
  }
  @keyframes pulseDot {
    0%,100% { opacity: 1; }
    50% { opacity: 0.3; }
  }
  @keyframes scrollAnim {
    0% { transform: scaleY(0); transform-origin: top; }
    50% { transform: scaleY(1); transform-origin: top; }
    51% { transform: scaleY(1); transform-origin: bottom; }
    100% { transform: scaleY(0); transform-origin: bottom; }
  }

  .reveal { opacity: 0; transform: translateY(40px); transition: all 0.8s ease; }
  .revealed { opacity: 1; transform: translateY(0); }

  @media (max-width: 768px) {
    .nav-links { display: none; }
    .hero-stats { gap: 24px; }
    .cell-3d-container { flex-direction: column; align-items: center; }
    .cell-3d-wrapper { width: 280px; height: 280px; }
    .organs-visual { flex-direction: column; }
    body { cursor: auto; }
    .cursor, .cursor-ring { display: none; }
  }
</style>
</head>
<body>

<div class="cursor" id="cursor"></div>
<div class="cursor-ring" id="cursorRing"></div>
<div class="progress-bar" id="progressBar"></div>
<canvas id="bg-canvas"></canvas>

<nav>
  <div class="nav-logo">BIO — 2024</div>
  <ul class="nav-links">
    <li><a href="#structure">Qeliza</a></li>
    <li><a href="#specialization">Specializimi</a></li>
    <li><a href="#organs">Organet</a></li>
    <li><a href="#diseases">Sëmundjet</a></li>
    <li><a href="#keypoints">Pikat Kyçe</a></li>
  </ul>
</nav>

<!-- HERO -->
<section class="hero" id="home">
  <div class="floating-cell" style="width:80px;height:80px;top:15%;left:8%;background:radial-gradient(circle, rgba(0,212,255,0.15), transparent);border:1px solid rgba(0,212,255,0.2);animation-duration:15s;animation-delay:-3s;"></div>
  <div class="floating-cell" style="width:50px;height:50px;top:70%;left:5%;background:radial-gradient(circle, rgba(0,255,157,0.12), transparent);border:1px solid rgba(0,255,157,0.2);animation-duration:18s;animation-delay:-7s;"></div>
  <div class="floating-cell" style="width:100px;height:100px;top:20%;right:10%;background:radial-gradient(circle, rgba(199,125,255,0.1), transparent);border:1px solid rgba(199,125,255,0.15);animation-duration:22s;animation-delay:-2s;"></div>
  <div class="floating-cell" style="width:40px;height:40px;top:55%;right:8%;background:radial-gradient(circle, rgba(255,107,53,0.12), transparent);border:1px solid rgba(255,107,53,0.2);animation-duration:12s;animation-delay:-9s;"></div>
  <div class="floating-cell" style="width:60px;height:60px;top:80%;right:20%;background:radial-gradient(circle, rgba(0,212,255,0.1), transparent);border:1px solid rgba(0,212,255,0.15);animation-duration:20s;animation-delay:-5s;"></div>

  <div class="hero-tag">Projekt Biologjie · Klasa 10</div>
  <h1>
    <span class="line1">Specializimi &amp;</span>
    <span class="line2">Organizimi i Qelizave</span>
    <span class="line3">— Sëmundjet e Organeve —</span>
  </h1>
  <p class="hero-desc">
    Eksploroni universin e fshehur brenda trupit njerëzor — nga organizimi i qelizave
    bazë deri te sistemet komplekse organike dhe patologjitë që i prekin ato.
  </p>
  <div class="hero-stats">
    <div class="stat">
      <span class="stat-num">37T</span>
      <span class="stat-label">Qeliza në trup</span>
    </div>
    <div class="stat">
      <span class="stat-num">200+</span>
      <span class="stat-label">Lloje qelizash</span>
    </div>
    <div class="stat">
      <span class="stat-num">78</span>
      <span class="stat-label">Organe kryesore</span>
    </div>
  </div>
  <div class="scroll-hint">
    <div class="scroll-line"></div>
    <span>Scroll</span>
  </div>
</section>

<div class="divider"></div>

<!-- CELL STRUCTURE -->
<section id="structure">
  <div class="section-tag" style="color:var(--accent1)">01 — Struktura</div>
  <h2 class="section-title">Anatomia e Qelizës</h2>
  <p class="section-sub">Qeliza është njësia bazë e jetës. Çdo qelizë njerëzore ka një strukturë komplekse me organele të specializuara.</p>

  <div class="cell-3d-container">
    <div class="cell-3d-wrapper reveal">
      <div class="cell-scene">
        <div class="cell-body">
          <div class="cell-membrane"></div>
          <div class="cell-nucleus">BËRTHAMA</div>
          <div class="organelle org-mito"></div>
          <div class="organelle org-er"></div>
          <div class="organelle org-golgi"></div>
          <div class="organelle org-ribo"></div>
          <div class="organelle org-lyso"></div>
        </div>
      </div>
    </div>
    <div class="cell-info-panel reveal" style="transition-delay:0.2s">
      <div class="section-tag" style="color:var(--accent4)">Organelet kryesore</div>
      <h3 style="font-family:'Playfair Display',serif;font-size:1.5rem;margin-bottom:12px">Çdo pjesë ka një funksion</h3>
      <p style="color:var(--muted);line-height:1.7;font-size:0.9rem;margin-bottom:24px">
        Qeliza eukariotike — lloji i qelizave njerëzore — ka disa organele të mbyllura
        nga membrana, secila me rol specifik në jetëgjatësinë dhe funksionimin e organizmit.
      </p>
      <div style="display:flex;flex-direction:column;gap:12px">
        <div style="display:flex;align-items:center;gap:16px;padding:12px;background:var(--card);border-radius:10px;border-left:3px solid var(--accent4)">
          <div style="width:12px;height:12px;border-radius:50%;background:var(--accent4);flex-shrink:0"></div>
          <div><b style="font-size:0.85rem">Bërthama</b> — Kontrollon aktivitetin qelizor, ruan ADN-në</div>
        </div>
        <div style="display:flex;align-items:center;gap:16px;padding:12px;background:var(--card);border-radius:10px;border-left:3px solid var(--accent3)">
          <div style="width:12px;height:12px;border-radius:4px;background:var(--accent3);flex-shrink:0"></div>
          <div><b style="font-size:0.85rem">Mitokondria</b> — "Termocentralja" — prodhon ATP</div>
        </div>
        <div style="display:flex;align-items:center;gap:16px;padding:12px;background:var(--card);border-radius:10px;border-left:3px solid var(--accent2)">
          <div style="width:16px;height:8px;border-radius:4px;background:var(--accent2);flex-shrink:0"></div>
          <div><b style="font-size:0.85rem">Retikulum Endoplazmatik</b> — Sinteza dhe transporti</div>
        </div>
        <div style="display:flex;align-items:center;gap:16px;padding:12px;background:var(--card);border-radius:10px;border-left:3px solid rgba(255,200,0,0.7)">
          <div style="width:14px;height:10px;border-radius:4px;background:rgba(255,200,0,0.7);flex-shrink:0"></div>
          <div><b style="font-size:0.85rem">Aparati i Golxhit</b> — Paketimi dhe sekretimi</div>
        </div>
      </div>
    </div>
  </div>

  <div class="org-cards" style="margin-top:60px">
    <div class="org-card reveal" style="--card-glow:rgba(199,125,255,0.1)">
      <div class="org-card-icon" style="background:rgba(199,125,255,0.1)">🧬</div>
      <h4>Bërthama (Nucleus)</h4>
      <p>Qendra e komandës. Ruan materialin gjenetik (ADN) dhe drejton sintezën e proteinave. Mbërthet nga membrana bërthamore me por të shumtë.</p>
      <span class="tag" style="background:rgba(199,125,255,0.1);color:var(--accent4)">Kontroll gjenetik</span>
    </div>
    <div class="org-card reveal" style="--card-glow:rgba(255,107,53,0.1);transition-delay:0.1s">
      <div class="org-card-icon" style="background:rgba(255,107,53,0.1)">⚡</div>
      <h4>Mitokondria</h4>
      <p>Prodhon adenozin trifosfat (ATP) nëpërmjet procesit të frymëmarrjes qelizore. Posedon ADN-në e vet — trashëgimi matrilineare.</p>
      <span class="tag" style="background:rgba(255,107,53,0.1);color:var(--accent3)">Prodhim energjie</span>
    </div>
    <div class="org-card reveal" style="--card-glow:rgba(0,255,157,0.1);transition-delay:0.2s">
      <div class="org-card-icon" style="background:rgba(0,255,157,0.1)">🔬</div>
      <h4>Ribozomet</h4>
      <p>Makineritë e sintezës së proteinave. Gjenden në RE të ashpër ose lirshëm në citoplazëm. Lexojnë ARN-në mesazhere.</p>
      <span class="tag" style="background:rgba(0,255,157,0.1);color:var(--accent2)">Sinteza proteinave</span>
    </div>
    <div class="org-card reveal" style="--card-glow:rgba(0,212,255,0.1);transition-delay:0.3s">
      <div class="org-card-icon" style="background:rgba(0,212,255,0.1)">💧</div>
      <h4>Lizozomet</h4>
      <p>Sistemet e tretjes qelizore. Përmbajnë enzima hidrolitike që shpërbëjnë materiale të dëmtuara, baktere dhe organele të plakura.</p>
      <span class="tag" style="background:rgba(0,212,255,0.1);color:var(--accent1)">Tretja qelizore</span>
    </div>
    <div class="org-card reveal" style="--card-glow:rgba(255,200,0,0.1);transition-delay:0.4s">
      <div class="org-card-icon" style="background:rgba(255,200,0,0.1)">📦</div>
      <h4>Aparati i Golxhit</h4>
      <p>Paketohet dhe modifikon proteina nga RE. Merr materiale, i "etiketohet" dhe i dërgon ku duhen — brenda ose jashtë qelizës.</p>
      <span class="tag" style="background:rgba(255,200,0,0.1);color:rgba(255,200,0,0.9)">Sekretim</span>
    </div>
    <div class="org-card reveal" style="--card-glow:rgba(100,200,255,0.1);transition-delay:0.5s">
      <div class="org-card-icon" style="background:rgba(100,200,255,0.1)">🌐</div>
      <h4>Retikulum Endoplazmatik</h4>
      <p>Rrjeti i membranave brenda qelizës. RE i ashpër (me ribozome) sintetizon proteina; RE i lëmuar — lipide dhe detoksifikim.</p>
      <span class="tag" style="background:rgba(100,200,255,0.1);color:rgba(100,200,255,0.9)">Transport brendaqelizor</span>
    </div>
  </div>
</section>

<div class="divider"></div>

<!-- SPECIALIZATION -->
<section id="specialization">
  <div class="section-tag" style="color:var(--accent2)">02 — Specializimi</div>
  <h2 class="section-title">Si Specializohen Qelizat?</h2>
  <p class="section-sub">Nga një vezë e fertilizuar krijohen mbi 200 lloje qelizash — procesi quhet diferencim qelizor.</p>

  <div class="spec-timeline reveal">
    <div class="spec-item">
      <div class="spec-num">FAZA 01</div>
      <h3>Fertilizimi & Zigota</h3>
      <p>Gjithçka fillon nga bashkimi i spermatozoidit dhe vezës. Zigota — qeliza e parë me të gjithë ADN-në njerëzore — ka potencial total për t'u shndërruar në çdo lloj qelize. Kjo quhet <strong>totipotencë</strong>.</p>
    </div>
    <div class="spec-item">
      <div class="spec-num">FAZA 02</div>
      <h3>Ndarja dhe Blastocisti</h3>
      <p>Pas ndarjeve të shumta, formohet blastocisti me rreth 200 qeliza. Qelizat e brendshme janë <strong>pluripotente</strong> — mund të bëhen pothuajse çdo lloj qelize organi, por jo placenta apo membranat embrionale.</p>
    </div>
    <div class="spec-item">
      <div class="spec-num">FAZA 03</div>
      <h3>Gastrulacioni — 3 Shtresat</h3>
      <p>Embrioni formon tre shtresa germinale: <strong>Ektodermën</strong> (lëkura, sistemi nervor), <strong>Mezodermën</strong> (muskujt, kockat, zemra), dhe <strong>Endodermën</strong> (zorrët, mëlçia, mushkëritë). Kjo është baza e organizimit organik.</p>
    </div>
    <div class="spec-item">
      <div class="spec-num">FAZA 04</div>
      <h3>Diferencimi i Qelizave Stem</h3>
      <p>Faktorët e transkriptimit aktivizojnë genet specifike duke "fikur" të tjerët. Qeliza stem hematopoetike prodhon të gjitha qelizat e gjakut; qelizat stem neurale bëhen neurona ose astrocite. Ky proces është <strong>i pakthyeshëm</strong> në qelizat normale.</p>
    </div>
    <div class="spec-item">
      <div class="spec-num">FAZA 05</div>
      <h3>Qelizat e Specializuara — Forma = Funksion</h3>
      <p>Neuroni shtrihet metër të tëra për transmetim sinjali. Qeliza e kuqe e gjakut heq bërthamën për të mbajtur më shumë hemoglobinë. Celula e muskulit ka shumë mitokondri. Çdo formë është zgjidhje evolucionare e detyrimeve funksionale.</p>
    </div>
  </div>

  <div class="cell-types-grid" style="margin-top:60px">
    <div class="cell-type-card reveal" style="--type-color:rgba(0,212,255,0.5)">
      <span class="cell-emoji">🔴</span>
      <h4>Eritrociti</h4>
      <p>Pa bërthamë, me hemoglobinë. Jeton ~120 ditë.</p>
    </div>
    <div class="cell-type-card reveal" style="--type-color:rgba(199,125,255,0.5);transition-delay:0.05s">
      <span class="cell-emoji">⚡</span>
      <h4>Neuroni</h4>
      <p>Degëza deri 1m. Transmetim sinjali me 120 m/s.</p>
    </div>
    <div class="cell-type-card reveal" style="--type-color:rgba(255,107,53,0.5);transition-delay:0.1s">
      <span class="cell-emoji">💪</span>
      <h4>Miositi</h4>
      <p>Qeliza e muskulit. Kontraktohet duke shfrytëzuar ATP.</p>
    </div>
    <div class="cell-type-card reveal" style="--type-color:rgba(0,255,157,0.5);transition-delay:0.15s">
      <span class="cell-emoji">🛡️</span>
      <h4>Leukociti</h4>
      <p>Qeliza e bardhë imune. Gëlltit patogjenë.</p>
    </div>
    <div class="cell-type-card reveal" style="--type-color:rgba(255,200,0,0.5);transition-delay:0.2s">
      <span class="cell-emoji">🦴</span>
      <h4>Osteociti</h4>
      <p>Qeliza kockore. Ruajtja dhe rimodelimet e kockave.</p>
    </div>
    <div class="cell-type-card reveal" style="--type-color:rgba(255,100,200,0.5);transition-delay:0.25s">
      <span class="cell-emoji">🥚</span>
      <h4>Hepatociti</h4>
      <p>Qeliza e mëlçisë. 500+ funksione metabolike.</p>
    </div>
  </div>
</section>

<div class="divider"></div>

<!-- ORGAN SYSTEMS -->
<section id="organs">
  <div class="section-tag" style="color:var(--accent4)">03 — Organizimi</div>
  <h2 class="section-title">Sistemet e Organeve</h2>
  <p class="section-sub">Qelizat bashkohen në inde, indet në organe, organet në sisteme. Kjo hierarki ndërtimore i mundëson trupit kompleksitetin e jetës.</p>

  <div class="organs-visual">
    <div class="body-diagram reveal">
      <div style="background:var(--card);border-radius:20px;padding:30px;border:1px solid rgba(255,255,255,0.06);position:relative;min-height:420px">
        <div style="font-family:'Space Mono',monospace;font-size:0.65rem;color:var(--muted);letter-spacing:2px;margin-bottom:20px;text-align:center">TRUPI NJERËZOR</div>
        <svg viewBox="0 0 200 400" style="width:100%;max-height:350px">
          <ellipse cx="100" cy="40" rx="30" ry="35" fill="none" stroke="rgba(0,212,255,0.2)" stroke-width="1.5"/>
          <rect x="70" y="75" width="60" height="90" rx="10" fill="none" stroke="rgba(0,212,255,0.15)" stroke-width="1.5"/>
          <rect x="68" y="165" width="64" height="80" rx="8" fill="none" stroke="rgba(0,212,255,0.1)" stroke-width="1.5"/>
          <path d="M70,80 Q50,120 45,165" fill="none" stroke="rgba(0,212,255,0.12)" stroke-width="10" stroke-linecap="round"/>
          <path d="M130,80 Q150,120 155,165" fill="none" stroke="rgba(0,212,255,0.12)" stroke-width="10" stroke-linecap="round"/>
          <path d="M85,245 Q80,300 78,360" fill="none" stroke="rgba(0,212,255,0.12)" stroke-width="12" stroke-linecap="round"/>
          <path d="M115,245 Q120,300 122,360" fill="none" stroke="rgba(0,212,255,0.12)" stroke-width="12" stroke-linecap="round"/>
          <ellipse cx="93" cy="110" rx="12" ry="14" fill="rgba(255,60,80,0.3)" stroke="rgba(255,60,80,0.6)" stroke-width="1"/>
          <ellipse cx="76" cy="115" rx="8" ry="16" fill="rgba(0,212,255,0.12)" stroke="rgba(0,212,255,0.3)" stroke-width="1"/>
          <ellipse cx="116" cy="115" rx="8" ry="16" fill="rgba(0,212,255,0.12)" stroke="rgba(0,212,255,0.3)" stroke-width="1"/>
          <ellipse cx="100" cy="160" rx="15" ry="12" fill="rgba(255,150,0,0.15)" stroke="rgba(255,150,0,0.3)" stroke-width="1"/>
          <ellipse cx="100" cy="38" rx="22" ry="25" fill="rgba(199,125,255,0.1)" stroke="rgba(199,125,255,0.3)" stroke-width="1"/>
          <text x="100" y="36" text-anchor="middle" fill="rgba(199,125,255,0.8)" font-size="5" font-family="monospace">TRU</text>
          <text x="93" y="112" text-anchor="middle" fill="rgba(255,60,80,0.9)" font-size="4.5" font-family="monospace">ZEM</text>
          <text x="76" y="116" text-anchor="middle" fill="rgba(0,212,255,0.7)" font-size="4" font-family="monospace">MU</text>
          <text x="116" y="116" text-anchor="middle" fill="rgba(0,212,255,0.7)" font-size="4" font-family="monospace">MU</text>
          <text x="100" y="162" text-anchor="middle" fill="rgba(255,150,0,0.8)" font-size="4.5" font-family="monospace">STO</text>
        </svg>
      </div>
    </div>

    <div class="organs-list reveal" style="transition-delay:0.2s;flex:1;min-width:280px">
      <div class="organ-item">
        <div class="organ-icon" style="background:rgba(255,60,80,0.1)">❤️</div>
        <div>
          <h4>Zemra</h4>
          <p>Pomp muskulore e madhe 300g. Rreh ~100,000 herë/ditë. Qarkullon 7,500L gjak/ditë. Ndahet në 4 dhoma.</p>
        </div>
      </div>
      <div class="organ-item">
        <div class="organ-icon" style="background:rgba(0,212,255,0.1)">🫁</div>
        <div>
          <h4>Mushkëritë</h4>
          <p>500 milionë alveolet — sipërfaqe 70m². Shkëmbim O₂/CO₂. 15 frymëmarrje/min në pushim.</p>
        </div>
      </div>
      <div class="organ-item">
        <div class="organ-icon" style="background:rgba(255,200,0,0.1)">🟡</div>
        <div>
          <h4>Mëlçia</h4>
          <p>~1.5kg. 500 funksione: detoksifikim, sintetizim bile, ruajtje glukozeni, prodhim proteinash plazmatike.</p>
        </div>
      </div>
      <div class="organ-item">
        <div class="organ-icon" style="background:rgba(199,125,255,0.1)">🧠</div>
        <div>
          <h4>Truri</h4>
          <p>~86 miliardë neuronë. Konsumon 20% energjisë totale. 100 trilionë sinapse. Plasticiteti neural.</p>
        </div>
      </div>
      <div class="organ-item">
        <div class="organ-icon" style="background:rgba(0,255,157,0.1)">🫘</div>
        <div>
          <h4>Veshkat</h4>
          <p>Filtrimin 180L gjak/ditë. 1 milion nefronë secila. Rregullojnë presionin, ekuilibrin acid-bazë.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<div class="divider"></div>

<!-- DISEASES -->
<section id="diseases">
  <div class="section-tag" style="color:var(--accent3)">04 — Patologjia</div>
  <h2 class="section-title">Sëmundjet e Organeve</h2>
  <p class="section-sub">Kur qelizat specializuara dështojnë apo sëmuren, pasojat janë sëmundjet e organeve — shpesh me impakt sistemik.</p>

  <div class="disease-grid">
    <div class="disease-card reveal" style="--d-color:rgba(255,60,80,0.8)">
      <div class="disease-severity">
        <div class="severity-dot" style="background:rgba(255,60,80,0.8)"></div>
        Shkak: Mutacion gjenetik / Faktor ambiental
      </div>
      <h3>Kanceri</h3>
      <div class="disease-organ">🧬 Të gjitha indet</div>
      <p>Ndodh kur qelizat fitojnë mutacione në genet kontrolluese (onkogjenë, gjene supresore tumore si TP53). Qelizat ndahen pa kontroll, ikin apoptozës dhe invadojnë inde fqinje. Metastaza = shpërndarje nëpër gjak/limfë.</p>
      <div class="symptom-tags">
        <span class="symptom-tag">Ndarja e pakontrolluar</span>
        <span class="symptom-tag">Angiogjeneza</span>
        <span class="symptom-tag">Metastaza</span>
        <span class="symptom-tag">Imunoevasioni</span>
      </div>
    </div>

    <div class="disease-card reveal" style="--d-color:rgba(255,150,0,0.8);transition-delay:0.1s">
      <div class="disease-severity" style="background:rgba(255,150,0,0.1);border-color:rgba(255,150,0,0.3);color:rgba(255,150,0,0.9)">
        <div class="severity-dot" style="background:rgba(255,150,0,0.9)"></div>
        Shkak: Autoimmun / Çrregullim metabolik
      </div>
      <h3>Diabeti Mellitus</h3>
      <div class="disease-organ">🫀 Pankreasi → Sistemi i tërë</div>
      <p>Tipi 1: Sistemi imun shkatërron qelizat beta pankreatike (prodhon insulinë). Tipi 2: Rezistencë ndaj insulinës. Pa insulinë, glukoza nuk hyn në qeliza → hiperglicemia dëmton enë gjaku, nervat, veshkat, sytë.</p>
      <div class="symptom-tags">
        <span class="symptom-tag">Poliuria</span>
        <span class="symptom-tag">Hiperglicemia</span>
        <span class="symptom-tag">Neuropatia</span>
        <span class="symptom-tag">Nefropatia</span>
      </div>
    </div>

    <div class="disease-card reveal" style="--d-color:rgba(255,60,100,0.8);transition-delay:0.2s">
      <div class="disease-severity" style="background:rgba(255,60,100,0.1);border-color:rgba(255,60,100,0.3);color:rgba(255,60,100,0.9)">
        <div class="severity-dot" style="background:rgba(255,60,100,0.9)"></div>
        Shkak: Ateroskleroza / Hipertensioni
      </div>
      <h3>Infarkti Miokardial</h3>
      <div class="disease-organ">❤️ Zemra — Muskuli kardiak</div>
      <p>Bllokimi i arteries koronare → zona e muskulit kardiak nuk merr O₂ → nekroza e qelizave kardiake (miociteve). Pas 6h pa gjak, dëmi bëhet i pakthyeshëm. Qelizat e vdekura zëvendësohen me ind fijor jo-kontraktil.</p>
      <div class="symptom-tags">
        <span class="symptom-tag">Dolor precordial</span>
        <span class="symptom-tag">Nekroza miocitare</span>
        <span class="symptom-tag">Troponina ↑</span>
        <span class="symptom-tag">Aritmia</span>
      </div>
    </div>

    <div class="disease-card reveal" style="--d-color:rgba(199,125,255,0.8);transition-delay:0.3s">
      <div class="disease-severity" style="background:rgba(199,125,255,0.1);border-color:rgba(199,125,255,0.3);color:var(--accent4)">
        <div class="severity-dot" style="background:var(--accent4)"></div>
        Shkak: Degenerativ / Faktor gjenetik + ambiental
      </div>
      <h3>Alzheimer</h3>
      <div class="disease-organ">🧠 Truri — Korteksi cerebral</div>
      <p>Akumulimi i plakave amiloide (β-amiloid) dhe çiqave neurofibrile (tau) shkatërron sinapset. Fillimisht dëmton hipokampusin (kujtesa e re), pastaj korteksin parietal, frontal. Humbja e 30-40% neuroneve para diagnostikimit.</p>
      <div class="symptom-tags">
        <span class="symptom-tag">Amnezi progresive</span>
        <span class="symptom-tag">Plakat β-amiloid</span>
        <span class="symptom-tag">Atrofia kortekale</span>
        <span class="symptom-tag">Agnozia</span>
      </div>
    </div>

    <div class="disease-card reveal" style="--d-color:rgba(0,212,255,0.6);transition-delay:0.4s">
      <div class="disease-severity" style="background:rgba(0,212,255,0.08);border-color:rgba(0,212,255,0.25);color:var(--accent1)">
        <div class="severity-dot" style="background:var(--accent1)"></div>
        Shkak: Autoimmun — qeliza T kundër mielinës
      </div>
      <h3>Sëmundja e Crohn</h3>
      <div class="disease-organ">🫀 Trakti gastrointestinal</div>
      <p>Inflamacion kronik transmurar i zorrëve. Sistemi imun sulmon mukozën intestinale → ulçera, fistula, striktura. Përfshin të gjithë trentin nga goja deri te anusi me zonat "stone pathway" karakteristike.</p>
      <div class="symptom-tags">
        <span class="symptom-tag">Dhimbje abdominale</span>
        <span class="symptom-tag">Inflamacion kronik</span>
        <span class="symptom-tag">Malabsorbimi</span>
        <span class="symptom-tag">Fistula</span>
      </div>
    </div>

    <div class="disease-card reveal" style="--d-color:rgba(0,255,157,0.6);transition-delay:0.5s">
      <div class="disease-severity" style="background:rgba(0,255,157,0.08);border-color:rgba(0,255,157,0.25);color:var(--accent2)">
        <div class="severity-dot" style="background:var(--accent2)"></div>
        Shkak: Inflamacion kronik / Toksina / Alkool
      </div>
      <h3>Ciroza e Mëlçisë</h3>
      <div class="disease-organ">🟡 Mëlçia — Hepatocitet</div>
      <p>Dëmtimi kronik shkatërron hepatocite → aktivizon qelizat stelate → fibrozë progresive. Indi fijor zëvendëson hepatocitet funksionalë → dështim i funksioneve metabolike, akumulim toksinash, hipertension portal.</p>
      <div class="symptom-tags">
        <span class="symptom-tag">Fibrozë hepatike</span>
        <span class="symptom-tag">Ikteri</span>
        <span class="symptom-tag">Ascita</span>
        <span class="symptom-tag">Encefalopatia</span>
      </div>
    </div>
  </div>
</section>

<div class="divider"></div>

<!-- KEY POINTS -->
<section id="keypoints">
  <div class="section-tag" style="color:var(--accent1)">05 — Sinteza</div>
  <h2 class="section-title">Pikat Kyçe të Temës</h2>
  <p class="section-sub">Konceptet themelore që duhet të dimë për specializimin, organizimin qelizor dhe patologjitë e lidhura.</p>

  <div class="keypoints-grid">
    <div class="kp-card reveal">
      <div class="kp-number">01</div>
      <h4>Uniteti i Jetës</h4>
      <p>Të gjitha organizmat e gjallë janë të ndërtuar nga qeliza. Qeliza është njësia strukturale dhe funksionale bazë e jetës.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.05s">
      <div class="kp-number">02</div>
      <h4>Forma = Funksion</h4>
      <p>Forma e qelizës pasqyron drejtpërdrejt funksionin e saj. Neuroni i gjatë → transmetim; disku i eritrocitit → sipërfaqe diffuzioni.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.1s">
      <div class="kp-number">03</div>
      <h4>Diferencimi Qelizor</h4>
      <p>Nga një zigotë totipotente burojnë të gjitha qelizat e specializuara nëpërmjet aktivizimit selektiv të gjeneve.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.15s">
      <div class="kp-number">04</div>
      <h4>Hierarkia Organizative</h4>
      <p>Qelizë → Ind → Organ → Sistem → Organizëm. Çdo nivel ka vetë emergente që nuk gjenden në nivelin poshtë.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.2s">
      <div class="kp-number">05</div>
      <h4>Homeostaza</h4>
      <p>Sisteme organike bashkëpunojnë për të ruajtur parametra konstante: pH 7.4, temperatura 37°C, glukoza 90mg/dL.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.25s">
      <div class="kp-number">06</div>
      <h4>Sëmundja = Disfunksion Qelizor</h4>
      <p>Çdo sëmundje organike rrënjosen në disfunksionin e qelizave të specializuara — gjenetik, imun, metabolik, apo toksik.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.3s">
      <div class="kp-number">07</div>
      <h4>Plasticiteti Neural</h4>
      <p>Truri rimodelohet vazhdimisht — sinapset forcohen apo dobësohen. Baza biologjike e të mësuarit dhe memorjes.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.35s">
      <div class="kp-number">08</div>
      <h4>Apoptoza — Vdekja e Programuar</h4>
      <p>Mekanizëm kontrolli vital. Qelizat e dëmtuara vetë-shkatërrohen. Kanceri = dështim i apoptozës dhe rregullimit.</p>
    </div>
    <div class="kp-card reveal" style="transition-delay:0.4s">
      <div class="kp-number">09</div>
      <h4>Komunikimi Qelizor</h4>
      <p>Qelizat komunikojnë me hormonë, neurotransmetitorë dhe liganë ndërqelizorë. Prishja e komunikimit → sëmundje.</p>
    </div>
  </div>
</section>

<footer>
  <div class="footer-logo">Biologji</div>
  <p>Projekt i Biologjisë · Specializimi dhe Organizimi i Qelizave · Sëmundjet e Organeve</p>
  <p style="margin-top:8px;font-size:0.75rem">Klasa XII-I · 2025–2026</p>
</footer>

<script>
// CUSTOM CURSOR
const cursor = document.getElementById('cursor');
const ring = document.getElementById('cursorRing');
let mouseX = 0, mouseY = 0, ringX = 0, ringY = 0;
document.addEventListener('mousemove', e => {
  mouseX = e.clientX; mouseY = e.clientY;
  cursor.style.transform = `translate(${mouseX - 6}px, ${mouseY - 6}px)`;
});
function animateRing() {
  ringX += (mouseX - ringX - 20) * 0.12;
  ringY += (mouseY - ringY - 20) * 0.12;
  ring.style.transform = `translate(${ringX}px, ${ringY}px)`;
  requestAnimationFrame(animateRing);
}
animateRing();

// PROGRESS BAR
window.addEventListener('scroll', () => {
  const bar = document.getElementById('progressBar');
  const p = window.scrollY / (document.documentElement.scrollHeight - window.innerHeight);
  bar.style.width = (p * 100) + '%';
});

// ANIMATED CANVAS PARTICLES
const canvas = document.getElementById('bg-canvas');
const ctx = canvas.getContext('2d');
function resizeCanvas() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
}
resizeCanvas();
window.addEventListener('resize', resizeCanvas);

class Particle {
  constructor() { this.reset(); }
  reset() {
    this.x = Math.random() * canvas.width;
    this.y = Math.random() * canvas.height;
    this.vx = (Math.random() - 0.5) * 0.4;
    this.vy = (Math.random() - 0.5) * 0.4;
    this.r = Math.random() * 1.5 + 0.3;
    this.alpha = Math.random() * 0.4 + 0.05;
    const colors = ['0,212,255','0,255,157','199,125,255','255,107,53'];
    this.color = colors[Math.floor(Math.random() * colors.length)];
    this.life = 0;
    this.maxLife = 300 + Math.random() * 400;
  }
  update() {
    this.x += this.vx; this.y += this.vy; this.life++;
    if (this.life > this.maxLife) this.reset();
    if (this.x < 0 || this.x > canvas.width) this.vx *= -1;
    if (this.y < 0 || this.y > canvas.height) this.vy *= -1;
  }
  draw() {
    const fade = Math.min(this.life / 30, 1) * Math.min((this.maxLife - this.life) / 30, 1);
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2);
    ctx.fillStyle = `rgba(${this.color},${this.alpha * fade})`;
    ctx.fill();
  }
}

const particles = [];
for (let i = 0; i < 120; i++) particles.push(new Particle());

function drawConnections() {
  for (let i = 0; i < particles.length; i++) {
    for (let j = i + 1; j < particles.length; j++) {
      const dx = particles[i].x - particles[j].x;
      const dy = particles[i].y - particles[j].y;
      const dist = Math.sqrt(dx*dx + dy*dy);
      if (dist < 100) {
        ctx.beginPath();
        ctx.moveTo(particles[i].x, particles[i].y);
        ctx.lineTo(particles[j].x, particles[j].y);
        ctx.strokeStyle = `rgba(0,212,255,${0.03 * (1 - dist/100)})`;
        ctx.lineWidth = 0.5;
        ctx.stroke();
      }
    }
  }
}

function animateCanvas() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  drawConnections();
  particles.forEach(p => { p.update(); p.draw(); });
  requestAnimationFrame(animateCanvas);
}
animateCanvas();

// SCROLL REVEAL
const revealEls = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) e.target.classList.add('revealed');
  });
}, { threshold: 0.1 });
revealEls.forEach(el => observer.observe(el));

// PARALLAX FLOATING CELLS
window.addEventListener('scroll', () => {
  const cells = document.querySelectorAll('.floating-cell');
  const sy = window.scrollY;
  cells.forEach((c, i) => {
    c.style.transform = `translateY(${sy * (0.1 + i * 0.05)}px)`;
  });
});

// CARD HOVER GLOW
document.querySelectorAll('.org-card').forEach(card => {
  card.addEventListener('mousemove', e => {
    const rect = card.getBoundingClientRect();
    const x = ((e.clientX - rect.left) / rect.width) * 100;
    const y = ((e.clientY - rect.top) / rect.height) * 100;
    card.style.setProperty('--mx', x + '%');
    card.style.setProperty('--my', y + '%');
  });
});
</script>
</body>
</html>


