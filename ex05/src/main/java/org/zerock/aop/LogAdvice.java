package org.zerock.aop;

import lombok.extern.log4j.Log4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect // 해당 클래스의 객체가 Aspect을 구현한 것임을 나타내기 위해 사용
@Log4j
@Component // 스프링에서 빈으로 인식하기 위해서 사용 
public class LogAdvice {
    @Before("execution(* org.zerock.service.SampleService*.*(..))")
    public void logBefore(){
        log.info("==========================");
    }

    // 전달되는 파라미터 값 보기
    @Before("execution(* org.zerock.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
    public void logBeforeWithParam(String str1, String str2){
        log.info("str1: " + str1);
        log.info("str2: " +str2 );
    }

    // 지정된 대상이 예외를 발생한 후에 동작
    @AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))", throwing = "exception") // 변수 이름 exception
    public void logException(Exception exception){
        log.info("Exception...!!!");
        log.info("exception: " + exception);
    }

    @Around("execution(* org.zerock.service.SampleService*.*(..))")
    public Object logTime(ProceedingJoinPoint pjp){
        long start = System.currentTimeMillis();

        log.info("Target : " + pjp.getTarget());
        log.info("Param : " + Arrays.toString(pjp.getArgs()));

        //invoke method
        Object result = null;

        try {
            result = pjp.proceed();
        } catch (Throwable e){

            //TODO Auto-generted catch block
            e.printStackTrace();
        }
        long end = System.currentTimeMillis();
        log.info("TIME:" + (end-start));
        return result;

    }

}

// @Before내부의 execution 문자열은 AspectJ의 표현식. execution의 경우 접근 제한자와 특정 클래스의 메서드를 지정할 수 있다.
// 맨 앞의 '*'는 접근제한자를 의미하고 맨 뒤의 '*'는 클래스의 이름과 메서드의 이름을 의미

// AOP를 이용해서 좀 더 구체적인 처리를 하고 싶다면 @Around와 ProceedingJoinPoint를 이용해야 한다.
// @Around는 조금 특별하게 동작하는데 직접 대상 메서드를 실행할 수 있는 권한을 가지고 있고, 메서드의 실행 전과 실행 후에 처리가 가능함
// @Around가 적용되는 메서드의 경우에는 리턴타입이 void가 아닌 타입으로 설정하고, 메서드의 실행 결과 역시 직접 반환하는 형태로 작성해야함

// ProceedingJoinPoint는 @Around와 같이 결합해서 파라미터나 예외 등을 처리할 수 있음
// ProceedingJoinPoint는 AOP의 대상이 되는 Target이나 파라미터 등을 파악할 뿐만 아니라 직접 실행을 결정할 수도 있음

// @Around가 먼저 동작하고 @Before 등이 실행됨