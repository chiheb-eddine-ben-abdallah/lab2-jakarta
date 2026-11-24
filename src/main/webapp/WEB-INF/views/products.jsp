<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<jsp:include page="header.jsp" />

<section>
    <div class="eyebrow">
        <span class="status-dot"></span>
        <span>Hardware &amp; Knowledge Matrix</span>
    </div>
    <h1 class="page-title">Quantum Catalog</h1>
    <p class="page-subtitle">
        Browse curated developer gear and engineering essentials. Filter by sector, search in real time, or quick-add directly to your session cart.
    </p>
</section>

<section class="glass-panel catalog-toolbar">
    <div class="filter-pills">
        <a href="${pageContext.request.contextPath}/catalog/products"
           class="filter-pill ${empty param.category ? 'is-active' : ''}">All</a>
        <a href="${pageContext.request.contextPath}/catalog/products?category=Electronics"
           class="filter-pill ${param.category eq 'Electronics' ? 'is-active' : ''}">Electronics</a>
        <a href="${pageContext.request.contextPath}/catalog/products?category=Books"
           class="filter-pill ${param.category eq 'Books' ? 'is-active' : ''}">Books</a>
        <a href="${pageContext.request.contextPath}/catalog/products?category=Home"
           class="filter-pill ${param.category eq 'Home' ? 'is-active' : ''}">Home</a>
    </div>

    <div class="toolbar-controls">
        <div class="search-box">
            <input type="search" id="catalog-search" placeholder="Search modules..." aria-label="Search products" />
            <span class="search-box__kbd">/</span>
        </div>
        <select id="catalog-sort" class="hud-select" aria-label="Sort products">
            <option value="default">Sort: Featured</option>
            <option value="price-asc">Price: Low to High</option>
            <option value="price-desc">Price: High to Low</option>
            <option value="name-asc">Name: A to Z</option>
        </select>
        <span id="catalog-result-count" class="brand__tag">${products.size()} modules online</span>
    </div>
</section>

<section id="catalog-grid" class="product-grid">
    <c:forEach var="product" items="${products}">
        <article class="product-card"
                 data-id="${product.id}"
                 data-name="${product.name}"
                 data-category="${product.category}"
                 data-price="${product.price}">
            <div>
                <div class="product-card__visual">
                    <span class="product-card__id">SKU-00${product.id}</span>
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

                <span class="category-chip">${product.category}</span>
                <h2 class="product-card__title">
                    <a href="${pageContext.request.contextPath}/catalog/product?id=${product.id}">
                        <c:out value="${product.name}" />
                    </a>
                </h2>
            </div>

            <div class="product-card__footer">
                <span class="price-tag">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
                </span>
                <div class="card-actions">
                    <a href="${pageContext.request.contextPath}/catalog/product?id=${product.id}" class="btn btn--ghost btn--sm">
                        Inspect
                    </a>
                    <form action="${pageContext.request.contextPath}/cart/add"
                          method="post"
                          data-async-cart="true"
                          data-product-name="${product.name}">
                        <input type="hidden" name="productId" value="${product.id}" />
                        <button type="submit" class="btn btn--primary btn--sm">+ Add</button>
                    </form>
                </div>
            </div>
        </article>
    </c:forEach>
</section>

<div id="catalog-empty-filter" class="glass-panel empty-state" style="display: none; margin-top: 1.5rem;">
    <p class="page-subtitle" style="margin: 0 auto;">No modules matched your search query.</p>
</div>

<jsp:include page="footer.jsp" />
