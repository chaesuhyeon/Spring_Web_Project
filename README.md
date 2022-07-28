# Spring_Web_Project

## Chapter 02 스프링의 특징과 의존성 주입

### 스프링 의존성 주입
1. 생성자 주입
2. Setter 주입

### `@Component`
- 스프링에게 해당 클래스가 스프링에서 관리해야 하는 대상임을 표시하는 어노테이션

### `@Bean`
- XML설정에서 <bean>태그와 동일한 역할을 하며, **@Bean**이 선언된 메서드의 실행 결과로 반환된 객체는 스프링 객체(Bean)로 등록됨 

### `root-context.xml`
- 스프링이 로딩되면서 읽어 들이는 문서이며, 주로 이미 만들어진 클래스들을 이용해서 스프링의 빈으로 등록할 때 사용
- 스프링 프레임워크에서 관리해야 하는 객체(**Bean**)를 설정하는 설정 파일
- **<bean>** 태그 내에는 **<property>**를 이용해서 여러 속성에 대해서 설정할 수 있음

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

### `커넥션 풀`
- 여러 명의 사용자를 동시에 처리해야 하는 웹 애플리케이션의 경우 DB연결을 이용할 때는 **커넥션 풀** 이용
- Java에서는 **DateSource**라는 인터페이스를 통해서 커넥션 풀을 사용
- DateSource를 통해서 매번 DB와 연결하는 방식이 아닌 미리 연결을 맺어주고 반환하는 구조를 이용하여 성능 향상을 꾀함

## MyBatis
- SQL Mapping 프레임 워크
- SQL과 Object간의 관계를 매핑해주는 역할
- MyBatis와 mybatis-spring을 사용하기 위해서 pom.xml 파일에 추가적인 라이브러리 설정
-       spring-jdbc/spring-tx/mybatis/mybatis-spring
```
// ex
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-tx</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.5.6</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>2.0.6</version>
		</dependency>
```

### `SQLSession`  / `SQLSessionFactory` 
- MyBatis에서 가장 핵심적인 존재
- **SQLSessionFactory** :  내부적으로 **SQLSession** 을 생성
- SQLSession을 통해서 Connection을 생성하거나 원하는 SQL을 전달하고 결과를 return받는 구조로 작성
- 스프링에 SqlSessionFactory를 등록하는 작업은 **SqlSessionFactoryBean**을 이용
```
//root-context.xml
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource"></property>
	</bean>
```