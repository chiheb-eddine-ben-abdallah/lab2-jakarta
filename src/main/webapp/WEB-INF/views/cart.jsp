<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="header.jsp" />

<section>
    <div class="eyebrow">
        <span class="status-dot"></span>
        <span>Session Cart Buffer</span>
    </div>
    <h1 class="page-title">Your Shopping Cart</h1>
    <p class="page-subtitle">Review queued modules before initializing checkout transmission.</p>
</section>

<c:choose>
    <c:when test="${empty cart}">
        <div class="glass-panel empty-state" style="margin-top: 1.75rem;">
            <h2 style="font-family: var(--font-display); margin: 0 0 0.5rem;">Cart Buffer Empty</h2>
            <p class="page-subtitle" style="margin: 0 auto 1.4rem;">
                No items are currently staged in your HTTP session.
            </p>
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--primary">
                Explore Quantum Catalog
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <c:set var="cartTotal" value="0" />
        <c:forEach var="item" items="${cart}">
            <c:set var="cartTotal" value="${cartTotal + item.price}" />
        </c:forEach>

        <div class="cart-layout">
            <div class="cart-list">
                <c:forEach var="item" items="${cart}">
                    <div class="glass-panel cart-item">
                        <div>
                            <span class="category-chip">${item.category}</span>
                            <h3 style="margin: 0.45rem 0 0.15rem; font-family: var(--font-display); font-size: 1.08rem;">
                                <a href="${pageContext.request.contextPath}/catalog/product?id=${item.id}">
                                    <c:out value="${item.name}" />
                                </a>
                            </h3>
                            <span style="font-family: var(--font-mono); font-size: 0.78rem; color: var(--text-muted);">
                                SKU-00${item.id}
                            </span>
                        </div>

                        <div style="display: flex; align-items: center; gap: 1rem;">
                            <span class="price-tag">
                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
                            </span>
                            <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                                <input type="hidden" name="productId" value="${item.id}" />
                                <button type="submit" class="btn btn--danger btn--sm">Remove</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <aside class="glass-panel summary-card">
                <h2 style="margin: 0 0 1rem; font-family: var(--font-display); font-size: 1.25rem;">
                    Order Telemetry
                </h2>
                <div class="summary-row">
                    <span>Queued Items</span>
                    <span>${cart.size()}</span>
                </div>
                <div class="summary-row">
                    <span>Orbital Express Shipping</span>
                    <span style="color: var(--accent-emerald);">FREE</span>
                </div>
                <div class="summary-total">
                    <span>Total</span>
                    <span class="price-tag" style="font-size: 1.45rem;">
                        <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
                    </span>
                </div>
                <div style="margin-top: 1.35rem; display: flex; flex-direction: column; gap: 0.65rem;">
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn--primary">
                        Proceed to Checkout &rarr;
                    </a>
                    <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--ghost">
                        Continue Browsing
                    </a>
                </div>
            </aside>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="footer.jsp" />
