package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
    private int pageNum;
    private int amount;

    public Criteria(){
        this(1,10); // 기본값을 1페이지, 10개로
    }

    public Criteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
