package org.zerock.controller;

import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
//Test for controller
@WebAppConfiguration // ServletContext를 이용하기 위해서 사용
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml" , "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {
    @Autowired
    private WebApplicationContext ctx;
    private MockMvc mockMvc; // 가짜 mvc, 가짜로 URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해볼 수 있음
    
    @Before // 모든 테스트 전에 매번 실행되는 메서드
    public void setup(){
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }
    
    @Test
    public void testList() throws Exception {
        log.info(
                mockMvc.perform(MockMvcRequestBuilders.get("/board/list")).andReturn().getModelAndView().getModelMap()
                        //MockMvcRequestBuilders를 이용해서 GET방식으로 호출
        );
    }

    @Test
    public void testListPaging() throws Exception{
        log.info(mockMvc.perform(
                MockMvcRequestBuilders.get("/board/list")
                .param("pageNum" , "2")
                .param("amount" , "50"))
                .andReturn().getModelAndView().getModelMap());
    }

    @Test
    public void testRegister() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
                .param("title", "테스트 새글 제목")
                .param("content", "테스트 새글 내용")
                .param("writer", "user00")).andReturn().getModelAndView().getViewName();
        log.info(resultPage);
    }

    @Test
    public void testGet() throws Exception {
        log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
                .param("bno", "4"))
                .andReturn()
                .getModelAndView().getModelMap());
    }

    @Test
    public void testModify() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
                .param("bno", "1")
                .param("title", "수정된 테스트 새글 제목")
                .param("content", "수정된 테스트 새글 내용")
                .param("writer", "user00"))
                .andReturn().getModelAndView().getViewName();
        log.info(resultPage);
    }


    @Test
    public void testRemove() throws Exception{

        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
                .param("bno", "25")).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }
}
