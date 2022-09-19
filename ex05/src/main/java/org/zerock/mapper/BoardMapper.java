package org.zerock.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import java.util.List;

public interface BoardMapper {

//    @Select("select * from tbl_board where bno > 0")
    public List<BoardVO> getList();

    public List<BoardVO> getListWithPaging(Criteria cri);

    public void insert(BoardVO board);

    public void insertSelectKey(BoardVO board);

    public BoardVO read(Long bno);

    public int delete(Long bno);

    public int update(BoardVO board);

    public int getTotalCount(Criteria cri);

    public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount); 
    // MyBatis의 SQL을 처리하기 위해서는 기본적으로 하나의 파라미터 타입을 사용하기 때문에 2개 이상의 데이터를 전달하려면 @Param이라는 어노테이션을 이용해서 처리할 수 있음
}
