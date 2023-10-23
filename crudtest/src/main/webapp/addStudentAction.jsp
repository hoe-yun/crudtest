<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String studentName = request.getParameter("studentName");
	String studentBirth = request.getParameter("studentBirth");
	int teamNo = Integer.parseInt(request.getParameter("teamNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이브 로딩 성공");
	String url = "jdbc:mariadb://localhost:3306/gdj72";
	String dbuser = "root";
	String dbpw = "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	System.out.println("DB접속 성공");
	
	String sql = "INSERT INTO student(student_name,student_birth,team_no,createdate,updatedate) VALUES (?,?,?,NOW(),NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,studentName);
	stmt.setString(2,studentBirth);
	stmt.setInt(3,teamNo);
	
	int row = stmt.executeUpdate();
	if(row == 1){
		System.out.println("추가 성공");
		response.sendRedirect(request.getContextPath()+"/studentList.jsp");
	}else{
		System.out.println("추가 실패");
		response.sendRedirect(request.getContextPath()+"/addStudentForm.jsp");
	}
	//db 반납
	stmt.close();
	conn.close();
%>