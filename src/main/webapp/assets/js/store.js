(() => {
    const contextMeta = document.querySelector('meta[name="ctx-path"]');
    const ctx = contextMeta ? contextMeta.content : '';

    // 1. Persisted HUD Theme Toggle (Cyber Cyan <-> Neon Violet)
    const savedTheme = localStorage.getItem('nexus-theme') || 'cyan';
    if (savedTheme === 'violet') {
        document.body.setAttribute('data-theme', 'violet');
    }
    const themeBtn = document.getElementById('theme-toggle');
    if (themeBtn) {
        const updateThemeLabel = () => {
            const isViolet = document.body.getAttribute('data-theme') === 'violet';
            themeBtn.textContent = isViolet ? 'HUD: VIOLET' : 'HUD: CYAN';
        };
        updateThemeLabel();
        themeBtn.addEventListener('click', () => {
            const isViolet = document.body.getAttribute('data-theme') === 'violet';
            if (isViolet) {
                document.body.removeAttribute('data-theme');
                localStorage.setItem('nexus-theme', 'cyan');
            } else {
                document.body.setAttribute('data-theme', 'violet');
                localStorage.setItem('nexus-theme', 'violet');
            }
            updateThemeLabel();
        });
    }

    // 2. Toast helper
    function showToast(message, actionHref, actionLabel) {
        const stack = document.getElementById('toast-stack');
        if (!stack) return;
        const toast = document.createElement('div');
        toast.className = 'hud-toast';
        const text = document.createElement('span');
        text.textContent = message;
        toast.appendChild(text);
        if (actionHref && actionLabel) {
            const link = document.createElement('a');
            link.href = actionHref;
            link.className = 'btn btn--ghost btn--sm';
            link.textContent = actionLabel;
            toast.appendChild(link);
        }
        stack.appendChild(toast);
        setTimeout(() => {
            toast.style.opacity = '0';
            toast.style.transition = 'opacity 0.25s ease';
            setTimeout(() => toast.remove(), 260);
        }, 3200);
    }

    // 3. Mouse-tracking spotlight & subtle 3D tilt on product cards
    document.querySelectorAll('.product-card').forEach((card) => {
        card.addEventListener('mousemove', (e) => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            card.style.setProperty('--mouse-x', `${x}px`);
            card.style.setProperty('--mouse-y', `${y}px`);
            const rotateY = ((x / rect.width) - 0.5) * 6;
            const rotateX = ((y / rect.height) - 0.5) * -6;
            card.style.transform = `perspective(900px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-3px)`;
        });
        card.addEventListener('mouseleave', () => {
            card.style.transform = '';
        });
    });

    // 4. Async Quick-Add to Cart (progressive enhancement over standard form POST)
    document.querySelectorAll('form[data-async-cart="true"]').forEach((form) => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const btn = form.querySelector('button[type="submit"]');
            const originalLabel = btn ? btn.textContent : '';
            if (btn) {
                btn.disabled = true;
                btn.textContent = 'Adding...';
            }
            try {
                const body = new URLSearchParams(new FormData(form));
                const resp = await fetch(form.action, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: body.toString()
                });
                if (!resp.ok) throw new Error('Request failed');
                const html = await resp.text();
                const doc = new DOMParser().parseFromString(html, 'text/html');
                const newCount = doc.getElementById('hud-cart-count')?.textContent?.trim();
                const badge = document.getElementById('hud-cart-count');
                if (badge) {
                    badge.textContent = newCount || String(Number(badge.textContent || '0') + 1);
                    badge.classList.remove('pulse');
                    void badge.offsetWidth;
                    badge.classList.add('pulse');
                }
                const itemName = form.dataset.productName || 'Item';
                showToast(`Added "${itemName}" to cart`, `${ctx}/cart`, 'Open Cart');
            } catch {
                form.submit();
            } finally {
                if (btn) {
                    btn.disabled = false;
                    btn.textContent = originalLabel;
                }
            }
        });
    });

    // 5. Catalog Live Search & Sort
    const grid = document.getElementById('catalog-grid');
    const searchInput = document.getElementById('catalog-search');
    const sortSelect = document.getElementById('catalog-sort');
    const emptyFilter = document.getElementById('catalog-empty-filter');
    const resultCount = document.getElementById('catalog-result-count');

    if (grid && (searchInput || sortSelect)) {
        const cards = Array.from(grid.querySelectorAll('.product-card'));
        const applyFilterAndSort = () => {
            const q = (searchInput?.value || '').trim().toLowerCase();
            const sortBy = sortSelect?.value || 'default';

            const sorted = [...cards].sort((a, b) => {
                const priceA = parseFloat(a.dataset.price || '0');
                const priceB = parseFloat(b.dataset.price || '0');
                const nameA = (a.dataset.name || '').toLowerCase();
                const nameB = (b.dataset.name || '').toLowerCase();
                const idA = parseInt(a.dataset.id || '0', 10);
                const idB = parseInt(b.dataset.id || '0', 10);

                if (sortBy === 'price-asc') return priceA - priceB;
                if (sortBy === 'price-desc') return priceB - priceA;
                if (sortBy === 'name-asc') return nameA.localeCompare(nameB);
                return idA - idB;
            });

            let visible = 0;
            sorted.forEach((card) => {
                const haystack = `${card.dataset.name || ''} ${card.dataset.category || ''}`.toLowerCase();
                const match = !q || haystack.includes(q);
                card.style.display = match ? '' : 'none';
                if (match) visible += 1;
                grid.appendChild(card);
            });

            if (emptyFilter) {
                emptyFilter.style.display = visible === 0 ? 'block' : 'none';
            }
            if (resultCount) {
                resultCount.textContent = `${visible} module${visible === 1 ? '' : 's'} online`;
            }
        };

        searchInput?.addEventListener('input', applyFilterAndSort);
        sortSelect?.addEventListener('change', applyFilterAndSort);

        document.addEventListener('keydown', (e) => {
            if (e.key === '/' && document.activeElement !== searchInput &&
                !['INPUT', 'TEXTAREA', 'SELECT'].includes(document.activeElement?.tagName)) {
                e.preventDefault();
                searchInput?.focus();
            }
        });
    }

    // 6. Product Detail Spec Tabs
    document.querySelectorAll('[data-tab-target]').forEach((tabBtn) => {
        tabBtn.addEventListener('click', () => {
            const targetId = tabBtn.dataset.tabTarget;
            document.querySelectorAll('[data-tab-target]').forEach((b) => b.classList.remove('is-active'));
            document.querySelectorAll('.spec-panel').forEach((p) => p.classList.remove('is-active'));
            tabBtn.classList.add('is-active');
            document.getElementById(targetId)?.classList.add('is-active');
        });
    });

    // 7. Landing Page Servlet Diagnostics Ping
    const pingOutput = document.getElementById('ping-output');
    document.querySelectorAll('[data-ping-url]').forEach((btn) => {
        btn.addEventListener('click', async () => {
            const url = btn.dataset.pingUrl;
            if (!pingOutput) return;
            pingOutput.textContent = `> Pinging ${url} ...`;
            const t0 = performance.now();
            try {
                const res = await fetch(url);
                const text = (await res.text()).trim();
                const ms = Math.round(performance.now() - t0);
                pingOutput.textContent = `> HTTP ${res.status} (${ms}ms) from ${url}\n${text}`;
            } catch (err) {
                pingOutput.textContent = `> Error pinging ${url}: ${err}`;
            }
        });
    });
})();
