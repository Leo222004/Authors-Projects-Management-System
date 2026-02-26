<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adaugă Proiect</title>
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
    String Nume = request.getParameter("Nume");
    String Descriere = request.getParameter("Descriere");
    String TipProiect = request.getParameter("TipProiect");
    String Status = request.getParameter("Status");
    String DataInceput = request.getParameter("DataInceput");
    String Deadline = request.getParameter("Deadline");
    
    if (Deadline != null && Deadline.trim().isEmpty()) {
        Deadline = null;
    }

    String dateRegex = "^\\d{4}-\\d{2}-\\d{2}$";

    if (Nume != null && Nume.trim().length() > 0 && 
        DataInceput != null && DataInceput.matches(dateRegex)) {
        
        jb.connect();
        jb.adaugaProiect(Nume, Descriere, TipProiect, Status, DataInceput, Deadline);
        jb.disconnect();
    %>
    
    <div class="container" style="max-width: 600px; margin-top: 50px;">
        <div class="card p-5 text-center border-success">
            <div class="icon-large">✅</div>
            <h3 class="text-success mb-3">Succes!</h3>
            <p class="lead text-muted">Proiectul a fost creat cu succes.</p>
            
            <div class="d-grid gap-2 col-8 mx-auto mt-4">
                <a href="nou_Proiect.jsp" class="btn btn-success">Adaugă alt proiect</a>
                <a href="tabela_Proiecte.jsp" class="btn btn-primary">Vezi Tabela Proiecte</a>
                <a href="index.html" class="btn btn-outline-secondary">Mergi Acasă</a>
            </div>
        </div>
    </div>

    <%
    } else {
    %>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Adăugare Proiect Nou</span>
            <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <div class="card p-4">
            <h4 class="text-primary text-center mb-4">Introduceți detaliile proiectului</h4>

            <% if (Nume != null) { %>
            <div class="alert alert-danger" role="alert">
                <strong>Eroare:</strong> Numele și Data de Început (format YYYY-MM-DD) sunt obligatorii!
            </div>
            <% } %>

            <form action="nou_Proiect.jsp" method="post">
                
                <div class="mb-3">
                    <label class="form-label">Nume Proiect:</label>
                    <input type="text" name="Nume" class="form-control" value="<%= (Nume!=null)?Nume:"" %>" placeholder="Ex: Website E-commerce" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Descriere:</label>
                    <textarea name="Descriere" class="form-control" rows="2" placeholder="Scurtă descriere a proiectului"><%= (Descriere!=null)?Descriere:"" %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Tip Proiect:</label>
                    <input type="text" name="TipProiect" class="form-control" value="<%= (TipProiect!=null)?TipProiect:"" %>" placeholder="Ex: Web Development, Marketing" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <input type="text" name="Status" class="form-control" value="<%= (Status!=null)?Status:"" %>" placeholder="Ex: Nou, In lucru, Finalizat" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Data Început:</label>
                    <input type="text" name="DataInceput" class="form-control" value="<%= (DataInceput!=null)?DataInceput:"" %>" placeholder="YYYY-MM-DD" required />
                    <div class="form-text">Format obligatoriu: An-Luna-Zi (ex: 2024-01-15)</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Deadline (Opțional):</label>
                    <input type="text" name="Deadline" class="form-control" value="<%= (Deadline!=null)?Deadline:"" %>" placeholder="YYYY-MM-DD" />
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-success fw-bold">➕ Adaugă Proiectul</button>
                    <a href="tabela_Proiecte.jsp" class="btn btn-secondary">Renunță / Înapoi</a>
                </div>

            </form>
        </div>
    </div>

    <%
    }
    %>
    <br><br>
</body>
</html>