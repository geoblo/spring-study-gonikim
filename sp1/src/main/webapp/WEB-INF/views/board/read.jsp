<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="row justify-content-center">
  <div class="col-lg-12">
   	<div class="card shadow mb-4">
     	<div class="card-header py-3">
      	<h6 class="m-0 font-weight-bold text-primary">Board Read</h6>
     	</div>
     
     	<div class="card-body">
      	
      	<div class="mb-3 input-group input-group-lg">
			    <span class="input-group-text">Bno</span>
			    <input type="text" class="form-control" value='<c:out value="${board.bno}"/>' readonly>
			  </div>
			
			  <div class="mb-3 input-group input-group-lg">
			    <span class="input-group-text">Title</span>
			    <input type="text" name="title" class="form-control" value="<c:out value="${board.title}"/>" readonly>
			  </div>
			
			  <div class="mb-3 input-group input-group-lg">
			    <span class="input-group-text">Content</span>
			    <textarea class="form-control" name="content" rows="3" readonly><c:out value="${board.content}"/></textarea>
			  </div>
			
			  <div class="mb-3 input-group input-group-lg">
			    <span class="input-group-text">Writer</span>
			    <input type="text" name="writer" class="form-control" value="<c:out value="${board.writer}"/>" readonly>
			  </div>
			
			  <div class="mb-3 input-group input-group-lg">
			    <span class="input-group-text">RegDate</span>
			    <input type="text" name="regDate" class="form-control" value="<c:out value="${board.createdDate}"/>" readonly>
			  </div>
			
			  <div class="float-end">
			  	<a href="/board/list">
				    <button type="button" class="btn btn-info btnList">LIST</button>
			  	</a>
			    <c:if test="${!board.delFlag}">
			    	<a href="/board/modify/${board.bno}">
				    	<button type="button" class="btn btn-warning btnModify">MODIFY</button>
			    	</a>
			    </c:if>
			  </div>
      	
     	</div>
   	</div>
  </div>
</div>

<div class="col-lg-12">
	<div class="card shadow mb-4">
		<div class='m-4'>
			<!--댓글 작성 폼 -->
			<form id="replyForm" class="mt-4">
				<!-- 게시글 번호 hidden 처리 -->
				<input type="hidden" name="bno" value="${board.bno}" />
				
				<div class="mb-3 input-group input-group-lg">
					<span class="input-group-text">Replyer</span>
					<input type="text" name="replyer" class="form-control" required />
				</div>

				<div class="mb-3 input-group">
					<span class="input-group-text">Reply Text</span>
					<textarea name="replyText" class="form-control" rows="3" required></textarea>
				</div>
				
				<div class="text-end">
					<button type="button" class="btn btn-primary addReplyBtn">Submit Reply</button>
				</div>
			</form>
			<!-- 댓글 작성 폼 끝 -->
		</div>
	</div>
</div>

<div class="col-lg-12">
	<div class="card shadow mb-4">
		<div class='m-4'>
			<!--댓글 목록 -->
			<ul class="list-group replyList">
				
			</ul>
			<!-- 댓글 목록 -->
			
			<!-- 페이징 -->
			<div aria-label="댓글 페이지 네비게이션" class="mt-4">
				<ul class="pagination justify-content-center">
					
				</ul>
			</div>
			<!-- 페이징 끝 -->
			
		</div>
	</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script type="text/javascript">
	const replyForm = document.querySelector('#replyForm');
	
	document.querySelector('.addReplyBtn').addEventListener('click', e => {
		e.preventDefault();
		// 여기서는 form의 기본 submit을 막고 AJAX 요청만 수행하도록 만듦
		// 이게 없으면 AJAX 요청 직후 form submit -> 페이지 이동 -> JS 실행 흐름 끊김
		e.stopPropagation();
		// 상위 클릭 로직을 차단하기 위한 방어 코드로 상위 이벤트가 있을 때만 의미 있음(선택적으로 적용)
		
		// FormData: 
		// HTML <form> 요소의 입력값을 이름–값(key–value) 쌍 형태로 수집하여
		// HTTP 요청 본문(request body)으로 전송하기 위한 웹 표준 객체
		// 항상 multipart/form-data 방식 => 파일 업로드에 주로 쓰임
		// 파일 있으면 FormData, 없으면 JSON도 고려 가능
		const formData = new FormData(replyForm); // 이 한 줄로 form 안의 모든 입력 요소를 자동 수집(이때 name 속성 필수)
		
		axios.post('/replies', formData).then(res => {
			console.log("---------- server response ----------");
			console.log(res);
			replyForm.reset();
			
			// 댓글 등록 후 마지막 페이지로 이동 처리
			getReplies(1, true);
		});
	});
	
	// 댓글 목록 요청
	let currentPage = 1; // 현재 댓글 페이지
	let currentSize = 10; // 한번에 보여질 댓글 개수
	
	const bno = ${board.bno};
	
	function getReplies(pageNum, goLast) {
		// axios.get(`/replies/\${bno}/list`, );
		axios.get('/replies/' + bno + '/list', {
			params: {
				page: pageNum || currentPage,
				size: currentSize
			}
		}).then(res => {
			// console.log(res);
			const data = res.data;
			console.log(data);
			
			// 마지막 댓글 페이지 호출
			// ES6차: 구조 분해 할당(비구조화 할당)
			const {totalCount, page, size} = data;
			
			if (goLast && totalCount > (page * size)) {
				// 마지막 페이지 계산
				const lastPage = Math.ceil(totalCount / size);
	
				getReplies(lastPage);
			} else {
				currentPage = page;
				currentSize = size;
				
				printReplies(data); // 출력
			}
		});
	}

	getReplies(1, true); // 페이지가 로드되면 우선 1페이지의 댓글 목록을 가져옴

	// 댓글 출력
	const replyList = document.querySelector('.replyList');
	
	function printReplies(data) {
		const {replyDTOList, page, size, prev, next, start, end, pageNums} = data;
		
		let liStr = '';
		
		for (const replyDTO of replyDTOList) {
			liStr += `
				<li class="list-group-item" data-rno="\${replyDTO.rno}">
					<div class="d-flex justify-content-between">
						<div>
							<strong>\${replyDTO.rno}</strong> - \${replyDTO.replyText}
						</div>
						<div class="text-muted small">
							\${replyDTO.replyDate}
						</div>
					</div>
					<div class="mt-1 text-secondary small">
						\${replyDTO.replyer}
					</div>
				</li>
			`;
		}
		
		replyList.innerHTML = liStr;
		
		// 댓글 페이징 처리 
		let pagingStr = '';
		
		if (prev) {
			pagingStr += `
				<li class="page-item">
					<a class="page-link" href="\${start -1}" tabindex="-1">이전</a>
				</li>
			`;
		}
		
		for (const i of pageNums) {
			pagingStr += `
				<li class="page-item \${i === page ? 'active' : ''}">
					<a class="page-link" href="\${i}">\${i}</a>
				</li>
			`;
		}
		
		if (next) {
			pagingStr += `
				<li class="page-item">
					<a class="page-link" href="\${end + 1}">다음</a>
				</li>
			`;
		}
		
		document.querySelector(".pagination").innerHTML = pagingStr;
	}
	
	// 각 페이지 번호의 이벤트 처리
	document.querySelector(".pagination").addEventListener('click', e => {
		e.preventDefault();
		e.stopPropagation();
		
		const target = e.target;
		
		const href = target.getAttribute("href");
		
		if (!href) return;
		
		console.log(href); // 페이지 번호
		
		getReplies(href);
	});









</script>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>