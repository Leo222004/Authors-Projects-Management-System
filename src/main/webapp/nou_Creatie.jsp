<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adaugă Creație</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; border-radius: 10px; }
        .form-label { font-weight: bold; color: #495057; }
        .icon-large { font-size: 3rem; margin-bottom: 1rem; }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <%
    String id1 = request.getParameter("idautor");
    String id2 = request.getParameter("idproiect");
    String RolAutor = request.getParameter("RolAutor");
    String Remuneratie = request.getParameter("Remuneratie");
    
    if (id1 != null) {
        jb.connect();
        try {
            jb.adaugaCreatie(java.lang.Integer.parseInt(id1), java.lang.Integer.parseInt(id2), RolAutor, Remuneratie);
            jb.disconnect();
    %>
        <div class="container" style="max-width: 600px; margin-top: 50px;">
            <div class="card p-5 text-center border-success">
                <div class="icon-large">✅</div>
                <h3 class="text-success mb-3">Succes!</h3>
                <p class="lead text-muted">Asocierea (Creația) a fost adăugată în baza de date.</p>
                
                <div class="d-grid gap-2 col-8 mx-auto mt-4">
                    <a href="nou_Creatie.jsp" class="btn btn-success">Adaugă altă creație</a>
                    <a href="tabela_Creatie.jsp" class="btn btn-primary">Vezi Tabela Creație</a>
                    <a href="index.html" class="btn btn-outline-secondary">Mergi Acasă</a>
                </div>
            </div>
        </div>
    <%
        } catch (Exception e) {
            jb.disconnect();
    %>
        <div class="container" style="max-width: 600px; margin-top: 50px;">
            <div class="card p-5 text-center border-danger">
                <div class="icon-large">⛔</div>
                <h3 class="text-danger mb-3">Eroare la adăugare!</h3>
                <p class="text-muted">Nu s-a putut salva înregistrarea.</p>
                
                <div class="alert alert-warning text-start">
                    <strong>Cauza posibilă:</strong><br>
                    Această asociere (Autor + Proiect) există deja, sau datele introduse sunt invalide.<br>
                    <em>Detalii: <%= e.getMessage() %></em>
                </div>
                
                <div class="mt-4">
                    <button class="btn btn-warning px-4" onclick="history.back()">⬅️ Corectează Datele</button>
                </div>
            </div>
        </div>
    <%
        }
    } else {
        jb.connect();
        ResultSet rs1 = jb.vedeTabela("autori");
        ResultSet rs2 = jb.vedeTabela("proiecte");
    %>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Adăugare Creație Nouă</span>
            <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <div class="card p-4">
            <h4 class="text-primary text-center mb-4">Asociați un Autor la un Proiect</h4>
            
            <form action="nou_Creatie.jsp" method="post">
                
                <div class="mb-3">
                    <label class="form-label">Selectați Autorul:</label>
                    <select name="idautor" class="form-select" required>
                        <option value="" disabled selected>-- Alegeți din listă --</option>
                        <%
                        while (rs1.next()) {
                            int id = rs1.getInt("idautor");
                            String nume = rs1.getString("nume");
                            String prenume = rs1.getString("prenume");
                            String email = rs1.getString("email");
                        %>
                        <option value="<%=id%>">
                            <%=nume%> <%=prenume%> (ID: <%=id%>) <%= (email!=null && !email.isEmpty()) ? "- " + email : "" %>
                        </option>
                        <%
                        }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Selectați Proiectul:</label>
                    <select name="idproiect" class="form-select" required>
                        <option value="" disabled selected>-- Alegeți din listă --</option>
                        <%
                        while (rs2.next()) {
                            int id = rs2.getInt("idproiect");
                            String nume = rs2.getString("nume");
                            String tip = rs2.getString("tip_proiect");
                        %>
                        <option value="<%=id%>">
                            <%=nume%> - <%=tip%> (ID: <%=id%>)
                        </option>
                        <%
                        }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Rol în proiect:</label>
                    <input type="text" name="RolAutor" class="form-control" placeholder="Ex: Programator, Manager, Editor" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Remunerație (RON):</label>
                    <input type="text" name="Remuneratie" class="form-control" placeholder="Ex: 4500" />
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-success fw-bold">➕ Adaugă Asocierea</button>
                    <a href="tabela_Creatie.jsp" class="btn btn-secondary">Renunță / Înapoi</a>
                </div>
            </form>
        </div>
    </div>

    <%
        rs1.close();
        rs2.close();
        jb.disconnect();
    }
    %>
    <br><br>
</body>
</html>