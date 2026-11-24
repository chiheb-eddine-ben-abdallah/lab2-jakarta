<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="header.jsp" />

<section>
    <div class="eyebrow">
        <span class="status-dot"></span>
        <span>Encrypted Dispatch Terminal</span>
    </div>
    <h1 class="page-title">Checkout</h1>
    <p class="page-subtitle">Enter recipient coordinates to finalize your order and clear the active session cart.</p>
</section>

<c:if test="${not empty confirmationName}">
    <div class="alert-success">
        <strong>Transmission Confirmed:</strong> Thank you, <strong><c:out value="${confirmationName}" /></strong>!
        Your order has been dispatched and your session cart has been cleared.
        <div style="margin-top: 0.85rem;">
            <a href="${pageContext.request.contextPath}/catalog/products" class="btn btn--ghost btn--sm">
                Return to Catalog
            </a>
        </div>
    </div>
</c:if>

<div class="checkout-layout">
    <form action="${pageContext.request.contextPath}/checkout" method="post" class="glass-panel hud-form">
        <div class="field-group">
            <label for="checkout-name">Full Name</label>
            <input id="checkout-name" type="text" name="name" placeholder="Ada Lovelace" required />
        </div>

        <div class="field-group">
            <label for="checkout-email">Comm Email</label>
            <input id="checkout-email" type="email" name="email" placeholder="ada@nexus.dev" required />
        </div>

        <div class="field-group">
            <label for="checkout-address">Shipping Coordinates</label>
            <textarea id="checkout-address" name="address" rows="3" placeholder="Sector 7, Orbital Station Alpha..." required></textarea>
        </div>

        <button type="submit" class="btn btn--primary" style="margin-top: 0.4rem;">
            Authorize &amp; Place Order &rarr;
        </button>
    </form>

    <aside class="glass-panel summary-card">
        <h2 style="margin: 0 0 1rem; font-family: var(--font-display); font-size: 1.2rem;">
            Active Cart Manifest
        </h2>
        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <p style="color: var(--text-secondary); font-size: 0.92rem; margin: 0;">
                    No items currently queued in your cart.
                </p>
            </c:when>
            <c:otherwise>
                <c:set var="checkoutTotal" value="0" />
                <c:forEach var="item" items="${sessionScope.cart}">
                    <c:set var="checkoutTotal" value="${checkoutTotal + item.price}" />
                    <div class="summary-row">
                        <span><c:out value="${item.name}" /></span>
                        <span style="font-family: var(--font-mono); color: var(--text-primary);">
                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
                        </span>
                    </div>
                </c:forEach>
                <div class="summary-total">
                    <span>Total Due</span>
                    <span class="price-tag">
                        <fmt:formatNumber value="${checkoutTotal}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
                    </span>
                </div>
            </c:otherwise>
        </c:choose>
    </aside>
</div>

<jsp:include page="footer.jsp" />
