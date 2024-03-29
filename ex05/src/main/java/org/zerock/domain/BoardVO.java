package org.zerock.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BoardVO {
    private  long bno;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private Date updateDate;
    private int replyCnt;
    private List<BoardAttachVO> attachList; // 등록 시 한 번에 BoardAttachVO를 처리할 수 있도록
}
