<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!--Jquery-->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!--toastr-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!--bootstrap icon-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
<script src="../js/game/jackpot.js" defer></script>
<style>
    .ball {
      display: inline-block;
      border: 1px solid black;
      border-radius: 20px;
      width: 40px;
      height: 40px;
      line-height: 40px;
      font-size: 20px;
      text-align: center;
      margin-right: 20px;
    }
  </style>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container my-5">
		<div class="mt-5" id="result">추첨 결과는?</div>
  		<div id="bonus">보너스:</div>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>