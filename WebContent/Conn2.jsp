<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="jndi.DBConnection"%> <!-- DB연결 클래스를 import한다. -->
<html>
<head>
</head>
<body>
    <center>
        <table border="3" bordercolor="skyblue">
        <tr bgcolor="skyblue"><td>이름<td>직업</tr>
        
        <%
        // 쿼리문
        String query="select COMMENT_ID, CONTENT from EPN_ARTICLE_COMMENT3 ";
        
        // 커넥션 연결
        Connection conn = DBConnection.getConnection();
        
        // DB에 쿼리문을 보낸다.
        PreparedStatement pstmt = conn.prepareStatement(query);
        
        // 쿼리문의 결과값을 rs에 담는다.
        ResultSet rs = pstmt.executeQuery();
        
        // 결과값을 출력한다.
        while(rs.next()){
            out.println("<tr>");
            out.println("<td>"+rs.getInt("COMMENT_ID"));
            out.println("<td>"+rs.getString("CONTENT"));
            out.println("</tr>");
        }
        
        %>
        </table>
    </center>

	<style>
		textarea.autosize { min-height: 100px; min-width: 800px; }
	</style>
	<table>
		<tr>
			<td><textarea class="autosize" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="추가 바람"></textarea></td>
		</tr>
	</table>
	<script>
	function resize(obj) {
	  obj.style.height = "1px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	}
	</script>


<textarea style="height:150px;width:300px" onKeyup="var m=50;var s=this.scrollHeight;if(s>=m)this.style.pixelHeight=s+4"></textarea>
</body>
</html>

<%--
참고 URL

JSP에서 DB연동 하기 - JNDI, DBCP(커넥션풀) 이용 : http://all-record.tistory.com/104
[tomcat] jndi 설정: http://jang8584.tistory.com/183

톰캣7.0(tomcat 7.0) 과 오라클11g(Oracle 11g) 연동 JNDI설정
**** http://skycow79.tistory.com/13


위에처럼 설정했는데
javax.naming.NameNotFoundException: Name jdbc is not bound in this Context
오류 날경우 아래와 같이 수정

server.xml 에 context 태그 내에ResourceLink 를 추가한다.

정정사항)
<Context docBase="jndi" path="/jndi" reloadable="true" source="org.eclipse.jst.jee.server:jndi">
<ResourceLink name="jdbc/rw/myoracle" global="JNDI 이름" type="javax.sql.DataSource"/>
</Context>


--%>