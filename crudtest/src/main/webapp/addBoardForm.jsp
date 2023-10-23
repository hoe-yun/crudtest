<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Board 추가</h1>
	<form action="<%=request.getContextPath() %>/addBoardAction.jsp">
		<table border="1">
			<tr>
				<td>board_title</td>
				<td>
					<input type="text" name="boardTitle">
				</td>
			</tr>
			<tr>
				<td>board_content</td>
				<td>
					<textarea name="boardContent" cols="50" rows="30"></textarea>
				</td>
			</tr>
			<tr>
				<td>board_writer</td>
				<td>
					<input type="text" name="boardWriter">
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
					<button type="submit">추가</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>