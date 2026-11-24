<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="header.jsp" />

<div style="margin-bottom: 1.25rem;">
    <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--ghost btn--sm">
        &larr; Back to Catalog
    </a>
</div>

<c:choose>
    <c:when test="${not empty product}">
        <div class="detail-grid">
            <div class="glass-panel holo-stage">
                <span class="product-card__id" style="top: 1rem; right: 1.25rem;">SKU-00${product.id}</span>
                <div class="holo-ring">
                    <c:choose>
                        <c:when test="${product.category eq 'Books'}">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6">
                                <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
                                <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
                                <path d="M8 7h8M8 11h6" />
                            </svg>
                        </c:when>
                        <c:when test="${product.category eq 'Home'}">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6">
                                <path d="M9 18h6M10 22h4" />
                                <path d="M12 2a7 7 0 0 0-4 12.7c.6.5 1 1.3 1 2.1V17h6v-.2c0-.8.4-1.6 1-2.1A7 7 0 0 0 12 2z" />
                            </svg>
                        </c:when>
                        <c:otherwise>
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6">
                                <rect x="4" y="4" width="16" height="16" rx="2" />
                                <rect x="9" y="9" width="6" height="6" rx="1" />
                                <path d="M9 1v3M15 1v3M9 20v3M15 20v3M20 9h3M20 14h3M1 9h3M1 14h3" />
                            </svg>
                        </c:otherwise>
                    </c:choose>
                </div>
                <p class="eyebrow" style="margin-top: 1.5rem; margin-bottom: 0;">
                    <span class="status-dot"></span>
                    <span>IN STOCK // READY TO DISPATCH</span>
                </p>
            </div>

            <div class="glass-panel" style="padding: 2rem;">
                <span class="category-chip">${product.category}</span>
                <h1 class="page-title" style="margin-top: 0.75rem; font-size: 2rem;">
                    <c:out value="${product.name}" />
                </h1>

                <div style="margin: 1rem 0 1.4rem; display: flex; align-items: baseline; gap: 1rem;">
                    <span class="price-tag" style="font-size: 1.75rem;">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
                    </span>
                    <span style="color: var(--text-muted); font-family: var(--font-mono); font-size: 0.8rem;">
                        FREE ORBITAL SHIPPING
                    </span>
                </div>

                <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                    <form action="${pageContext.request.contextPath}/cart/add"
                          method="post"
                          data-async-cart="true"
                          data-product-name="${product.name}">
                        <input type="hidden" name="productId" value="${product.id}" />
                        <button type="submit" class="btn btn--primary">Add to Cart</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/cart/add" method="post">
                        <input type="hidden" name="productId" value="${product.id}" />
                        <button type="submit" class="btn btn--ghost">Add &amp; Open Cart &rarr;</button>
                    </form>
                </div>

                <div class="spec-tabs">
                    <button type="button" class="spec-tab is-active" data-tab-target="tab-overview">Overview</button>
                    <button type="button" class="spec-tab" data-tab-target="tab-telemetry">Telemetry</button>
                    <button type="button" class="spec-tab" data-tab-target="tab-dispatch">Dispatch</button>
                </div>

                <div id="tab-overview" class="spec-panel is-active">
                    Engineered for peak developer productivity in the <strong>${product.category}</strong> sector. Verified for Jakarta EE Lab 02 inventory standards.
                </div>
                <div id="tab-telemetry" class="spec-panel">
                    Module ID: <code>SKU-00${product.id}</code> &bull; Session Persistence: Enabled &bull; Warranty: 24-Month Quantum Coverage
                </div>
                <div id="tab-dispatch" class="spec-panel">
                    Ships immediately from the WildFly 42 fulfillment node. Zero-fee express delivery unlocked for all catalog orders.
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="glass-panel empty-state">
            <h2 class="page-title" style="font-size: 1.7rem;">Product Not Found</h2>
            <p class="page-subtitle" style="margin: 0.5rem auto 1.25rem;">
                The requested SKU identifier does not exist in the active catalog matrix.
            </p>
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--primary">
                Return to Catalog
            </a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="footer.jsp" />
