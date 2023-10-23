<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>   
<%@ page import ="vo.Board" %> 
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String boardPw = request.getParameter("boardPw");
	String createdate = request.getParameter("createdate");
	String updatedate = request.getParameter("updatedate");
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter, board_pw boardPW, createdate, updatedate FROM board WHERE board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	
	Board board = null;
	if(rs.next()){
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
		board.boardTitle = rs.getString("boardTitle");
		board.boardContent = rs.getString("boardContent");
		board.boardWriter = rs.getString("boardWriter");
		board.boardPw = rs.getString("boardPw");
		board.createdate = rs.getString("createdate");
		board.updatedate = rs.getString("updatedate");
	}
	// DB 자원 해제
	rs.close();
	stmt.close();
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<div class="container-fluid">
	<h1 class="text-bg-secondary">Board 수정</h1>
		<form action="<%=request.getContextPath() %>/updateBoardAction.jsp">
			<table class="table table-bordered table-hover">
				<tr>
					<th>board_no</th>
					<td>
						<input type="text" name="boardNo" value="<%=board.boardNo %>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>board_title</th>
					<td>
						<input type="text" name="boardTitle" value="<%=board.boardTitle %>">
					</td>
				</tr>
				<tr>
					<th>board_content</th>
					<td>
						<textarea rows="8" cols=30 name="boardContent"><%=board.boardContent%></textarea>
					</td>
				</tr>
				<tr>
					<th>board_writer</th>
					<td>
						<input type="text" name="boardWriter" value="<%=board.boardWriter %>">
					</td>
				</tr>
				<tr>
					<th>board_pw</th>
					<td>
						<input type="password" name="boardPw">	<!-- pw를 입력해야지만 다음 실행 가능하도록 값을 넣지 않음 -->
					</td>
				</tr>
				<tr>
					<th>createdate</th>
					<td><%=board.createdate %></td>
				</tr>
				<tr>
					<th>updatedate</th>
					<td><%=board.updatedate %></td>
				</tr>
			</table>
			<div>
				<button type="submit" class="btn btn-secondary">수정</button>
			</div>
		</form>
</div>
</body>
</html>