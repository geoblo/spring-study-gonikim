<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="row justify-content-center">
	<div class="col-lg-12">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Product Modify</h6>
			</div>
			
			<div class="card-body">
				
				<form id="modifyForm" action="/product/modify/${product.pno}" method="post" enctype="multipart/form-data">
					<div class="mb-3 input-group input-group-lg">
	          <span class="input-group-text">No</span>
	          <input type="text" name="pno" class="form-control" value="<c:out value='${product.pno}'/>" readonly>
	        </div>
	
	        <div class="mb-3 input-group input-group-lg">
	          <span class="input-group-text">Product Name</span>
	          <input type="text" name="pname" class="form-control" value="<c:out value='${product.pname}'/>">
	        </div>
	
	        <div class="mb-3 input-group input-group-lg">
	          <span class="input-group-text">Desc</span>
	          <textarea class="form-control" name="pdesc" rows="3"><c:out value="${product.pdesc}"/></textarea>
	        </div>
	
	        <div class="mb-3 input-group input-group-lg">
	          <span class="input-group-text">Writer</span>
	          <input type="text" name="writer" class="form-control" value="<c:out value='${product.writer}'/>" readonly>
	        </div>
	
	        <div class="mb-3 input-group input-group-lg">
	          <span class="input-group-text">Price</span>
	          <input type="text" name="price" class="form-control" value="<c:out value='${product.price}'/>">
	        </div>
	        
	        <div class="mb-3">
	        	<input type="file" name="files" class="form-control" multiple>
	        </div>
	
	        <div class="float-end">
	          <a href="/product/list" class="btn">
	          	<button type="button" class="btn btn-info btnList">LIST</button>
          	</a>
	         	<button type="button" class="btn btn-warning btnModify">MODIFY</button>
	         	<button type="button" class="btn btn-danger btnRemove">REMOVE</button>
	         	<!--  -->
	        </div>
				</form>
				
			</div>
		</div>
	</div>
</div>

<div class="mb-3 productImages">
  <label class="form-label fw-bold">Product Images</label>
  <div class="row">
    <c:forEach var="image" items="${product.imageList}">
      <div class="col-md-3 mb-3">
        <div class="card">
          <a href="/images/${image.uuid}_${image.fileName}" target="_blank">
            <img src="/images/${image.uuid}_${image.fileName}" class="card-img-top img-fluid" alt="Product Image">
          </a>
          
          <button type="button" 
          	class="btn btn-danger btn-sm position-absolute top-0 end-0 m-2 delete-image-btn" 
          	data-file="${image.uuid}_${image.fileName}">
          	Delete
          </button>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<script type="text/javascript">
	const modifyForm = document.querySelector('#modifyForm');
	
	// 상품 삭제에 대한 이벤트 처리
	document.querySelector('.btnRemove').addEventListener('click', e => {
		modifyForm.action = '/product/remove';
		modifyForm.submit();
	});
	
	// 각 상품 이미지의 삭제에 대한 이벤트 처리
	document.querySelector('.productImages').addEventListener('click', e => {
		e.preventDefault();
		e.stopPropagation();
		
		const target = e.target;
		
		// const fileName = target.getAttribute('data-file');
		const fileName = target.dataset.file;
		
		if (!fileName) return;
		
		// 하나의 이미지를 표현하는 <div>를 찾음
		const divObj = target.closest('.col-md-3');
		
		divObj.remove(); // 요소 삭제
	});
	
	// 상품 수정에 대한 이벤트 처리
	document.querySelector('.btnModify').addEventListener('click', e => {
		e.preventDefault();
		e.stopPropagation();
		
		modifyForm.action = '/product/modify';
		modifyForm.method = 'post';
		
		const imageArr = document.querySelectorAll('.productImages button');
		
		if (imageArr.length > 0) {
			let html = '';
			
			for (const image of imageArr) {
				const imageFile = image.getAttribute('data-file');
				
				html += `<input type="hidden" name="oldImages" value="\${imageFile}">`;
			}
			
			// insertAdjacentHTML: 지정된 위치에 HTML 코드를 삽입
			// beforebegin(요소 바로 앞), afterbegin(요소 내부 맨 앞), beforeend(요소 내부 맨 뒤), afterend(요소 바로 뒤)
			modifyForm.querySelector('div:last-child').insertAdjacentHTML('beforeend', html);			
		}
		
		modifyForm.submit();
	});
</script>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>