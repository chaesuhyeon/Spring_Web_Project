package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
@ToString
public class Criteria {
    private int pageNum;
    private int amount;

    private String type;
    private String keyword;

    public Criteria(){
        this(1,10); // 기본값을 1페이지, 10개로
    }

    public Criteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr(){
        return type == null ? new String[]{} : type.split("");
    }

    public String getListLink(){
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
                // UriComponentsBuilder는 queryParam()이라는 메서드를 이용해서 필요한 파라미터들을 손쉽게 추가할 수 있음
                .queryParam("pageNum" , this.pageNum)
                .queryParam("amount" , this.getAmount())
                .queryParam("type" , this.getType())
                .queryParam("keyword" , this.getKeyword());
        return builder.toUriString();
    }
}
