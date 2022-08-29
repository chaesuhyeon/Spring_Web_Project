package org.zerock.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.service.BoardService;

@Controller
@Log4j
@RequestMapping("/board/*") // '/board' 로 시작하는 모든 처리를 BoardController가 하게 지정
@AllArgsConstructor
public class BoardController {
    private BoardService service;

    @GetMapping("/list")
    public void list(Model model){
        log.info("list");
        model.addAttribute("list", service.getList());
    }

}
