package org.zerock.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

@Controller
@Log4j
@RequestMapping("/board/*") // '/board' 로 시작하는 모든 처리를 BoardController가 하게 지정
@AllArgsConstructor
public class BoardController {
    private BoardService service;

//    @GetMapping("/list")
//    public void list(Model model){
//        log.info("list");
//        model.addAttribute("list", service.getList());
//    }

    @GetMapping("/list")
    public void list(Criteria cri, Model model){
        log.info("list:" +cri);
        model.addAttribute("list", service.getList(cri));
//        model.addAttribute("pageMaker", new PageDTO(cri, 123));

        int total = service.getTotal(cri);
        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
    }

    @GetMapping("/register")
    public void register(){

    }

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr){
        log.info("register : " + board);
        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

    @GetMapping({"/get" , "/modify"})
    public void get(@RequestParam("bno") Long bno , @ModelAttribute("cri") Criteria cri,  Model model){
        log.info("/get or modify");
        model.addAttribute("board", service.get(bno));
    }

//    @PostMapping("/modify")
//    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr){
//        log.info("modify : " + board);
//
//        // service.modify는 수정 여부를 boolean으로 처리하므로 이를 이용해서 성공한 경우에만 RedirectAttributes에 추가
//        if(service.modify(board)){
//            rttr.addFlashAttribute("result", "success");
//        }
//
//        rttr.addFlashAttribute("pageNum", cri.getPageNum());
//        rttr.addFlashAttribute("amount", cri.getAmount());
//        rttr.addFlashAttribute("type", cri.getType());
//        rttr.addFlashAttribute("keyword", cri.getKeyword());
//
//        return "redirect:/board/list";
//    }

    // UriComponentsBuilder 사용하는 경우
    @PostMapping("/modify")
    public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr){
        log.info("modify : " + board);

        // service.modify는 수정 여부를 boolean으로 처리하므로 이를 이용해서 성공한 경우에만 RedirectAttributes에 추가
        if(service.modify(board)){
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + cri.getListLink();
    }

//    @PostMapping("/remove")
//    public String remove(@RequestParam("bno") Long bno , @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr){
//        log.info("remove..." + bno);
//        if(service.remove(bno)){
//            rttr.addFlashAttribute("result" , "success");
//        }
//        rttr.addFlashAttribute("pageNum", cri.getPageNum());
//        rttr.addFlashAttribute("amount", cri.getAmount());
//        rttr.addFlashAttribute("type", cri.getType());
//        rttr.addFlashAttribute("keyword", cri.getKeyword());
//
//        return "redirect:/board/list";
//    }

    // UriComponentsBuilder 사용하는 경우
    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno , @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr){
        log.info("remove..." + bno);
        if(service.remove(bno)){
            rttr.addFlashAttribute("result" , "success");
        }

        return "redirect:/board/list" + cri.getListLink();
    }

}
