package org.zerock.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Log4j
@Controller
@RequestMapping("/sample/*")
public class SampleController {

    @GetMapping("/all") // 로그인을 하지 않은 사용자도 접근 가능한 URI
    public void doAll(){
        log.info("do all can access everybody");
    }

    @GetMapping("/member") // 로그인 한 사용자들만이 접근할 수 있는 URI
    public void doMember(){
        log.info("logined member");
    }

    @GetMapping("/admin") // 로그인 한 사용자들 중에서 관리자 권한을 가진 사용자만이 접근할 수 있는 URI
    public void doAdmin(){
        log.info("admin only");
    }
}
