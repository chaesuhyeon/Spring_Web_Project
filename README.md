# Spring_Web_Project

## Chapter 02 스프링의 특징과 의존성 주입

### 스프링 의존성 주입
1. 생성자 주입
2. Setter 주입

### `@Component`
- 스프링에게 해당 클래스가 스프링에서 관리해야 하는 대상임을 표시하는 어노테이션

### `root-context.xml`
- 스프링 프레임워크에서 관리해야 하는 객체(**Bean**)를 설정하는 설정 파일

### `@RunWith`
- 현재 테스트코드가 스프링을 실행하는 역할을 할 것 이라는 어노테이션
- 테스트 시 필요한 클래스를 지정
- 스프링은 SpringJUnit4ClassRunner 클래스가 대상이 됨

### `@ContextConfiguration`
- 스프링이 실행되면서 어떤 설정 정보를 읽어 들여야 하는지를 명시
- 지정된 클래스나 문자열을 이용해서 필요한 객체들을 스프링 내에 객체로 등록(스프링 빈으로 등록)
- 사용되는 문자열은 classpath 나 file을 이용할 수 있음(locations를 이용해서 문자열의 배열로 XML 설정 파일을 명시할 수 있고, classes 속성으로 @Configuration이 적용된 클래스를 지정해 줄 수도 있음 )

### `@Log4j`
-  로그 객체를 생성
- Lombok을 이용해서 로그를 기록하는 Logger를 변수로 생성
- Spring Legacy로 프로젝트를 생성하는 경우 기본으로 Log4j와 해당 설정이 완료되는 상태이기 때문에 별도의 처리 없이도 사용 가능

### `@Autowired`
- 해당 인스턴스 변수가 스프링으로부터 자동으로 주입해 달라는 표시

### `@Data`
- Lombok에서 자주 사용되는 어노테이션
- **ToStirng**, **EqualsAndHashCode**, **Getter/Setter**, **RequiredArgsConstructor** 를 모두 결합한 형태로 한 번에 자주 사용되는 모든 메서드들을 생성할 수 있음

### `ApplicationContext`
- 필요한 객체를 생성하고 필요한 객체들을 주입하는 역할을 해줌
- **ApplicationContext**가 관리하는 객체들을 **Bean** 이라고 부름

