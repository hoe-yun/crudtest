<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<h1 class="text-bg-secondary">Board 추가</h1>
		<form action="<%=request.getContextPath() %>/addBoardAction.jsp">
			<table class="table table-bordered table-hover">
				<tr>
					<th>board_title</th>
					<td>
						<input type="text" name="boardTitle">
					</td>
				</tr>
				<tr>
					<th>board_content</th>
					<td>
						<textarea name="boardContent" cols="50" rows="10"></textarea>
					</td>
				</tr>
				<tr>
					<th>board_writer</th>
					<td>
						<input type="text" name="boardWriter">
					</td>
				</tr>
				<tr>
					<th>board_pw</th>
					<td>
						<input type="password" name="boardPw">
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-secondary">추가</button>
		</form>
</div>
</body>
</html>