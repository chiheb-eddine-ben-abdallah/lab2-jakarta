<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/header.jsp" />

<section class="glass-panel hero-card">
    <div class="eyebrow">
        <span class="status-dot"></span>
        <span>WildFly 42 &bull; Jakarta EE 11 Live Environment</span>
    </div>
    <h1 class="page-title">NEXUS Command Center</h1>
    <p class="page-subtitle">
        Welcome to the Jakarta EE interactive storefront and servlet lab. Launch into the Quantum Catalog, inspect session cart state, or ping backend servlet endpoints in real time.
    </p>
    <div style="margin-top: 1.5rem; display: flex; gap: 0.75rem; flex-wrap: wrap;">
        <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--primary">
            Launch Quantum Catalog &rarr;
        </a>
        <a href="${pageContext.request.contextPath}/cart" class="btn btn--ghost">
            Open Cart (${empty sessionScope.cart ? 0 : sessionScope.cart.size()})
        </a>
    </div>
</section>

<section class="module-grid">
    <div class="glass-panel module-card">
        <div>
            <span class="category-chip">STOREFRONT</span>
            <h2 style="margin: 0.7rem 0 0.35rem; font-family: var(--font-display); font-size: 1.2rem;">
                Product Catalog
            </h2>
            <p style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">
                Filter hardware, books, and workspace gear with real-time search and quick-add.
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--ghost btn--sm">
            /catalog/products &rarr;
        </a>
    </div>

    <div class="glass-panel module-card">
        <div>
            <span class="category-chip">SESSION STATE</span>
            <h2 style="margin: 0.7rem 0 0.35rem; font-family: var(--font-display); font-size: 1.2rem;">
                Shopping Cart
            </h2>
            <p style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">
                Manage HttpSession-backed cart items and review live price totals.
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/cart" class="btn btn--ghost btn--sm">
            /cart &rarr;
        </a>
    </div>

    <div class="glass-panel module-card">
        <div>
            <span class="category-chip">DISPATCH</span>
            <h2 style="margin: 0.7rem 0 0.35rem; font-family: var(--font-display); font-size: 1.2rem;">
                Checkout Terminal
            </h2>
            <p style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">
                Submit order coordinates and clear the active session cart buffer.
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/checkout" class="btn btn--ghost btn--sm">
            /checkout &rarr;
        </a>
    </div>
</section>

<section class="glass-panel terminal-box">
    <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.75rem;">
        <div>
            <span style="color: var(--accent-primary);">// SERVLET DIAGNOSTICS CONSOLE</span>
            <span style="color: var(--text-muted); margin-left: 0.6rem;">Test starter endpoints inline or open directly</span>
        </div>
        <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
            <button type="button" class="btn btn--ghost btn--sm" data-ping-url="${pageContext.request.contextPath}/hello">
                Ping /hello
            </button>
            <button type="button" class="btn btn--ghost btn--sm" data-ping-url="${pageContext.request.contextPath}/hello-servlet">
                Ping /hello-servlet
            </button>
            <button type="button" class="btn btn--ghost btn--sm" data-ping-url="${pageContext.request.contextPath}/goodbye">
                Ping /goodbye
            </button>
        </div>
    </div>
    <pre id="ping-output" class="terminal-output">&gt; Ready. Click a diagnostic button to probe a Jakarta Servlet endpoint.</pre>
</section>

<jsp:include page="/WEB-INF/views/footer.jsp" />
