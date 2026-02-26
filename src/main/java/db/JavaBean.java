package db;
import java.sql.*;
public class JavaBean {
	String error;
	Connection con;
	public JavaBean() {
	}
	public void connect() throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/proiecte?useSSL=false","root", "leonard");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect()
	public void connect(String bd) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + bd, "root",
					"leonard");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd)
	public void connect(String bd, String ip) throws ClassNotFoundException, SQLException,
	Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + ip + ":3306/" + bd, "root",
					"leonard");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd, String ip)
	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	} // disconnect()
	public void adaugaAutor(String Nume, String Prenume, String DataNasterii, String Email)
	        throws SQLException, Exception {
	    if (con != null) {
	        try {
	            String query = "INSERT INTO autori(nume, prenume, datan, email) VALUES(?, ?, ?, ?)";
	            PreparedStatement pstmt = con.prepareStatement(query);

	            pstmt.setString(1, Nume);
	            pstmt.setString(2, Prenume);
	            pstmt.setString(3, DataNasterii);
	            pstmt.setString(4, Email);

	            pstmt.executeUpdate();
	            pstmt.close();
	        } catch (SQLException sqle) {
	            error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
	            throw new SQLException(error);
	        }
	    } else {
	        error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
	        throw new Exception(error);
	    }
	} // end of adaugaAutor()
	public void adaugaProiect(String Nume, String Descriere, String TipProiect, String Status, String DataInceput, String Deadline)
			throws SQLException, Exception {
		if (con != null) {
			try {
				// creaza un "prepared SQL statement"
				Statement stmt;
				stmt = con.createStatement();
				String valoareDeadline;
	            if (Deadline == null || Deadline.trim().isEmpty()) {
	                valoareDeadline = "NULL";
	            } else {
	                valoareDeadline = "'" + Deadline + "'";
	            }
				stmt.executeUpdate("insert into proiecte(nume, descriere, tip_proiect, status, data_inceput, deadline) values('" + Nume + "' , '" + Descriere + "', '" + TipProiect + "', '" + Status + "', '" + DataInceput + "', "+ valoareDeadline +");");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaProiect()
	public void adaugaCreatie(int idautor, int idproiect, String RolAutor, String Remuneratie)
					throws SQLException, Exception {
		if (con != null) {
			try {
				Statement stmt;
				stmt = con.createStatement();
				String valRemuneratie;
	            if (Remuneratie == null || Remuneratie.trim().isEmpty()) {
	                valRemuneratie = "NULL";
	            } else {
	                valRemuneratie = "'" + Remuneratie + "'";
	            }
				stmt.executeUpdate("insert into creatie(idautor, idproiect, rol_autor, remuneratie) values('" + idautor + "' , '" + idproiect + "', '" + RolAutor + "', " + valRemuneratie + ");");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate. " + sqle.getMessage();
	            throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaCreatie()
	public ResultSet vedeTabela(String tabel) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select * from `proiecte`.`" + tabel + "`;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeTabela()
	public ResultSet vedeCreatie() throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.nume NumeAutor, a.prenume, a.datan, a.email, p.nume NumeProiect, p.descriere, p.tip_proiect, p.status, p.data_inceput, p.deadline ,c.idcreatie, c.idautor, c.idproiect, c.rol_autor, c.remuneratie from autori a, proiecte p, creatie c where a.idautor = c.idautor and p.idproiect = c.idproiect;");
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeCreatie()
	public void stergeDateTabela(String[] primaryKeys, String tabela, String dupaID) throws
	SQLException, Exception {
		if (con != null) {
			try {
				// creaza un "prepared SQL statement"
				long aux;
				PreparedStatement delete;
				delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
				for (int i = 0; i < primaryKeys.length; i++) {
					aux = java.lang.Long.parseLong(primaryKeys[i]);
					delete.setLong(1, aux);
					delete.execute();
				}
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			} catch (Exception e) {
				error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
				throw new Exception(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeDateTabela()
	public void stergeTabela(String tabela) throws SQLException, Exception {
		if (con != null) {
			try {
				// creaza un "prepared SQL statement"
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("delete from " + tabela + ";");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Stergere nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeTabela()
	public void modificaTabela(String tabela, String IDTabela, int ID, String[] campuri, String[] valori) throws SQLException, Exception {
		String update = "update " + tabela + " set ";
		String temp = "";
		if (con != null) {
			try {
				for (int i = 0; i < campuri.length; i++) {
					if (i != (campuri.length - 1)) {
						temp = temp + campuri[i] + "='" + valori[i] + "', ";
					} else {
						temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + "= '" + ID + "';";
					}
				}
				update = update + temp;
				// creaza un "prepared SQL statement"
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate(update);
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of modificaTabela()
	public void modificaProiect(int id, String Nume, String Descriere, String TipProiect, String Status, String DataInceput, String Deadline)
	        throws SQLException, Exception {
	    if (con != null) {
	        try {
	            Statement stmt = con.createStatement();
	            
	            String valDataInceput;
	            if (DataInceput == null || DataInceput.trim().isEmpty() || DataInceput.equals("null")) {
	                valDataInceput = "NULL";
	            } else {
	                valDataInceput = "'" + DataInceput + "'";
	            }

	            String valDeadline;
	            if (Deadline == null || Deadline.trim().isEmpty() || Deadline.equals("null")) {
	                valDeadline = "NULL";
	            } else {
	                valDeadline = "'" + Deadline + "'";
	            }

	            String sql = "UPDATE proiecte SET " +
	                    "nume='" + Nume + "', " +
	                    "descriere='" + Descriere + "', " +
	                    "tip_proiect='" + TipProiect + "', " +
	                    "status='" + Status + "', " +
	                    "data_inceput=" + valDataInceput + ", " +
	                    "deadline=" + valDeadline + " " +
	                    "WHERE idproiect=" + id;
	            
	            stmt.executeUpdate(sql);
	            
	        } catch (SQLException sqle) {
	            error = "ExceptieSQL: Reactualizare nereusita. " + sqle.getMessage();
	            throw new SQLException(error);
	        }
	    } else {
	        error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
	        throw new Exception(error);
	    }
	} //end of modificaProiect()
	public void modificaCreatie(int idcreatie, int idautor, int idproiect, String RolAutor, String Remuneratie)
	        throws SQLException, Exception {
	    if (con != null) {
	        try {
	            Statement stmt = con.createStatement();
	            String valRemuneratie;
	            if (Remuneratie == null || Remuneratie.trim().isEmpty()) {
	                valRemuneratie = "NULL";
	            } else {
	                valRemuneratie = "'" + Remuneratie + "'";
	            }
	            String sql = "UPDATE creatie SET " +
	                         "idautor=" + idautor + ", " +
	                         "idproiect=" + idproiect + ", " +
	                         "rol_autor='" + RolAutor + "', " +
	                         "remuneratie=" + valRemuneratie + " " +
	                         "WHERE idcreatie=" + idcreatie + ";";
	            
	            stmt.executeUpdate(sql);
	        } catch (SQLException sqle) {
	            error = "ExceptieSQL: Reactualizare nereusita. " + sqle.getMessage();
	            throw new SQLException(error);
	        }
	    } else {
	        error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
	        throw new Exception(error);
	    }
	}
	public ResultSet intoarceLinie(String tabela, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Executa interogarea
			String queryString = ("SELECT * FROM " + tabela + " where idautor=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinie()
	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, int ID) throws
	SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID
					+ ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()
	public ResultSet intoarceCreatieId(int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.nume NumeAutor, a.prenume, a.datan, a.email, p.nume NumeProiect, p.descriere, p.tip_proiect, p.status, p.data_inceput, p.deadline ,c.idcreatie, c.idautor, c.idproiect, c.rol_autor, c.remuneratie from autori a, proiecte p, creatie c WHERE a.idautor = c.idautor AND p.idproiect = c.idproiect AND idcreatie = '" + ID + "';");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceCreatieId()
}