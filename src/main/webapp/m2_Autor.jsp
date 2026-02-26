<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rezultat Modificare Autor</title>
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
        int aux = java.lang.Integer.parseInt(request.getParameter("idautor"));
        String Nume = request.getParameter("Nume");
        String Prenume = request.getParameter("Prenume");
        String DataNasterii = request.getParameter("DataNasterii");
        String Email = request.getParameter("Email");
        String eroareCampuri = "";
        if (Nume == null || Nume.trim().isEmpty()) {
            eroareCampuri += "<li>Numele este obligatoriu.</li>";
        }
        if (Prenume == null || Prenume.trim().isEmpty()) {
            eroareCampuri += "<li>Prenumele este obligatoriu.</li>";
        }
        if (DataNasterii == null || DataNasterii.trim().isEmpty()) {
            eroareCampuri += "<li>Data nașterii este obligatorie.</li>";
        }
        if (!eroareCampuri.isEmpty()) {
            jb.disconnect();
        %>
            <div class="card p-5 text-center border-danger">
                <div class="icon-large">⚠️</div>
                <h3 class="text-danger mb-3">Date incomplete!</h3>
                <div class="alert alert-danger text-start d-inline-block">
                    <ul class="mb-0">
                        <%= eroareCampuri %>
                    </ul>
                </div>
                <div class="mt-4">
                    <button class="btn btn-secondary px-4" onclick="history.back()">⬅️ Înapoi la formular</button>
                </div>
            </div>
        <%
        } else {
            if (Email != null && Email.trim().isEmpty()) {
                Email = null;
            }

            String[] valori = { Nume, Prenume, DataNasterii, Email };
            String[] campuri = { "nume", "prenume", "datan", "email" };
            
            try {
                jb.modificaTabela("autori", "idautor", aux, campuri, valori);
                jb.disconnect();
                %>
                <div class="card p-5 text-center border-success">
                    <div class="icon-large">✅</div>
                    <h3 class="text-success mb-3">Succes!</h3>
                    <p class="lead text-muted">Datele autorului au fost actualizate cu succes.</p>
                    
                    <div class="d-grid gap-2 col-8 mx-auto mt-4">
                        <a href="tabela_Autori.jsp" class="btn btn-primary">Vezi Tabela Autori</a>
                        <a href="index.html" class="btn btn-outline-secondary">Mergi Acasă</a>
                    </div>
                </div>
            <%
            } catch (java.sql.SQLException e) {
                jb.disconnect();
            %>
                <div class="card p-5 text-center border-danger">
                    <div class="icon-large">⛔</div>
                    <h3 class="text-danger mb-3">Eroare la modificare!</h3>
                    <p class="text-muted">Nu s-a putut salva modificarea în baza de date.</p>
                    
                    <div class="alert alert-warning">
                        <strong>Cauza posibilă:</strong><br>
                        Adresa de email <b><%= (Email!=null)?Email:"-" %></b> există deja la un alt autor sau formatul datei este incorect.
                    </div>
                    
                    <div class="mt-4">
                        <button class="btn btn-warning px-4" onclick="history.back()">⬅️ Corectează Datele</button>
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