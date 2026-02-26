<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="row justify-content-center">
	<div class="col-lg-12">
   	<div class="card shadow mb-4">
     	<div class="card-header py-3">
      	<h6 class="m-0 font-weight-bold text-primary">Board List</h6>
     	</div>
     
     	<div class="card-body">
     		<div class="d-flex justify-content-end" style="margin-bottom: 2em">
					<div style="width: 50%;" class="d-flex">
						<select name="typeSelect" class="form-select form-control me-2">
							<option value="">--</option>
							<option value="T" ${dto.types == 'T' ? 'selected' : ''}>제목</option>
					   	<option value="C" ${dto.types == 'C' ? 'selected' : ''}>내용</option>
					   	<option value="W" ${dto.types == 'W' ? 'selected' : ''}>작성자</option>
					   	<option value="TC" ${dto.types == 'TC' ? 'selected' : ''}>제목 OR 내용</option>
					   	<option value="TW" ${dto.types == 'TW' ? 'selected' : ''}>제목 OR 작성자</option>
					   	<option value="TCW" ${dto.types == 'TCW' ? 'selected' : ''}>제목 OR 내용 OR 작성자</option>
						</select>
						<input type="text" class="form-control me-2" name="keywordInput" value="<c:out value='${dto.keyword}'/>" />
						<button class="btn btn-outline-info searchBtn">Search</button>
					</div>
				</div>
     		
     		<table class="table table-bordered" id="dataTable">
				  <thead>
				   	<tr>
				      <th>Bno</th>
				      <th>Title</th>
				      <th>Writer</th>
				      <th>RegDate</th>
				   	</tr>
				  </thead>
					<tbody class="tbody">
						
						<c:forEach var="board" items="${dto.boardDTOList}">
							<tr data-bno="${board.bno}">
								<td>
									<a href="/board/read/${board.bno}">
										<c:out value="${board.bno}" />
									</a>
								</td>
								<td>
									<c:out value="${board.title}" />
									<!-- 댓글의 개수 출력 -->
									<b style="color: blue">[<c:out value="${board.replyCnt}"/>]</b>
								</td>
								<td><c:out value="${board.writer}" /></td>
								<td><c:out value="${board.createdDate}" /></td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
				
				<!-- 페이지 번호 출력 -->
				<div class="d-flex justify-content-center">
					<ul class="pagination">
				  	<c:if test="${dto.prev}">
				    	<li class="page-item">
				      	<a class="page-link" href="${dto.start - 1}" tabindex="-1">Previous</a>
				      </li>
				    </c:if>
				    
				    <c:forEach var="num" items="${dto.pageNums}">
				      <li class="page-item ${dto.page == num ? 'active' : ''}">
				      	<a class="page-link" href="${num}">${num}</a>
				      </li>
				    </c:forEach>
				
				    <c:if test="${dto.next}">
				      <li class="page-item">
				      	<a class="page-link" href="${dto.end + 1}">Next</a>
				      </li>
				    </c:if>
				  </ul>
				</div>
     		
     	</div>
   	</div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	const result = '${result}'; // 새로운 게시물이 등록된 경우 result 변수의 값은 생성된 번호(bno)
	
	const myModal = new bootstrap.Modal(document.getElementById('myModal'));
	// console.log(myModal);
	
	if (result) {
		myModal.show();
	}
	
	// 페이지 번호 클릭 이벤트 처리
	const pagingDiv = document.querySelector('.pagination');
	
	// 이벤트 버블링에 의해 클릭 이벤트가 전파됨
	pagingDiv.addEventListener('click', (e) => {
		e.preventDefault(); // 기본 동작 막기
		// 여기서는 a태그의 기본 동작인 href 값으로 페이지 이동 및 새로고침 발생 막기
		e.stopPropagation(); // 이벤트 전파 막기
		// 상위 요소에 등록된 click 핸들러 실행 방지
		// 상위 클릭 로직을 차단하기 위한 방어 코드로 상위 이벤트가 있을 때만 의미 있음(선택적으로 적용)
		
		const target = e.target;
		// console.log(target);
		
		// href 속성값을 찾아내고 이를 이용하여 브라우저 요청 경로를 수정
		const targetPage = target.getAttribute('href');
		
		const size = ${dto.size} || 10; // BoardListPagingDTO의 size
		
		// URLSearchParams: 클라이언트 측에서 안전하게 URL 쿼리 스트링을 생성, 조작하기 위한 표준 API
		// 내부적으로 key=value 형태로 직렬화하고 인코딩을 수행
		// 예: page=3&size=10
		// 문자열 연결 방식보다 깨짐 및 인코딩 누락 위험이 낮음
		const params = new URLSearchParams({
			page: targetPage,
			size
		});
		
		const types = '${dto.types}';
		const keyword = '${dto.keyword}';
		
		if (types && keyword) {
			params.set('types', types);
			params.set('keyword', keyword);
		}
		
		// 여기서 \는 JSP 엔진이 EL로 인식하지 않도록 escape
		// location.href = `/board/list?\${params.toString()}`; // 백틱 기호(템플릿 리터럴)
		location.href = '/board/list?' + params.toString();
	});
	
	// 검색 버튼 클릭 이벤트 처리
	document.querySelector('.searchBtn').addEventListener('click', e => {
		const keyword = document.querySelector('input[name="keywordInput"]').value;
		//const selectObj = document.querySelector('select[name="typeSelect"]');
		//console.log(selectObj);
		const types = document.querySelector('select[name="typeSelect"]').value;
		
		const params = new URLSearchParams({
			types,
			keyword
		});
		
		location.href = '/board/list?' + params.toString();		
	});
	
	
	
	
	
</script>









<%@include file="/WEB-INF/views/includes/footer.jsp" %>