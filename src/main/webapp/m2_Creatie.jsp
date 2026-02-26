<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rezultat Modificare Creație</title>
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
            <span class="navbar-brand mb-0 h1">Procesare Modificare</span>
            <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <%
        jb.connect();
        int aux = java.lang.Integer.parseInt(request.getParameter("idcreatie"));
        int idautor = java.lang.Integer.parseInt(request.getParameter("idautor"));
        int idproiect = java.lang.Integer.parseInt(request.getParameter("idproiect"));
        String RolAutor = request.getParameter("RolAutor");
        String Remuneratie = request.getParameter("Remuneratie");

        try {
            jb.modificaCreatie(aux, idautor, idproiect, RolAutor, Remuneratie);
            jb.disconnect();
        %>
            <div class="card p-5 text-center border-success">
                <div class="icon-large">✅</div>
                <h3 class="text-success mb-3">Succes!</h3>
                <p class="lead text-muted">Asocierea (Creația) a fost modificată cu succes.</p>
                
                <div class="d-grid gap-2 col-8 mx-auto mt-4">
                    <a href="tabela_Creatie.jsp" class="btn btn-primary">Vezi Tabela Creație</a>
                    <a href="index.html" class="btn btn-outline-secondary">Mergi Acasă</a>
                </div>
            </div>
        <%
        } catch (Exception e) {
            jb.disconnect();
        %>
            <div class="card p-5 text-center border-danger">
                <div class="icon-large">⛔</div>
                <h3 class="text-danger mb-3">Eroare la modificare!</h3>
                <p class="text-muted">Nu s-a putut salva modificarea în baza de date.</p>
                
                <div class="alert alert-warning text-start">
                    <strong>Cauza erorii:</strong><br>
                    <%= e.getMessage() %>
                </div>
                
                <div class="mt-4">
                    <button class="btn btn-warning px-4" onclick="history.back()">⬅️ Corectează Datele</button>
                </div>
            </div>
        <%
        }
        %>
    </div>
    
    <br><br>
</body>
</html>