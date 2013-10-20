<%@page import="com.progdan.edmis.control.document.RegisterDocumentControl1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*"%>
<%@page import="com.progdan.edmis.model.user.User"%>
<%@page import="com.progdan.edmis.control.document.RegisterDocumentControl"%>
<%@page import="com.progdan.edmis.model.document.Document"%>
<%
  Locale currentLocale = request.getLocale();
  ResourceBundle labels = ResourceBundle.getBundle("MessagesBundle", currentLocale);
%>
<HTML>
<HEAD>
<TITLE><%= labels.getString("edmis") %>:
<%= labels.getString("docregister") %></TITLE>
<META http-equiv=content-type content="text/html; charset=iso-8859-1">
<STYLE type=text/css>@import url( styles/htmlarea.css );</STYLE>
<LINK href="styles/styles.css" type=text/css rel=stylesheet>

</HEAD>
<BODY bgColor=#f7f6f1>
<%
  if (session.getAttribute("User") == null) {
    String redirectURL = "nologin.jsp";
    response.sendRedirect(redirectURL);
    return;
  }
  User user = (User) session.getAttribute("User");
  RegisterDocumentControl1 document = new RegisterDocumentControl1(user);
  
  if (document.register(session, request)) {
    %>
    <p> Documento alterado com sucesso! </p>
    <a href="docedit.jsp"> Voltar</a>
    <%
    return;
  }
%>

</BODY>
</HTML>