<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editează Proiect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; border-radius: 10px; }
        .form-label { font-weight: bold; color: #495057; }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Editare Proiect</span>
            <div class="d-flex gap-2">
                <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
                <a href="modifica_Proiect.jsp" class="btn btn-outline-light btn-sm">Înapoi la tabel</a>
            </div>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <%
        String[] s = request.getParameterValues("primarykey");
        
        if (s == null) {
        %>
            <div class="card p-5 text-center">
                <h3 class="text-danger mb-3">⚠️ Nicio selecție!</h3>
                <p class="lead">Vă rugăm să selectați o linie din tabel pentru a face o modificare.</p>
                <a href="modifica_Proiect.jsp" class="btn btn-primary mt-3">Înapoi la tabel</a>
            </div>
        <%
        } else if (s.length > 1) {
        %>
            <div class="card p-5 text-center">
                <h3 class="text-danger mb-3">⚠️ Selecție multiplă!</h3>
                <p class="lead">Vă rugăm să selectați <strong>doar o singură linie</strong> pentru modificare.</p>
                <a href="modifica_Proiect.jsp" class="btn btn-primary mt-3">Înapoi la tabel</a>
            </div>
        <%
        } else {
            jb.connect();
            int aux = java.lang.Integer.parseInt(s[0]);
            ResultSet rs = jb.intoarceLinieDupaId("proiecte", "idproiect", aux);
            rs.first();
            String Nume = rs.getString("nume");
            String Descriere = rs.getString("descriere");
            String TipProiect = rs.getString("tip_proiect");
            String Status = rs.getString("status");
            String DataInceput = rs.getString("data_inceput");
            String Deadline = rs.getString("deadline");
            rs.close();
            jb.disconnect();
        %>
        
        <div class="card p-4">
            <h4 class="text-primary text-center mb-4">Modifică Datele Proiectului</h4>
            
            <form action="m2_Proiect.jsp" method="post">
                
                <div class="mb-3">
                    <label class="form-label">ID Proiect:</label>
                    <input type="text" name="idproiect" class="form-control bg-light" value="<%=aux%>" readonly />
                </div>

                <div class="mb-3">
                    <label class="form-label">Nume Proiect:</label>
                    <input type="text" name="Nume" class="form-control" value="<%= (Nume!=null)?Nume:"" %>" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Descriere:</label>
                    <input type="text" name="Descriere" class="form-control" value="<%= (Descriere!=null)?Descriere:"" %>" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Tip Proiect:</label>
                    <input type="text" name="TipProiect" class="form-control" value="<%= (TipProiect!=null)?TipProiect:"" %>" />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <input type="text" name="Status" class="form-control" value="<%= (Status!=null)?Status:"" %>" placeholder="Ex: Nou, In lucru, Finalizat" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Data Început (YYYY-MM-DD):</label>
                    <input type="text" name="DataInceput" class="form-control" value="<%= (DataInceput!=null)?DataInceput:"" %>" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Deadline (YYYY-MM-DD):</label>
                    <input type="text" name="Deadline" class="form-control" value="<%= (Deadline!=null)?Deadline:"" %>" />
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-warning text-dark fw-bold">
                        💾 Salvează Modificările
                    </button>
                    <a href="modifica_Proiect.jsp" class="btn btn-secondary">Anulează</a>
                </div>

            </form>
        </div>
        <%
        }
        %>
    </div>

    <br><br>
</body>
</html>