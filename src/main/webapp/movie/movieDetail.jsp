<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>Nectaria - Free HTML Template by WowThemes.net</title>
<meta name="description" content="Thoughts, reviews and ideas since 1999."/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" type="text/css" href="assets/css/screen.css"/>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:400,300italic,300,400italic,700,700italic|Playfair+Display:400,700,400italic,700italic"/>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">

	<%
		request.setCharacterEncoding("UTF-8");
		String movieCd = request.getParameter("movieCd");
		String reservationRate = request.getParameter("movieSalesRate");
		String movieNm = request.getParameter("movieNm");
		Object userRating = request.getAttribute("userRating");
		Object img = request.getAttribute("img");
		
	%>
		
		$(document).ready(function() {
			var movieCd = <%=movieCd %>
			
			
			$.ajax({
				url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=09a2696ef753c4b8196ac759ba9b0007&movieCd=" + movieCd ,
				
				success : function(data) {
					$(data).find('movieInfoResult').each(function() {
						var tmp1 = $(this).find('showTm').text();
						var tmp2 = $(this).find('genreNm').text();
						var tmp3 = $(this).find('director').find('peopleNm').text();
						var tmp4 = $(this).find('watchGradeNm').text();
						var tmp5 = $(this).find('actor').find('peopleNm');
						var tmp6 = $(this).find('movieCd').text();
						var tmp7 = $(this).find('movieNm').text();
						var tmp8 = $(this).find('openDt').text();
						
						$(".showTm").append(tmp1+"분");
						$(".genreNm").append(tmp2);
						$(".peopleNm").append(tmp3);
						$(".watchGradeNm").append(tmp4);
						for(var i=0; i<tmp5.size(); i++){
							var temp = tmp5.get(i);
							$(".actor").append(temp);
							if(i != tmp5.size()-1){
							$(".actor").append(", ");								
							}
						}
						
						$(".movieCd").append(tmp6);
						$(".movieNm").append(tmp7);
						$(".openDt").append(tmp8);

					})
				}
			});
			
			$(".texta").click(function(){
				$.ajax({
					url:'./checkLogin.mv',
					dataType:'text',
					success:function(data){
						if(data=="X"){
							alert("로그인 이후 사용 가능");
							location.href='./Login.me';
							
						}
					}
					
				});
			});

			
			
		});


</script>
<style>
	.a{
		color:white;
	}
</style>


</head>
<body class="author-template">
<div class="site-wrapper">
	<jsp:include page="../inc/top.jsp"/>
	
	<header class="main-header author-head " style="background-image: url(http://s3.amazonaws.com/caymandemo/wp-content/uploads/sites/10/2015/09/30162427/sep2.jpg)">
	</header>
	
	<main class="content1" role="main">
		<div>
		<div class="detailDiv1">
			<img src="<%=img%>" width="300px">
		</div>
		
		<div class="detailDiv2">
			<span>
			<span class="movieCd">영화 번호 : </span><br>
			<span class="movieNm">영화명 : </span><br>
			<span class="genreNm">장르 : </span><br>
			<span class="showTm">상영시간 : </span><br>
			<span class="peopleNm">감독 : </span><br>
			<span class="watchGradeNm">등급 : </span><br>
			<span class="actor">배우 : </span><br>
			<span class="openDt">개봉일 : </span><br>
			줄거리 : ${M_explain }<br>
			평점 : <%=userRating %><br>
			예매율 : <%=reservationRate %>%<br>
			</span>
			
			시간표
			<br>
			<f:formatDate value="${now }" var="today" pattern="yyyy-MM-dd HH:mm"/>

			<c:forEach items="${tList }" var="tList">
				<c:if test="${tList.t_date > today }">
					상영일 : ${tList.t_date }
					시작시간 : <a href='./seatChoice.st?T_num=${tList.t_num }&Sc_num=${tList.sc_num}&M_num=${movieCd }&M_name=${movieNm }' class="a">${tList.t_startTime }</a>
					종료시간 : ${tList.t_endTime }
					<br>
				</c:if>
			</c:forEach>
			
			
			
			
		</div>	
		
		</div>
		<hr>
		<div class="detailDiv3">
			<h4> 한줄평 및 평점 </h4>
			
			<form action="movieReview.mv">
				<input type="hidden" value="${movieCd }" name="M_num">
				한줄평 : <textarea cols="100" class="texta" name="Review"></textarea>
				<select name="grade">
					<option>평점 선택</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>
				<input type="submit" value="등록">
			</form>
			
		<table id="reviewT" >
			<tr>
				<th>아이디</th>
				<th>한줄평</th>
				<th>평점</th>
				<th>등록일</th>
			</tr>
			
			<c:forEach var="reviewList" items="${reviewList }">
				<tr>
					<td>${reviewList.mem_num }</td>
					<td>${reviewList.review }</td>
					<td>${reviewList.m_grade }</td>
					<td>${reviewList.review_date }</td>
				</tr>
			</c:forEach>
			
		</table>
		
		</div>
		
	</main>
	
	<!-- <footer class="site-footer clearfix">
	<a href="#top" id="back-to-top" class="back-top"></a>
	<div class="text-center">
	Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>

	</div>
	</footer> -->
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="assets/js/masonry.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.fitvids.js"></script>
<script type="text/javascript" src="assets/js/index.js"></script>
</body>
</html>