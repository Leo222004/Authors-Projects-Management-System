<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ștergere Creație</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; border-radius: 10px; }
        .icon-large { font-size: 3rem; margin-bottom: 1rem; }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <nav class="navbar navbar-dark bg-primary mb-5">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Procesare Ștergere</span>
            <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <%
        String[] s = request.getParameterValues("primarykey");
        if (s == null) {
        %>
            <div class="card p-5 text-center border-warning">
                <div class="icon-large">⚠️</div>
                <h3 class="text-warning mb-3">Nicio selecție!</h3>
                <p class="lead text-muted">Nu ați selectat nicio linie pentru ștergere.</p>
                <div class="mt-4">
                    <a href="tabela_Creatie.jsp" class="btn btn-primary">Înapoi la Tabel</a>
                </div>
            </div>
        <%
        } else {
            jb.connect();
            try {
                jb.stergeDateTabela(s, "creatie", "idcreatie");
                jb.disconnect();
        %>
            <div class="card p-5 text-center border-success">
                <div class="icon-large">🗑️✅</div>
                <h3 class="text-success mb-3">Ștergere reușită!</h3>
                <p class="lead text-muted">
                    <% if (s.length > 1) { %>
                        Liniile selectate au fost șterse cu succes.
                    <% } else { %>
                        Linia selectată a fost ștearsă cu succes.
                    <% } %>
                </p>
                
                <div class="d-grid gap-2 col-8 mx-auto mt-4">
                    <a href="tabela_Creatie.jsp" class="btn btn-primary">Înapoi la Tabela Creație</a>
                    <a href="index.html" class="btn btn-outline-secondary">Mergi Acasă</a>
                </div>
            </div>
        <%
            } catch (Exception e) {
                jb.disconnect();
        %>
            <div class="card p-5 text-center border-danger">
                <div class="icon-large">⛔</div>
                <h3 class="text-danger mb-3">Eroare la ștergere!</h3>
                <p class="text-muted">Nu s-au putut șterge înregistrările selectate.</p>
                
                <div class="alert alert-warning text-start">
                    <strong>Detalii eroare:</strong><br>
                    <%= e.getMessage() %>
                </div>
                
                <div class="mt-4">
                    <a href="tabela_Creatie.jsp" class="btn btn-secondary">Înapoi la Tabel</a>
                </div>
            </div>
        <%
            }
        }
        %>
    </div>
    <br><br>
</body>
</html>