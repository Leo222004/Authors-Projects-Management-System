<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editează Creație</title>
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
            <span class="navbar-brand mb-0 h1">Editare Creație (Asociere)</span>
            <div class="d-flex gap-2">
                <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
                <a href="modifica_Creatie.jsp" class="btn btn-outline-light btn-sm">Înapoi la tabel</a>
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
                <a href="modifica_Creatie.jsp" class="btn btn-primary mt-3">Înapoi la tabel</a>
            </div>
        <%
        } else if (s.length > 1) {
        %>
            <div class="card p-5 text-center">
                <h3 class="text-danger mb-3">⚠️ Selecție multiplă!</h3>
                <p class="lead">Vă rugăm să selectați <strong>doar o singură linie</strong> pentru modificare.</p>
                <a href="modifica_Creatie.jsp" class="btn btn-primary mt-3">Înapoi la tabel</a>
            </div>
        <%
        } else {
            jb.connect();
            int aux = java.lang.Integer.parseInt(s[0]);
            
            ResultSet rs = jb.intoarceCreatieId(aux);
            rs.first();
            int id1 = rs.getInt("idautor");
            int id2 = rs.getInt("idproiect");
            String RolAutor = rs.getString("rol_autor");
            String Remuneratie = rs.getString("remuneratie");
            
            ResultSet rs1 = jb.vedeTabela("autori");
            ResultSet rs2 = jb.vedeTabela("proiecte");
            
            int idautor, idproiect;
            String NumeAutor, Prenume, NumeProiect, TipProiect;
        %>
        
        <div class="card p-4">
            <h4 class="text-primary text-center mb-4">Modifică Datele Asocierii</h4>
            
            <form action="m2_Creatie.jsp" method="post">
                
                <div class="mb-3">
                    <label class="form-label">ID Creație:</label>
                    <input type="text" name="idcreatie" class="form-control bg-light" value="<%=aux%>" readonly />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Autor:</label>
                    <select name="idautor" class="form-select">
                        <%
                        while (rs1.next()) {
                            idautor = rs1.getInt("idautor");
                            NumeAutor = rs1.getString("nume");
                            Prenume = rs1.getString("prenume");
                            
                            if (idautor != id1) {
                        %>
                            <option value="<%=idautor%>"><%=NumeAutor%> <%=Prenume%> (ID: <%=idautor%>)</option>
                        <%
                            } else {
                        %>
                            <option value="<%=idautor%>" selected="selected"><%=NumeAutor%> <%=Prenume%> (ID: <%=idautor%>)</option>
                        <%
                            }
                        }
                        %>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Proiect:</label>
                    <select name="idproiect" class="form-select">
                        <%
                        while (rs2.next()) {
                            idproiect = rs2.getInt("idproiect");
                            NumeProiect = rs2.getString("nume");
                            TipProiect = rs2.getString("tip_proiect");
                            
                            if (idproiect != id2) {
                        %>
                            <option value="<%=idproiect%>"><%=NumeProiect%> - <%=TipProiect%> (ID: <%=idproiect%>)</option>
                        <%
                            } else {
                        %>
                            <option value="<%=idproiect%>" selected="selected"><%=NumeProiect%> - <%=TipProiect%> (ID: <%=idproiect%>)</option>
                        <%
                            }
                        }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Rol Autor:</label>
                    <input type="text" name="RolAutor" class="form-control" value="<%= (RolAutor!=null)?RolAutor:"" %>" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Remunerație:</label>
                    <input type="text" name="Remuneratie" class="form-control" value="<%= (Remuneratie!=null)?Remuneratie:"" %>" placeholder="ex: 5000" />
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-warning text-dark fw-bold">
                        💾 Salvează Modificările
                    </button>
                    <a href="modifica_Creatie.jsp" class="btn btn-secondary">Anulează</a>
                </div>

            </form>
        </div>
        <%
            rs.close();
            rs1.close();
            rs2.close();
            jb.disconnect();
        }
        %>
    </div>

    <br><br>
</body>
</html>