<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
		아이디 : <input type="text" name="id"><br>
		파일첨부1 : <input type="file" name="file1"><br>
		<input type="submit" value="확인">
	</form>
</body>