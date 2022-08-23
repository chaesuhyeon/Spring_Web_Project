package org.zerock.controller;


import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import java.util.ArrayList;
import java.util.Arrays;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleContoller {
    
//    @InitBinder // 날짜 데이터 같이 '2018-01-01'과 같이 문자열로 전달된 데이터를 java.util.Date 타입으로 변환하는 작업과 같이 변환할때 사용 , @DateTimeFormat 사용 시 @InitBinder불필요
//    public void initBinder(WebDataBinder binder){
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
//    }
    
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

    @GetMapping("/ex02") // http://localhost:8080/sample/ex02?name=AAA&age=10
    public String ex02(@RequestParam("name") String name , @RequestParam("age") int age) {
        log.info("name : " + name); // INFO : org.zerock.controller.SampleContoller - name : AAA
        log.info("age : " + age); // INFO : org.zerock.controller.SampleContoller - age : 10
        return "ex02";
    }

    @GetMapping("/ex02List") // http://localhost:8080/sample/ex02List?ids=111&ids=222&ids=333
    public String ex02List(@RequestParam("ids")ArrayList<String> ids){
        log.info("ids : " + ids); // INFO : org.zerock.controller.SampleContoller - ids : [111, 222, 333]
        return "ex02List";
    }

    @GetMapping("/ex02Array") // http://localhost:8080/sample/ex02List?ids=111&ids=222&ids=333
    public String ex02Array(@RequestParam("ids") String[] ids){
        log.info("array ids : " + Arrays.toString(ids)); // INFO : org.zerock.controller.SampleContoller - array ids : [111, 222, 333]
        return "ex02Array";
    }

    @GetMapping("/ex02Bean") // http://localhost:8080/sample/ex02Bean?list%5B0%5D.name=aaa&list%5B1%5D.name=bbb
    public String ex02Bean(SampleDTOList list) {
        log.info("list dtos : " + list); // INFO : org.zerock.controller.SampleContoller - list dtos : SampleDTOList(list=[SampleDTO(name=aaa, age=0), SampleDTO(name=null, age=0), SampleDTO(name=bbb, age=0)])
        return "ex02Bean";
    }

    @GetMapping("/ex03") // http://localhost:8080/sample/ex03?title=test&dueDate=2018-01-01
    public String ex03(TodoDTO todo){
        log.info("todo : " + todo); // INFO : org.zerock.controller.SampleContoller - todo : TodoDTO(title=test, dueDate=Mon Jan 01 00:00:00 KST 2018)
        return "ex03";
    }

    @GetMapping("/ex04")
    public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
        log.info("dto : " + dto);
        log.info("page : " + page);
        return "/sample/ex04";
    }

    @GetMapping("/ex05")
    public void ex05(){
        log.info("/ex05............."); // INFO : org.zerock.controller.SampleContoller - /ex05.............
    }

    @GetMapping("/ex06")
    public @ResponseBody SampleDTO ex06(){
        log.info("/ex06.............");
        SampleDTO dto = new SampleDTO();
        dto.setAge(10);
        dto.setName("홍길동");

        return dto;
    }

    @GetMapping("/ex07")
    public ResponseEntity<String> ex07() {
        log.info("/ex07............");

        //{"name" : "홍길동"}
        String msg = "{\"name\" : \"홍길동\"}";

        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type" , "application/json;charset=UTF-8");

        return new ResponseEntity<>(msg,header, HttpStatus.OK);
    }

    @GetMapping("/exUpload")
    public void exUpload(){
        log.info("/exUpload...........");
    }

    @PostMapping("exUploadPost")
    public void exUploadPost(ArrayList<MultipartFile> files) {
        files.forEach(file -> {
            log.info("------------------------------------");
            log.info("name : " + file.getOriginalFilename());
            log.info("size : " + file.getSize());
        });
    }

}
