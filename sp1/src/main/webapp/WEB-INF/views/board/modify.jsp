<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="row justify-content-center">
	<div class="col-lg-12">
  	<div class="card shadow mb-4">
    	<div class="card-header py-3">
      	<h6 class="m-0 font-weight-bold text-primary">Board Modify</h6>
     	</div>
     
     	<div class="card-body">
	     	<form id="actionForm" action="/board/modify" method="post">
      		
      	</form>
      	
      	<div class="float-end">
      		<!-- class 속성값으로 버튼을 식별할 수 있도록 구성 -->
         	<button type="button" class="btn btn-info btnList">LIST</button>
         	<button type="button" class="btn btn-warning btnModify">MODIFY</button>
         	<button type="button" class="btn btn-danger btnRemove">REMOVE</button>
      	</div>
     	</div>
   	</div>
  </div>
</div>

<script type="text/javascript">
	// 어떤 버튼을 클릭했는지에 따라서 다르게 동작할 수 있도록 JS로 이벤트 처리를 작성
	const formObj = document.querySelector('#actionForm');
	
	document.querySelector('.btnModify').addEventListener('click', () => {
		formObj.action = '/board/modify';
		formObj.method = 'post';
		formObj.submit();
	});
	
	document.querySelector('.btnList').addEventListener('click', () => {
		formObj.action = '/board/list';
		formObj.method = 'get';
		formObj.submit();
	});
	
	document.querySelector('.btnRemove').addEventListener('click', () => {
		formObj.action = '/board/remove';
		formObj.method = 'post';
		formObj.submit();
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>
