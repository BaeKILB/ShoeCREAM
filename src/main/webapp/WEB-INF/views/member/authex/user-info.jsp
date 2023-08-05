<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CREAM</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
        rel="stylesheet">
  <link href="${pageContext.request.contextPath }/css/member/authex/product.css" rel="stylesheet">
  <script src="../js/user/user-info.js" type="text/javascript"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
  <div class="container">
    <a class="navbar-brand" href="/">CREAM</a>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item active">
          <a class="nav-link" href="/">Home
            <span class="sr-only">(current)</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/product/all-product.html">Shop</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/user/user-info.html">MyPage</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/user/user-join.html">Join</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


<div class="container mt-5">
  <div class="form-group row m-1">
    <div class="col-xs-3 mr-2">
      <input class="form-control" id="search-input" placeholder="사용자 아이디 입력" type="number"/>
    </div>
    <div>
      <button class="btn btn-dark" id="send">입력</button>
    </div>
    <div class="ml-auto mr-2">
      <button class="btn btn-primary"
              onclick="location.href='/user/user-update.html'">프로필 수정
      </button>
    </div>
    <div class="mr-2">
      <button class="btn btn-danger"
              onclick="location.href='/buy/buying-info.html'">구매 내역
      </button>
    </div>
    <div>
      <button class="btn btn-success"
              onclick="location.href='/sell/list/selling.html'">판매 내역
      </button>
    </div>
  </div>
  <div class="table-section">
    <table class="table">
      <thead class="table-dark">
      <tr>
        <th scope="col">이름</th>
        <th scope="col">전화번호</th>
        <th scope="col">주소</th>
        <th scope="col">이메일</th>
        <th scope="col">사이즈</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td id="user-nickname"></td>
        <td id="user-phone"></td>
        <td id="user-address"></td>
        <td id="user-email"></td>
        <td id="user-size"></td>
      </tr>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
