# Jakarta EE Course Project

A starter web application built with **Jakarta EE 11**, demonstrating servlet mappings, JSP views, modern Maven configuration, and automated unit testing with JUnit Jupiter.

---

## 🛠️ Tech Stack & Prerequisites

* **Java:** JDK 17 or higher (tested with Java 17 LTS / OpenJDK 25)
* **Jakarta EE Specification:** Jakarta EE 11 (Jakarta Servlet 6.1)
* **Build Tool:** Apache Maven 3.9+ (includes Maven Wrapper `mvnw` / `mvnw.cmd`)
* **Testing:** JUnit Jupiter 6.x
* **Application Server:** JBoss/WildFly 42.0.0.Final, Apache Tomcat 11+, or any Jakarta EE 11 compatible container

---

## 📁 Project Structure

```text
jakartaee-course/
├── src/
│   ├── main/
│   │   ├── java/com/example/jakartaeecourse/
│   │   │   ├── HelloServlet.java       # Servlet mapped to /hello and /hello-servlet
│   │   │   └── GoodbyeServlet.java     # Servlet mapped to /goodbye
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml             # Jakarta EE 6.1 deployment descriptor
│   │       └── index.jsp               # Landing page with navigation links
│   └── test/
│       └── java/com/example/jakartaeecourse/
│           └── ServletMappingTest.java # Unit tests for servlet annotations & routes
├── .gitignore                          # Standard git ignore rules
├── mvnw / mvnw.cmd                     # Maven wrapper scripts
├── pom.xml                             # Maven build configuration
└── README.md                           # Project documentation
```

---

## 🚀 Available Endpoints

When deployed, the application is accessible under its context root (e.g. `/jakartaee-course-1.0-SNAPSHOT/`):

| Endpoint | Type | Description |
| :--- | :--- | :--- |
| `/` (`index.jsp`) | JSP View | Welcome page providing navigation to test servlets |
| `/hello` | Servlet | Returns `Hello, Enterprise World!` |
| `/hello-servlet` | Servlet | Alternative route to HelloServlet |
| `/goodbye` | Servlet | Returns `Goodbye, Enterprise World!` |

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
Build the deployable WAR file:
```bash
# Windows
.\mvnw.cmd clean package

# Linux / macOS
./mvnw clean package
```
The output package will be located at:
* `target/jakartaee-course-1.0-SNAPSHOT.war` (WAR archive)
* `target/jakartaee-course-1.0-SNAPSHOT/` (Exploded directory)

### 3. Deploy to Application Server

#### In IntelliJ IDEA:
1. Open the project in IntelliJ IDEA Ultimate.
2. Select the pre-configured run configuration: `JBoss/WildFly 42.0.0.Final`.
3. Ensure the artifact `jakartaee-course:war exploded` is added to the deployment tab.
4. Click **Run** or **Debug**.

#### Manual Deployment (WildFly):
Copy `target/jakartaee-course-1.0-SNAPSHOT.war` into your WildFly standalone deployments directory:
```bash
cp target/jakartaee-course-1.0-SNAPSHOT.war $WILDFLY_HOME/standalone/deployments/
```
Once deployed, open your browser at:
```
http://localhost:8080/jakartaee-course-1.0-SNAPSHOT/
```
