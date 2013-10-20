<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*"%>
<%
  Locale currentLocale = request.getLocale();
  ResourceBundle labels = ResourceBundle.getBundle("MessagesBundle", currentLocale);
%>
<HTML>
<HEAD>
<TITLE><%= labels.getString("edmis") %>:<%= labels.getString("docupload") %></TITLE>
<META http-equiv=content-type content="text/html; charset=iso-8859-1">
<STYLE type=text/css>
@import url( styles/htmlarea.css );
</STYLE>
<LINK href="styles/styles.css" type=text/css rel=stylesheet>
<style type="text/css">
  <!--
    .style1 {color: #FF0000}
  -->
</style>
</HEAD>
<BODY bgColor=#f7f6f1> 
<%
  if (session.getAttribute("User") == null) {
    String redirectURL = "nologin.jsp";
    response.sendRedirect(redirectURL);
    return;
  }
%> 
<table width="100%" border="0"> 
  <tr> 
    <td>&nbsp;</td> 
    <td width="927"> <!-- #include file="common/header.jsp" --> 
      <jsp:include page="common/header.jsp" flush="true"/> 
      <TABLE cellSpacing=0 cellPadding=3 width="915" border=0> 
        <TBODY> 
          <TR> 
            <TD class=navbar bgColor=#c6bda8> <a href="index.jsp" target=_top><%= labels.getString("edmis") %> </A> &raquo; <a href="home.jsp"><%= labels.getString("home") %></a> &raquo; <%= labels.getString("docupload") %></TD> 
          </TR> 
        </TBODY> 
      </TABLE> 
      <HR noShade SIZE=1> 
      <TABLE cellSpacing=5 cellPadding=5 width="915" border=0> 
        <TBODY> 
          <TR> 
            <TD width="175" align="center" style="VERTICAL-ALIGN: top; WIDTH: 180px"> <!-- #include file="tools.jsp" --> 
              <jsp:include page="tools.jsp" flush="true"/> </TD> 
            <TD style="VERTICAL-ALIGN: top"> <TABLE cellSpacing=0 cellPadding=5 width="100%" border=0> 
                <TBODY> 
                  <TR> 
                    <TD class=headingblock bgColor=#c6bda8><img src="portlets/icons/upload.gif" width="16" height="16" border="0" align="absmiddle"> <%= labels.getString("docupload") %> </TD> 
                  </TR> 
                </TBODY> 
              </TABLE> 
              <IMG height=8 alt="" src="images/spacer.gif" width=1> <BR> 
              <TABLE class=coursebox cellSpacing=0 cellPadding=5 width="100%" align=center border=0> 
                <TBODY> 
                  <TR> 
                    <TD class=courseboxcontent bgColor=#ffffff> <table width="100%"> 
                        <tbody> 
                          <tr valign=top> 
                            <TD class=courseboxsummary vAlign=top> <P> <FONT size=2>&nbsp;</FONT> </P></TD> 
                          </tr> 
                        </tbody> 
                      </table></TD> 
                  </TR> 
                </TBODY> 
              </TABLE> 
              <BR> </TD> 
            <TD width="207" align="center" style="VERTICAL-ALIGN: top; WIDTH: 210px"> <!-- #include file="tools2.jsp" --> 
              <jsp:include page="tools2.jsp" flush="true"/> </TD> 
          </TR> 
        </TBODY> 
      </TABLE> 
      <!-- #include file="common/copyright.jsp" --> 
      <jsp:include page="common/copyright.jsp" flush="true"/> </td> 
    <td>&nbsp;</td> 
  </tr> 
</table> 
</BODY>
</HTML>
