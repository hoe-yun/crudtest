<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%
	String teamName = request.getParameter("teamName");
	String teamCount = request.getParameter("teamCount"); // int 값으로 받고 싶으면 int teamCount = Integer.parseInt(request.getParameter("teamCount"));
	String teamBegin = request.getParameter("teamBegin");
	String teamEnd = request.getParameter("teamEnd");
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "INSERT INTO team(team_name,team_count,team_begin,team_end,createdate,updatedate) values(?,?,?,?,NOW(),NOW())";   // 값에 한에서 ?(변수를 입력)가능
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,teamName);
	stmt.setString(2,teamCount);	//int값으로 받았으면 stmt.setInt(2,teamCount);
	stmt.setString(3,teamBegin);
	stmt.setString(4,teamEnd);
	System.out.println(stmt+"<--stmt");	//디버깅
	int row = stmt.executeUpdate();		//디버깅(실패 시 재요청 기능 추가 가능)
	if(row==1){
		System.out.println("입력 성공");
	}else{
		System.out.println("입력 실패");
	}
	stmt.close();
	conn.close();
	
	
	//리다이렉션 
	response.sendRedirect(request.getContextPath()+ "/teamList.jsp");
%>
