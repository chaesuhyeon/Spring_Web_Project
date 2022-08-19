package org.zerock.controller;


import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.SampleDTO;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleContoller {
    
    @RequestMapping("")
    public void basic(){
        log.info("basic......................");
    }

    @RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
    public void basicGet(){
        log.info("basic get ..................");
    }

    @GetMapping("/basicOnlyGet")
    public void basicGet2(){
        log.info("basic get only get .............");
    }

    @GetMapping("/ex01")  //경로 : '/sample/ex01'
    public String ex01(SampleDTO dto){
        log.info("" + dto);
        return "ex01";
    }

//    @GetMapping("/ex02")
}
