package jndi;

import java.sql.Connection;
import java.sql.SQLException;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
 
public class DBConnection 
{
    public static Connection getConnection() throws SQLException, NamingException, 
    ClassNotFoundException{
            Context initCtx = new InitialContext();
            
            //initCtx의 lookup메서드를 이용해서 "java:comp/env" 에 해당하는 객체를 찾아서 evnCtx에 삽입
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            
            
            //envCtx의 lookup메서드를 이용해서 "jdbc/orcl"에 해당하는 객체를 찾아서 ds에 삽입
            DataSource ds = (DataSource) envCtx.lookup("jdbc/rw/myoracle");
            
            //getConnection메서드를 이용해서 커넥션 풀로 부터 커넥션 객체를 얻어내어 conn변수에 저장
            Connection conn = ds.getConnection();
            return conn;
            
            /*
             * 위의 코드를 아래와 같이 줄여서 작성 가능하다.
             Context context = new InitialContext();
             DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/oracle");
             Connection con = dataSource.getConnection(); 
             
             */
    }
}
