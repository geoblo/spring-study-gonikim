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
								<td><c:out value="${board.title}" /></td>
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
				      	<a class="page-link" tabindex="-1">Previous</a>
				      </li>
				    </c:if>
				    
				    <c:forEach var="num" items="${dto.pageNums}">
				      <li class="page-item">
				      	<a class="page-link" href="${num}">${num}</a>
				      </li>
				    </c:forEach>
				
				    <c:if test="${dto.next}">
				      <li class="page-item">
				      	<a class="page-link">Next</a>
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
	console.log(myModal);
	
	if (result) {
		myModal.show();
	}
</script>









<%@include file="/WEB-INF/views/includes/footer.jsp" %>