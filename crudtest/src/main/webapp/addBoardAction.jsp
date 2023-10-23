<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String boardPw = request.getParameter("boardPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "INSERT INTO board(board_title,board_content,board_writer,board_pw,createdate,updatedate) values(?,?,?,?,NOW(),NOW())";   // 값에 한에서 ?(변수를 입력)가능
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,boardTitle);
	stmt.setString(2,boardContent);	
	stmt.setString(3,boardWriter);
	stmt.setString(4,boardPw);
	
	int row = stmt.executeUpdate();	
	stmt.close();
	conn.close();
	if(row==1){
		response.sendRedirect(request.getContextPath()+ "/boardList.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+ "/addboardForm.jsp"); // 실패 시 이전으로
	}
	
%>