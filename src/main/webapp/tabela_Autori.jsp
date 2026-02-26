<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabela Autori</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; border-radius: 10px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; }
        .btn-custom { border-radius: 5px; }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Gestiune Autori</span>
            <div class="d-flex gap-2">
                <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="card p-4">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="text-primary">Lista Autori</h3>
                <a href="nou_Autor.jsp" class="btn btn-success btn-custom">
                    <strong>+</strong> Adaugă Autor Nou
                </a>
            </div>

            <form action="sterge_Autor.jsp" method="post">
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th style="width: 50px;">Select</th>
                                <th>ID</th>
                                <th>Nume</th>
                                <th>Prenume</th>
                                <th>Data Nașterii</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            jb.connect();
                            ResultSet rs = jb.vedeTabela("autori");
                            long x;
                            while (rs.next()) {
                                x = rs.getInt("idautor");
                            %>
                            <tr>
                                <td class="text-center">
                                    <input type="checkbox" name="primarykey" value="<%=x%>" class="form-check-input" style="border: 1px solid #999; cursor: pointer;">
                                </td>
                                <td class="text-center fw-bold"><%=x%></td>
                                <td><%=rs.getString("nume")%></td>
                                <td><%=rs.getString("prenume")%></td>
                                <td class="text-center"><%=rs.getString("datan")%></td>
                                <td><%= (rs.getString("email") != null) ? rs.getString("email") : "-" %></td>
                            </tr>
                            <%
                            }
                            rs.close();
                            jb.disconnect();
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-3 border-top pt-3">
                    <span class="text-muted small">* Selectați casuțele pentru a șterge înregistrări.</span>
                    <button type="submit" class="btn btn-danger btn-custom">
                        🗑️ Șterge Liniile Marcate
                    </button>
                </div>
            </form>

        </div> </div> <br><br>
</body>
</html>