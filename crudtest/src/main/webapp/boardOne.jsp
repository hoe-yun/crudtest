<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.Board" %>
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
<% 
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	String url="jdbc:mariadb://localhost:3306/gdj72";
	String dbuser= "root";
	String dbpw= "java1234";
	
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT board_no boardNo, board_title boardTitle, board_content boardContent, board_writer boardWriter, board_pw boardPW, createdate, updatedate FROM board WHERE board_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	
	ArrayList<Board> list = new ArrayList<Board>();
	while(rs.next()){
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.boardTitle = rs.getString("boardTitle");
		b.boardContent = rs.getString("boardContent");
		b.boardWriter = rs.getString("boardWriter");
		b.boardPw = rs.getString("boardPw");
		b.createdate = rs.getString("createdate");
		b.updatedate = rs.getString("updatedate");
		list.add(b);
	}
	//DB 자원 해제 (반납)
	rs.close();
	stmt.close();
	conn.close();
%>
<div class="container-fluid">
	<h1 class="text-bg-secondary">Board 상세정보</h1>
	<table class="table table-bordered table-hover">
			<%
				for(Board b : list) {
			%>
					<tr>
						<th>board_no</th>
						<td><%=b.boardNo%></td>
					</tr>
					<tr>
						<th>board_title</th>
						<td><%=b.boardTitle%></td>
					</tr>
					<tr>
						<th>board_content</th>
						<td><textarea rows="8" cols=30 readonly="readonly"><%=b.boardContent%></textarea></td>
						</tr>
					<tr>
						<th>board_writer</th>
						<td><%=b.boardWriter%></td>
					</tr>
					<tr>
						<th>board_pw</th>
						<td><input type="password" name="b.boardPw" value="<%=b.boardPw%>" readonly="readonly"></td> <!-- 리스트에서 pw가 보이지 않도록 password 타입 사용하고 readonly -->
					</tr>
					<tr>
						<th>createdate</th>
						<td><%=b.createdate%></td>
					</tr>
					<tr>
						<th>updatedate</th>
						<td><%=b.updatedate%></td>
					</tr>
					
			<%		
				}
			%>
		</tbody>
	</table>	
	<div>	
		<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=boardNo%>" class="btn btn-secondary">수정</a>
		<a href="<%=request.getContextPath()%>/deleteBoardForm.jsp?boardNo=<%=boardNo%>" class="btn btn-secondary">삭제</a>		
		<a href="<%=request.getContextPath()%>/boardList.jsp" class="btn btn-secondary">뒤로</a>
	</div>
</div>
</body>
</html>