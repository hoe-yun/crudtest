<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo"));
	String studentName = request.getParameter("studentName");
	String studentBirth = request.getParameter("studentBirth");
	String teamNo = request.getParameter("teamNo");
	String createdate = request.getParameter("createdate");
	String updatedate = request.getParameter("updatedate");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	
	String sql = "UPDATE student SET student_name = ?, student_birth = ?, team_no = ?, updatedate = NOW() WHERE student_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, studentName);
	stmt.setString(2, studentBirth);
	stmt.setString(3, teamNo);
	stmt.setInt(4, studentNo);
	
	int row = stmt.executeUpdate();
	if (row == 1){
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/studentOne.jsp?studentNo="+studentNo);
	}else{
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/updatestudentForm.jsp?studentNo="+studentNo);
	}
%>