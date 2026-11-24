<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="reqUri" value="${empty requestScope['jakarta.servlet.forward.request_uri'] ? pageContext.request.requestURI : requestScope['jakarta.servlet.forward.request_uri']}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="ctx-path" content="${pageContext.request.contextPath}" />
    <title>NEXUS // Jakarta EE Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/store.css" />
</head>
<body>
<div class="cyber-grid" aria-hidden="true"></div>
<div class="ambient-orb ambient-orb--one" aria-hidden="true"></div>
<div class="ambient-orb ambient-orb--two" aria-hidden="true"></div>

<header class="hud-header">
    <div class="hud-header__inner">
        <a href="${pageContext.request.contextPath}/" class="brand">
            <span class="brand__orb" aria-hidden="true">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polygon points="12 2 21 7 21 17 12 22 3 17 3 7 12 2" />
                    <circle cx="12" cy="12" r="3" />
                </svg>
            </span>
            <span>NEXUS // STORE</span>
            <span class="brand__tag">EE 11</span>
        </a>

        <nav class="hud-nav" aria-label="Primary">
            <a href="${pageContext.request.contextPath}/"
               class="nav-pill ${reqUri == pageContext.request.contextPath.concat('/') || reqUri.endsWith('/index.jsp') ? 'is-active' : ''}">
                Command
            </a>
            <a href="${pageContext.request.contextPath}/catalog/products"
               class="nav-pill ${reqUri.contains('/catalog') ? 'is-active' : ''}">
                Catalog
            </a>
            <a href="${pageContext.request.contextPath}/cart"
               class="nav-pill ${reqUri.contains('/cart') ? 'is-active' : ''}">
                <span>Cart</span>
                <span id="hud-cart-count" class="cart-badge">${empty sessionScope.cart ? 0 : sessionScope.cart.size()}</span>
            </a>
            <a href="${pageContext.request.contextPath}/checkout"
               class="nav-pill ${reqUri.contains('/checkout') ? 'is-active' : ''}">
                Checkout
            </a>
            <button type="button" id="theme-toggle" class="theme-toggle" title="Switch HUD accent">
                HUD: CYAN
            </button>
        </nav>
    </div>
</header>

<main class="page-shell">
