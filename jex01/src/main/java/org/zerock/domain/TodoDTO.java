package org.zerock.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class TodoDTO {
    private String title;

    @DateTimeFormat(pattern = "yyyy-MM-dd") // 문자열로 "yyyy-MM-dd"이 형식이 맞다면 자동으로 날짜 타입으로 변환
    private Date dueDate;
}
