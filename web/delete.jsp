<%-- 
    Document   : delete
    Created on : Oct 20, 2013, 4:03:09 PM
    Author     : Gladston Vidali, Fabio Futigami, Gladston Vidali
--%>
<%@page import="com.progdan.edmis.model.user.User"%>
<%@page import="com.progdan.edmis.control.document.RegisterDocumentControl1"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluindo</title>
    </head>
    <body>
        <%
  if (session.getAttribute("User") == null) {
    String redirectURL = "nologin.jsp";
    response.sendRedirect(redirectURL);
    return;
  }
  User user = (User) session.getAttribute("User");
  RegisterDocumentControl1 document = new RegisterDocumentControl1(user);
  
  document.deleteDoc(session);
    %>
    <p> Documento excluido com sucesso! </p>
    <a href="alldocs.jsp"> Voltar</a>

    </body>
</html>
