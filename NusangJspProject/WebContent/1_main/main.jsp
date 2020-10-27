<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>너근마켓</title>
<link rel="stylesheet" type="text/css" href="/1_main/css/postCard.css">
</head>


<body>
	<jsp:include page="../0_common/header.jsp"></jsp:include>


	<div class="container border border-dark mt-4 overflow-auto rounded-lg" style="height: 600px;">
		
		<div class="input-group w-50 container mt-4 ">
			<input type="text" class="form-control" placeholder="검색 키워드를 입력하세요!"> <span class="input-group-btn">
				<button class="btn btn-dark " type="button">찾기</button>
			</span>
		</div>
		<h1 class="mt-5" id="titleAddress">${location.getAddress() }근처 판매목록</h1>

		<!-- 카테고리, 글쓰기버튼 -->
		<div id="cate-post" class="d-flex">
			<div id="cate" class="mr-auto"></div>
			<button type="button" id="btnPost" onclick="location.href='/post/moveMkPost'">글쓰기</button>
		</div>
		
		<div id="postListSection" class="d-flex flex-wrap align-content-start justify-content-center">
			<c:forEach var="post" items="${postList}">
				<div class="postCard" >
					<img alt="" src="/img/postImg_default.png">
					<span>${post.title }</span>
					<span>${post.price }</span>
					<span>${post.user.location.name1} ${post.user.location.name2} ${post.user.location.name3}</span>
					<
					<span>${post.replyList }</span>
					<button onclick="location.href='/post/readBuyer?postno=${post.postno}'"> 글보기</button>
					
				</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="../0_common/footer.jsp"></jsp:include>
</body>
</html>
	
</script>
