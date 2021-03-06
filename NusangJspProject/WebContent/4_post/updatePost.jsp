<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1db6aaded4b028f19067fca5394bb829"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/4_post/css/updatePost.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<jsp:include page="../0_common/header.jsp"></jsp:include>
	<div id="body" class="d-flex justify-content-center">
		<form name="createPostForm" action="/post/updatePostOk" method="post" onsubmit="return chkSubmit()" enctype="Multipart/form-data"
		style = "width: 800px;background: #EAEAEA;margin-top: 30px; margin-left :20px; border-radius: 20px 20px 20px 20px;padding: 0 20px 0 20px;">

			<input type="hidden" name="map_latitude" id="latitude" value="${post.location.latitude }"> 
			<input type="hidden" name="map_longtitude" id="longtitude" value="${post.location.longtitude }"> 
			<input type="hidden" name="locationno" value="${post.location.locationno }">
			<input type="hidden" name="postno" value="${post.postno }">
			<input type="hidden" name="post_picno" value="${post.post_picture.post_picno }">
			<div style = " font-family: 'Noto Sans KR', sans-serif; margin-top:25px;">
			<%-- 이미지 --%>
			상품 사진
			<button class = "btn btn-secondary btn-sm" type="button" id="btnAdd" style = "margin-left: 10px; margin-top: -4px;">사진 추가</button>
			※사진을 다시 업로드 해주세요.
			<div id="files"></div>
			<br>
			<%-- 글제목 --%>
			<div style = "margin-top:-5px;">
			제목 <input id="post_title" type="text" name="title" required="required" value="${post.title }" style = "margin-left:10px;border-radius: 4px;" /><br>
			</div>
			<!-- 상품명 -->
			<div style = "margin-top:20px;">
			상품명 <input id="post_prodname" type="text" name="productName" value="${post.productname }" required="required" style = "margin-left: 10px;" />
			</div>
			<%-- 카테고리 --%>
			<jsp:include page="/0_common/data.jsp"></jsp:include>
			<% String cate[] = (String[])request.getAttribute("arr_cate"); %>

			<br> 카테고리
			<div class="dropdown" style = "margin-left: 10px; margin-top: -4px;">
				<button id="cateDrop" class="btn btn-outline-dark btn-sm dropdown-toggle" type="button" data-toggle="dropdown">
					${post.category }<span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<c:forEach var="ct" items="<%=cate%>">
						<li class="dropdown-item" href="#" onclick="changeCateName('${ct}')">${ct}</li>
					</c:forEach>
				</ul>
			</div>
			<span></span> <input type="hidden" name="category" value="${post.category }" required="required"> <br>

			<script type="text/javascript">
				function changeCateName(choice) {
					$("#cateDrop").text(choice);
					$("input[name='category']").attr('value', choice);
				}
			</script>

			<%-- 가격 --%>
			<div style = "margin-top: 20px;">
			가격 <input type="number" name="price" value="${post.price }" required="required"  style = "margin-left: 10px;"/><br>
			</div>
			<%-- 글내용 --%>
			<div style = "margin-top: 20px;">
			<label for="bodytext">내용</label><br>
			<textarea id="bodytext" name="bodytext" class="form-control" rows="5" required="required">${post.bodytext } </textarea>
			<p id="p_text"></p>
			<br>
			</div>

			<%-- 지도 : 거래장소 설정 --%>
			<h4 style="margin-bottom: 10px;"><img id="l_icon" src="/img/location_icon.png">만날 장소를 지정해 주세요</h4>
			<div align = center>
			<div id="map" style="width: 650px; height: 400px;"></div>
			</div>
			<script>
				// 마커가 표시될 위치입니다 
				var position = new kakao.maps.LatLng($("#latitude").val(), $(
						"#longtitude").val());

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					position : position
				});

				// 마커가 지도 위에 표시되도록 설정합니다

				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(position.getLat(), position
							.getLng()), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				var map = new kakao.maps.Map(mapContainer, mapOption);
				map.setCenter(position);
				marker.setMap(map);

				kakao.maps.event.addListener(map, 'click',
						function(mouseEvent) {

							// 클릭한 위도, 경도 정보를 가져옵니다 
							var latlng = mouseEvent.latLng;

							// 마커 위치를 클릭한 위치로 옮깁니다
							marker.setPosition(latlng);
							$("#latitude").val(latlng.getLat())
							$("#longtitude").val(latlng.getLng())
							console.log($("#latitude").val());
							console.log($("#longtitude").val());

						});
			</script>
			<div id="dealingSpot"></div>

			<div align = center style = "margin-top:20px;margin-bottom: 20px;">
			<!-- 수정 버튼 -->
			<input id="buyBtn" class = "btn btn-primary btn-lg"  type="button" value="수정완료" />
			&nbsp;&nbsp;&nbsp;
			<!-- 목록으로 버튼 -->
			<button type="button" class = "btn btn-success btn-lg" onclick="history.back()">돌아가기</button>
			</div>
		</form>

	</div>
	</div>
	<jsp:include page="../0_common/footer.jsp"></jsp:include>
</body>

 <script type="text/javascript" src="/4_post/js/updatePost.js"></script>

</html>



