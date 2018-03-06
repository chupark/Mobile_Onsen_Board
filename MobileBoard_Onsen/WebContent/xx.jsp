<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");
String url = "";
String succ = "N";

if ("dano".equals(id)) {
url = "b.jsp";
succ = "Y";
}
%>
<%=succ%>