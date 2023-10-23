<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>   
<%@ page import ="vo.Board" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardTitle = request.getParameter("boardTitle");
	String boardPw = request.getParameter("boardPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT board_no boardNo, board_title boardTitle, board_pw boardPw FROM board WHERE board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	
	Board board = null;
	if(rs.next()){
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
		board.boardTitle = rs.getString("boardTitle");
		board.boardPw = rs.getString("boardPw");
	}
	// DB 자원 해제
	rs.close();
	stmt.close();
	conn.close();
%>
<h1>Board 삭제</h1>
	<form action="<%=request.getContextPath() %>/deleteBoardAction.jsp">
		<table border="1">
			<tr>
				<td>board_no</td>
				<td>
					<input type="text" name="boardNo" value="<%=board.boardNo %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>board_title</td>
				<td>
					<input type="text" name="boardTitle" value="<%=board.boardTitle %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>board_pw</td>
				<td>
					<input type="password" name="boardPw">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">삭제</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>