<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));

	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "DELETE FROM student WHERE student_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,studentNo);
	
	int row = stmt.executeUpdate();
	if(row == 1){
		System.out.println("삭제 성공");
	}else{
		System.out.println("삭제 실패");
	}
	response.sendRedirect(request.getContextPath()+"/studentList.jsp");
%>