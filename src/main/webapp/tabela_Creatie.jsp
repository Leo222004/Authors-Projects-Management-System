<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabela Creatie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; border-radius: 10px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; }
        .table { font-size: 0.9rem; }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1 ps-3">Gestiune Creație</span>
            <div class="d-flex gap-2 pe-3">
                <a href="index.html" class="btn btn-light btn-sm">🏠 Acasă</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-4">
        <div class="card p-4">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="text-primary">Tabela Creație</h3>
                <a href="nou_Creatie.jsp" class="btn btn-success">
                    <strong>+</strong> Adaugă o nouă creație
                </a>
            </div>

            <form action="sterge_Creatie.jsp" method="post">
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered align-middle">
                        <thead class="table-dark text-center text-nowrap">
                            <tr>
                                <th>Mark</th>
                                <th>IdCreatie</th>
                                <th>IdAutor</th>
                                <th>NumeAutor</th>
                                <th>PrenumeAutor</th>
                                <th>DataNasterii</th>
                                <th>Email</th>
                                <th>IdProiect</th>
                                <th>NumeProiect</th>
                                <th>Descriere</th>
                                <th>TipProiect</th>
                                <th>Status</th>
                                <th>DataInceput</th>
                                <th>Deadline</th>
                                <th>RolAutor</th>
                                <th>Remuneratie</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            jb.connect();
                            ResultSet rs = jb.vedeCreatie();
                            long x;
                            while (rs.next()) {
                                x = rs.getInt("idcreatie");
                            %>
                            <tr>
                                <td class="text-center">
                                    <input type="checkbox" name="primarykey" value="<%=x%>" class="form-check-input" style="border: 1px solid #999; cursor: pointer;">
                                </td>
                                <td class="text-center fw-bold"><%=x%></td>
                                <td class="text-center"><%=rs.getInt("idautor")%></td>
                                <td><%=rs.getString("NumeAutor")%></td>
                                <td><%=rs.getString("prenume")%></td>
                                <td><%=rs.getString("datan")%></td>
                                <td><%= (rs.getString("email")!=null) ? rs.getString("email") : "" %></td>
                                <td class="text-center"><%=rs.getInt("idproiect")%></td>
                                <td><%=rs.getString("NumeProiect")%></td>
                                <td><%= (rs.getString("descriere")!=null) ? rs.getString("descriere") : "" %></td>
                                <td><%=rs.getString("tip_proiect")%></td>
                                <td><span class="badge bg-secondary"><%=rs.getString("status")%></span></td>
                                <td><%=rs.getString("data_inceput")%></td>
                                <td><%= (rs.getString("deadline")!=null) ? rs.getString("deadline") : "" %></td>
                                <td><%=rs.getString("rol_autor")%></td>
                                <td><%= (rs.getString("remuneratie")!=null) ? rs.getString("remuneratie") : "" %></td>
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
                    <button type="submit" class="btn btn-danger">
                        🗑️ Șterge liniile marcate
                    </button>
                </div>
            </form>

        </div>
    </div>

    <br><br>
</body>
</html>