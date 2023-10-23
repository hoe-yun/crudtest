<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,boardNo);
	stmt.setString(2, boardPw);
	
	
	
	int row = stmt.executeUpdate();
	// DB 자원 해제
		stmt.close();
		conn.close();
		
	if(row == 1){
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+ "/boardList.jsp");
	}else{
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+ "/deleteBoardForm.jsp?boradNo="+boardNo); // 실패 시 이전으로
	}
%>