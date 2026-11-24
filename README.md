# NEXUS // Jakarta EE Store — Lab 2

A futuristic, interactive product storefront built with **Jakarta EE 11**, demonstrating servlets, filters, JSP views with JSTL, HTTP sessions, and a full glassmorphic HUD UI.

---

## 🛠️ Tech Stack & Prerequisites

| Layer | Technology |
| :--- | :--- |
| **Language** | Java 17+ (tested with OpenJDK 25) |
| **Spec** | Jakarta EE 11 — Servlet 6.1, JSP, JSTL 3.0 |
| **Build** | Apache Maven 3.9+ (includes Maven Wrapper) |
| **Testing** | JUnit Jupiter 6.x |
| **Server** | WildFly 42.0.0.Final (or any Jakarta EE 11 container) |
| **Frontend** | Custom CSS design system + vanilla JS (no frameworks) |

---

## 📁 Project Structure

```text
jakartaee-course/
├── src/main/
│   ├── java/
│   │   ├── com/course/catalog/
│   │   │   ├── filter/
│   │   │   │   ├── AuthenticationFilter.java      # Cart path guard (placeholder)
│   │   │   │   └── RequestLoggingFilter.java       # Request timing & slow-request warnings
│   │   │   ├── model/
│   │   │   │   ├── ProductCatalog.java             # In-memory product data store
│   │   │   │   └── ProductDTO.java                 # Serializable product model
│   │   │   └── web/
│   │   │       ├── CartServlet.java                # Session-based shopping cart (/cart, /cart/add, /cart/remove)
│   │   │       ├── CheckoutServlet.java            # Order form & confirmation (/checkout)
│   │   │       ├── ProductDetailServlet.java       # Single product view (/catalog/product?id=)
│   │   │       └── ProductListServlet.java         # Filtered product list (/catalog/products)
│   │   └── com/example/jakartaeecourse/
│   │       ├── HelloServlet.java                   # GET /hello & /hello-servlet
│   │       └── GoodbyeServlet.java                 # GET /goodbye
│   └── webapp/
│       ├── assets/
│       │   ├── css/store.css                       # Futuristic HUD design system
│       │   └── js/store.js                         # Interactive JS (search, sort, async cart, toasts, 3D tilt)
│       ├── WEB-INF/
│       │   ├── views/
│       │   │   ├── header.jsp                      # HUD navigation shell with theme toggle
│       │   │   ├── footer.jsp                      # Footer with toast stack & JS loader
│       │   │   ├── products.jsp                    # Quantum Catalog grid
│       │   │   ├── product-detail.jsp              # Holographic product detail with spec tabs
│       │   │   ├── cart.jsp                         # Cart with order telemetry sidebar
│       │   │   └── checkout.jsp                    # Encrypted dispatch terminal form
│       │   └── web.xml                             # Jakarta EE 6.1 deployment descriptor
│       └── index.jsp                               # NEXUS Command Center (landing page)
├── src/test/java/.../ServletMappingTest.java       # Unit tests for servlet annotations
├── pom.xml
└── README.md
```

---

## 🚀 Available Endpoints

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/` | GET | NEXUS Command Center — landing page with servlet diagnostics console |
| `/catalog/products` | GET | Quantum Catalog — product grid with live search, sort & category filters |
| `/catalog/products?category=Electronics` | GET | Category-filtered catalog |
| `/catalog/product?id=1` | GET | Product detail with holographic preview & spec tabs |
| `/cart` | GET | Shopping cart with order telemetry sidebar |
| `/cart/add` | POST | Add item to session cart (supports async fetch) |
| `/cart/remove` | POST | Remove item from session cart |
| `/checkout` | GET/POST | Checkout form & order confirmation |
| `/hello` | GET | Returns `Hello, Enterprise World!` |
| `/hello-servlet` | GET | Alternative route to HelloServlet |
| `/goodbye` | GET | Returns `Goodbye, Enterprise World!` |

---

## ✨ UI Features

- **Glassmorphic HUD Design** — dark obsidian backdrop with cyber grid, ambient glow orbs, blur-glass panels
- **Dual Theme Toggle** — switch between Cyber Cyan and Neon Violet accent palettes (persisted in localStorage)
- **Mouse-Tracking Spotlight & 3D Tilt** — interactive product cards with radial glow and perspective transforms
- **Async Quick-Add to Cart** — `fetch`-based add-to-cart with animated badge pulse and toast notifications
- **Live Catalog Search & Sort** — instant client-side filtering (`/` keyboard shortcut) and multi-criteria sort
- **Product Detail Spec Tabs** — Overview, Telemetry, Dispatch tabbed panels
- **Servlet Diagnostics Console** — ping `/hello`, `/hello-servlet`, `/goodbye` inline with response time readouts
- **Responsive Layout** — grid auto-adapts from mobile to desktop

---

## ⚙️ Building & Running

### 1. Run Unit Tests
```bash
# Windows
.\mvnw.cmd test

# Linux / macOS
./mvnw test
```

### 2. Package the Application
```bash
.\mvnw.cmd clean package
```
Output: `target/jakartaee-course-1.0-SNAPSHOT.war`

### 3. Deploy to WildFly
```bash
copy target\jakartaee-course-1.0-SNAPSHOT.war C:\servers\wildfly-42.0.0.Final\standalone\deployments\
C:\servers\wildfly-42.0.0.Final\bin\standalone.bat
```

### 4. Open in Browser
```
http://localhost:8080/jakartaee-course-1.0-SNAPSHOT/
```

### IntelliJ IDEA
Use the pre-configured `JBoss/WildFly 42.0.0.Final` run configuration with the `jakartaee-course:war exploded` artifact.

---

## 📄 License

Course lab project — Jakarta EE 11 / Servlet 6.1 / Lab 02.
