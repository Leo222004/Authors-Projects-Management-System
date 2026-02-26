# Projects and Authors Management - JSP Application

[cite_start]This web application aims to manage the activity of authors and the projects they are involved in[cite: 3]. [cite_start]The system allows CRUD (Create, Read, Update, Delete) operations on the database[cite: 4].

## Main Features
* [cite_start]**Authors Management:** Users can introduce new authors, view the list, modify data, or delete records[cite: 5].
* [cite_start]**Projects Management:** Defining new projects with status, type, and deadline[cite: 5, 34].
* [cite_start]**Associations (Creations):** Associating authors with their respective projects, optionally specifying the role and remuneration for that task[cite: 5].

## Technologies Used
* [cite_start]**Backend:** Java language and JSP (Jakarta Server Pages) technology for backend logic (JavaBean classes)[cite: 8].
* [cite_start]**Database:** MySQL (M:N relationship resolved through the `creatie` junction table)[cite: 13, 18, 19].
* [cite_start]**Connectivity:** JDBC (MySQL Connector/J) for sending SQL queries using `PreparedStatement` for security[cite: 15, 47].
* [cite_start]**Web Server:** Apache Tomcat 11[cite: 12].
* [cite_start]**Development Environment:** Eclipse IDE[cite: 10].

## Database
[cite_start]The application uses three main tables[cite: 20]:
1. [cite_start]`autori` (idautor, nume, prenume, datan, email) [cite: 21, 22, 23, 24, 25, 26]
2. [cite_start]`proiecte` (idproiect, nume, descriere, tip_proiect, status, data_inceput, deadline) [cite: 27, 28, 29, 30, 31, 32, 33, 34]
3. [cite_start]`creatie` - junction table (idcreatie, idautor, idproiect, rol_autor, remuneratie) [cite: 35, 36, 37, 38, 39, 40]