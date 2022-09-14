package org.zerock.service;

import org.springframework.stereotype.Service;

@Service // @Service라는 어노테이션 추가해서 스프링 빈에서 사용될 수 있도록 설정
public class SampleServiceImpl implements SampleService{

    @Override
    public Integer doAdd(String str1, String str2) throws Exception {
        return Integer.parseInt(str1) + Integer.parseInt(str2);
    }
}
