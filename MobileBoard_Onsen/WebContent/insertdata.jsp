<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
String title = request.getParameter("title");
String content = request.getParameter("content");

Connection conn = null;
Statement stmt = null;
ResultSet rset = null;
String sql = "";

try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
	stmt = conn.createStatement();
	
	content.replaceAll("\r\n", "<br>");
	
	sql = "INSERT INTO D_BOARD VALUES ((SELECT MAX(NUM) + 1 FROM D_BOARD), '익명', "+
	" '"+title+"', '"+content+"', 0, SYSTIMESTAMP)";
	
	stmt.execute(sql);
	
	if (conn != null){conn.close();}
	if (stmt != null){stmt.close();}
	if (rset != null){rset.close();}
	
}catch (Exception e){
	out.println(e);
} finally {
	if (conn != null){conn.close();}
	if (stmt != null){stmt.close();}
	if (rset != null){rset.close();}
}


String url = "";
String succ = "N";
url = "b.jsp";
succ = "Y";



%>

<%=succ%>

