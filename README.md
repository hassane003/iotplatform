# iotplatform

TP JEE — **Servlet + JSP/JSTL** déployé sur **Tomcat 10.1.x** (Jakarta EE 10) avec **Java 17** et build **Maven (WAR)**.  
Application “IoT Dashboard” permettant de **simuler l’ingestion** de mesures capteurs (en mémoire) et de **les afficher** côté JSP.

---

## ✨ Fonctionnalités
- Formulaire d’ingestion d’une mesure capteur : `sensorId`, `sensorType`, `value`, `unit`, `location`.
- Stockage **en mémoire** (DAO thread-safe `ConcurrentHashMap`).
- Listing des mesures en JSP avec **JSTL** (`<c:forEach>`, fonctions `fn:*` si besoin).
- Servlet de test **Hello** : `/hello` → renvoie `Hello, World!`.

---

## 🧰 Stack & versions
- **Java** 17 (Temurin/Oracle/OpenJDK)
- **Apache Tomcat** 10.1.x (Jakarta EE 10 / `jakarta.*`)
- **Maven** 3.8+ (recommandé 3.9.x)
- **JSP/JSTL** Jakarta (`jakarta.tags.core`, `jakarta.tags.functions`)

---

## 📁 Structure du projet
iotplatform/
├─ pom.xml
├─ src/
│ ├─ main/
│ │ ├─ java/org/example/iotplatform/
│ │ │ ├─ controller/
│ │ │ │ ├─ HelloServlet.java
│ │ │ │ └─ IoTSensorControllerServlet.java
│ │ │ ├─ dao/
│ │ │ │ ├─ SensorReadingDAO.java
│ │ │ │ └─ InMemorySensorReadingDAO.java
│ │ │ ├─ model/
│ │ │ │ └─ SensorReading.java
│ │ │ └─ service/
│ │ │ └─ IoTSensorManagerService.java
│ │ └─ webapp/
│ │ ├─ index.html # page d’accueil stylée
│ │ └─ WEB-INF/views/iot-dashboard.jsp
└─ target/ (généré par Maven)
