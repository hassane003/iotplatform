<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <title>Tableau de bord IoT</title>
  <style>
    :root{
      --bg:#0b1220; --panel:#121b2c; --panel2:#0f1726; --text:#f5f7ff; --muted:#b8c2d9;
      --acc:#28d1ff; --acc2:#8efcff; --ok:#22c55e; --warn:#f59e0b; --border:#20304d;
    }
    *{box-sizing:border-box}
    body{margin:0; font-family:Inter,Segoe UI,Arial,sans-serif; background:radial-gradient(1200px 600px at 20% -10%, #13315c33, transparent),
                               radial-gradient(900px 500px at 120% 10%, #0ea5e933, transparent),
                               var(--bg); color:var(--text);}
    .wrap{max-width:1100px; margin:40px auto; padding:0 20px;}
    header{display:flex; align-items:center; gap:12px; margin-bottom:16px;}
    .chip{background:#0ea5e91a; border:1px solid #0ea5e966; color:#8efcff; padding:4px 10px; border-radius:999px; font-size:12px}
    h1{margin:8px 0 6px; font-weight:800; letter-spacing:.3px; font-size:36px}
    .sub{color:var(--muted); font-size:14px}
    /* Cartes */
    .grid{display:grid; grid-template-columns:1fr 1fr; gap:22px; margin-top:18px}
    .card{background:linear-gradient(180deg, var(--panel), var(--panel2));
          border:1px solid var(--border); border-radius:16px; padding:18px; box-shadow:0 8px 28px #0006;}
    .card h2{margin:0 0 8px; font-size:22px}
    .muted{color:var(--muted); font-size:13px}
    .btn{display:inline-block; margin-top:10px; padding:12px 16px; border-radius:12px; border:1px solid #33e0ff66;
         background:linear-gradient(180deg,#1b2a41,#13233b); color:var(--text); text-decoration:none; font-weight:600}
    .btn:hover{transform:translateY(-1px); box-shadow:0 10px 20px #0005;}
    /* Form */
    form{display:grid; grid-template-columns:repeat(3,1fr); gap:10px; background:#0e1730; border:1px solid var(--border);
         border-radius:14px; padding:14px; margin:14px 0 18px}
    input,select,button{padding:10px 12px; border-radius:10px; border:1px solid #2a3b5e; background:#0b1430; color:var(--text)}
    button{cursor:pointer; background:linear-gradient(180deg,#0ea5e9,#0284c7); border:0; font-weight:700}
    button:hover{filter:brightness(1.05)}
    /* Table */
    .table-wrap{border:1px solid var(--border); border-radius:14px; overflow:hidden; background:#0b1430;}
    table{width:100%; border-collapse:collapse}
    thead th{position:sticky; top:0; background:#0d1a30; color:#d7e1ff; font-weight:700; text-align:left; padding:10px; border-bottom:1px solid var(--border)}
    tbody td{padding:10px; border-bottom:1px solid #152243}
    tbody tr:nth-child(odd){background:#0e1833}
    .stat{font-size:13px; color:var(--muted); margin:8px 0 0}
    .empty{padding:14px; color:var(--muted)}
    footer{margin:28px 0 10px; color:var(--muted); font-size:13px; text-align:center}
    @media (max-width:900px){ .grid{grid-template-columns:1fr} form{grid-template-columns:1fr 1fr} }
    @media (max-width:600px){ form{grid-template-columns:1fr} }
  </style>
</head>
<body>
  <div class="wrap">
    <header>
      <span class="chip">IoT Platform • Tomcat 10</span>
    </header>
    <h1>Tableau de bord IoT</h1>
    <p class="sub">Formulaire d’ingestion + liste des mesures (Servlet + JSP + JSTL).</p>

    <div class="grid">
      <div class="card">
        <h2>Ingestion de mesures</h2>
        <p class="muted">Renseigne un capteur puis envoie une nouvelle mesure.</p>
        <form method="post" action="${pageContext.request.contextPath}/iot-dashboard">
          <input name="sensorId"   placeholder="Sensor ID" required />
          <select name="sensorType" required>
            <option value="">Type…</option>
            <option>TEMPERATURE</option><option>HUMIDITY</option>
            <option>PRESSURE</option><option>CO2</option>
          </select>
          <input name="value" placeholder="Valeur (ex: 23.5)" required />
          <input name="unit" placeholder="Unité (°C, %, hPa, ppm)" required />
          <input name="location" placeholder="Emplacement (ex: Atelier 1)" required />
          <button type="submit">Ingest</button>
        </form>
        <p class="stat">
          Total mesures : <strong>${fn:length(readings)}</strong>
          <c:if test="${fn:length(readings) > 0}"> • Dernières d’abord.</c:if>
        </p>
      </div>

      <div class="card">
        <h2>Raccourcis</h2>
        <p class="muted">Outils rapides.</p>
        <a class="btn" href="${pageContext.request.contextPath}/hello">Tester /hello</a>
      </div>
    </div>

    <div class="table-wrap" style="margin-top:18px">
      <c:choose>
        <c:when test="${empty readings}">
          <div class="empty">Aucune mesure pour l’instant. Utilise le formulaire ci-dessus.</div>
        </c:when>
        <c:otherwise>
          <table>
            <thead>
              <tr>
                <th>ReadingId</th><th>SensorId</th><th>Type</th>
                <th>Valeur</th><th>Unité</th><th>Location</th><th>Timestamp</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${readings}">
              <tr>
                <td>${r.readingId}</td>
                <td>${r.sensorId}</td>
                <td>${r.sensorType}</td>
                <td>${r.value}</td>
                <td>${r.unit}</td>
                <td>${r.location}</td>
                <td>${r.timestamp}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>

    <footer>
      Réalisé par <strong>Hassane EL FAKIR</strong>, <strong>Saad RAISS</strong>, <strong>Mehdi EL YOUBI RMICH</strong> et <strong>Maher EL OUALY</strong>.
    </footer>
  </div>
</body>
</html>
