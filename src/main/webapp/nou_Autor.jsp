<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adaugă Autor</title>
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
	String Prenume = request.getParameter("Prenume");
	String DataNasterii = request.getParameter("DataNasterii");
	String Email = request.getParameter("Email");

	String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[a-z]{2,}$";
	String dateRegex = "^\\d{4}-\\d{2}-\\d{2}$";
    
    boolean success = false;
    String sqlError = null;

	if (Nume != null && Nume.trim().length() > 0 && 
		Prenume != null && Prenume.trim().length() > 0 && 
		DataNasterii != null && DataNasterii.matches(dateRegex) && 
		(Email == null || Email.trim().isEmpty() || Email.matches(emailRegex))) {

		if (Email != null && Email.trim().isEmpty()) {
			Email = null;
		}

		jb.connect();
        try {
		    jb.adaugaAutor(Nume, Prenume, DataNasterii, Email);
            success = true;
        } catch (java.sql.SQLException e) {
            sqlError = "Eroare la baza de date: " + e.getMessage();
        }
		jb.disconnect();
    }
	if (success) {
	%>
    
    <div class="container" style="max-width: 600px; margin-top: 50px;">
        <div class="card p-5 text-center border-success">
            <div class="icon-large">✅</div>
            <h3 class="text-success mb-3">Succes!</h3>
            <p class="lead text-muted">Autorul a fost adăugat în baza de date.</p>
            
            <div class="d-grid gap-2 col-8 mx-auto mt-4">
                <a href="nou_Autor.jsp" class="btn btn-success">Adaugă alt autor</a>
                <a href="tabela_Autori.jsp" class="btn btn-primary">Vezi Tabela Autori</a>
                <a href="index.html" class="btn btn-outline-secondary">Mergi Acasă</a>
            </div>
        </div>
    </div>

	<%
	} else {
	%>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Adăugare Autor Nou</span>
            <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <div class="card p-4">
            <h4 class="text-primary text-center mb-4">Introduceți datele autorului</h4>

            <%
            if (Nume != null && sqlError == null) {
            %>
            <div class="alert alert-danger" role="alert">
                <strong>Eroare Validare:</strong> Numele, Prenumele și Data Nașterii (format YYYY-MM-DD) sunt obligatorii. Email-ul (dacă e completat) trebuie să fie valid!
            </div>
            <%
            }
            if (sqlError != null) {
            %>
             <div class="alert alert-warning border-danger text-danger" role="alert">
                <strong><%= sqlError %></strong><br>
                Verificați dacă acest autor sau acest email nu există deja.
            </div>
            <%
            }
            %>

            <form action="nou_Autor.jsp" method="post">
                
                <div class="mb-3">
                    <label class="form-label">Nume Autor:</label>
                    <input type="text" name="Nume" class="form-control" value="<%= (Nume != null) ? Nume : "" %>" placeholder="Ex: Popescu" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Prenume Autor:</label>
                    <input type="text" name="Prenume" class="form-control" value="<%= (Prenume != null) ? Prenume : "" %>" placeholder="Ex: Ion" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Data Nașterii:</label>
                    <input type="text" name="DataNasterii" class="form-control" value="<%= (DataNasterii != null) ? DataNasterii : "" %>" placeholder="YYYY-MM-DD" required />
                    <div class="form-text">Format obligatoriu: An-Luna-Zi (ex: 1980-05-25)</div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email (Opțional):</label>
                    <input type="text" name="Email" class="form-control" value="<%= (Email != null) ? Email : "" %>" placeholder="nume@exemplu.com" />
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-success fw-bold">➕ Adaugă Autorul</button>
                    <a href="tabela_Autori.jsp" class="btn btn-secondary">Renunță / Înapoi</a>
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