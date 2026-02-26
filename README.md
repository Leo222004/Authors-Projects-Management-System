# Projects and Authors Management - JSP Application

This web application aims to manage the activity of authors and the projects they are involved in. The system allows CRUD (Create, Read, Update, Delete) operations on the database.

## Main Features
* **Authors Management:** Users can introduce new authors, view the list, modify data, or delete records.
* **Projects Management:** Defining new projects with status, type, and deadline.
* **Associations (Creations):** Associating authors with their respective projects, optionally specifying the role and remuneration for that task.

## Technologies Used
* **Backend:** Java language and JSP (Jakarta Server Pages) technology for backend logic (JavaBean classes).
* **Database:** MySQL (M:N relationship resolved through the `creatie` junction table).
* **Connectivity:** JDBC (MySQL Connector/J) for sending SQL queries using `PreparedStatement` for security.
* **Web Server:** Apache Tomcat 11.
* **Development Environment:** Eclipse IDE.

## Database
The application uses three main tables:
1. `autori` (idautor, nume, prenume, datan, email)
2. `proiecte` (idproiect, nume, descriere, tip_proiect, status, data_inceput, deadline)
3. `creatie` - junction table (idcreatie, idautor, idproiect, rol_autor, remuneratie)
