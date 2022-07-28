package org.zerock.persistence;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import java.sql.Connection;
import java.sql.DriverManager;

@Log4j
public class JDBCTest {

    @Test
    public void testConnection() throws Exception {
        Class clz = Class.forName("oracle.jdbc.driver.OracleDriver");
        log.info(clz);

        // DB연결
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "book_ex", "book_ex"); // getConnection(url,id, pwd )

        log.info(con);
        con.close(); //bad code
    }
}
