package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.dto.ProductDTO;
import org.zerock.dto.ProductListDTO;
import org.zerock.dto.ProductListPagingDTO;
import org.zerock.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
@Transactional
public class ProductService {

	private final ProductMapper productMapper;
	
	public Integer register(ProductDTO productDTO) {
		productMapper.insert(productDTO);
		
		Integer pno = productDTO.getPno();
		
		// 이미지 리스트가 존재하고, 비어있지 않을 때만 실행
		if (productDTO.getImageList() != null &&
		   !productDTO.getImageList().isEmpty()) {
			productMapper.insertImage(productDTO);			
		}
		
		return pno;
	}
	
	public ProductListPagingDTO getList(int page, int size) {
		// 페이지 번호가 0보다 작으면 무조건 1페이지
		page = page <= 0 ? 1 : page;
		// 사이즈가 10보다 작거나 100보다 크면 10
		size = (size < 10 || size > 100) ? 10 : size;
		
		int skip = (page - 1) * size; // 2페이지라면 (2 - 1) * 10 이 되어야 함
		
		List<ProductListDTO> list = productMapper.list(skip, size);
		
		int total = productMapper.listCount();
		
		return new ProductListPagingDTO(list, total, page, size);
	}
	
	public ProductDTO read(Integer pno) {
		return productMapper.selectOne(pno);
	}
	
	public void remove(Integer pno) {
		productMapper.deleteOne(pno);
	}
	
	public void modify(ProductDTO productDTO) {
		// 1. 기존 이미지 삭제
		productMapper.deleteImage(productDTO.getPno());
		
		// 2. 상품 정보 수정
		productMapper.updateOne(productDTO);
		
		// 3. 상품 이미지 갱신
		// 이미지 리스트가 존재하고, 비어있지 않을 때만 실행
		if (productDTO.getImageList() != null &&
		   !productDTO.getImageList().isEmpty()) {
			productMapper.insertImage(productDTO);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
