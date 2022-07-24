package org.zerock.sample;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class) // 현재 테스트코드가 스프링을 실행하는 역할을 할 것 이라는 어노테이션
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTests {
    @Setter(onMethod_ = {@Autowired})
    private Restaurant restaurant;

    @Test
    public void testExist(){
        assertNotNull(restaurant); // restaurant 변수가 null이 아니어야만 테스트 성공

        log.info(restaurant);
        log.info("------------------------------------");
        log.info(restaurant.getChef());

    }

}
