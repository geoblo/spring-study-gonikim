package org.zerock.dto;

import java.util.List;
import java.util.stream.IntStream;

import lombok.Data;

@Data
public class ProductListPagingDTO {
	private List<ProductListDTO> productDTOList; // 상품 목록
	private int totalCount; // 전체 데이터 개수
	private int page; // 현재 페이지 번호
	private int size; // 한 페이지당 크기(한 페이지에 출력되는 데이터 개수)
	
	// 페이지 번호의 처리 계산
	private static final int BLOCK_SIZE = 10; // 페이지 번호 블록 크기(blockSize)
	private int start; // 블록의 시작 번호
	private int end; // 블록의 마지막 번호
	private boolean prev;
	private boolean next;
	private List<Integer> pageNums;
	
	public ProductListPagingDTO(List<ProductListDTO> productDTOList, int totalCount, int page, int size) {
		this.productDTOList = productDTOList;
		this.totalCount = totalCount;
		this.page = page;
		this.size = size;
		
		// start 계산을 위한 tempEnd 페이지
		// tempEnd: 현재 블록의 마지막 페이지(임시)
		int tempEnd = (int) (Math.ceil(page / (double) BLOCK_SIZE)) * BLOCK_SIZE;
		this.start = tempEnd - (BLOCK_SIZE - 1);
		
		this.prev = start != 1; // start 값이 1이 아니라면 이전 페이지로 이동 필요
		
		// 정확한 end 페이지 번호 계산
		// lastPage: 전체 마지막 페이지
		int lastPage = (int) Math.ceil(totalCount / (double) size);
		this.end = Math.min(tempEnd, lastPage);
		
		// 현재 블록의 마지막 페이지(end)가 전체 마지막 페이지(lastPage)보다 작으면 다음 블록 존재
		this.next = end < lastPage;
		
		// 화면에 출력할 번호들 계산
		this.pageNums = IntStream.rangeClosed(start, end).boxed().toList();
	}
	
}
