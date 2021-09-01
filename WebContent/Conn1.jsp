<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
/*************************************************************************************************************
 * 디비연결 셋팅
 *************************************************************************************************************/
//디비연결 변수[게시물]
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
PreparedStatement pstmt = null;

//디비연결 설정 [START]
String url    = "jdbc:oracle:thin:@seiko.diskstation.me:32772:xe"; 
String user   = "PTOPIA";
String passwd = "plan0701";
//디비연결 설정 [END]

/*************************************************************************************************************
 * 디비연결 및 쿼리 질의 [START]
 *************************************************************************************************************/
try{

 Context initCtx = new InitialContext();
 Context envCtx = (Context)initCtx.lookup("java:/comp/env");
 DataSource ds = (DataSource)envCtx.lookup("jdbc/rw/myoracle");

 conn = ds.getConnection();

 //stmt = conn.createStatement();
 //rs = stmt.executeQuery("select count(*) from dual");

 pstmt = conn.prepareStatement("select count(*) as count from EPN_ARTICLE_COMMENT3");
 rs = pstmt.executeQuery();

   
 while(rs.next()){ //레코드를 이동시킨다. 
  out.println("While Test");
  out.println("갯수: "+rs.getInt("count"));
 }

}catch(Exception e){
	System.out.println("오류: "+e);
}finally {
  if (rs != null) try {rs.close(); }catch(SQLException ex) {}
  if (stmt != null) try {stmt.close(); } catch(SQLException ex) {}
  if (conn != null) try {conn.close(); }catch(SQLException ex) {}
}
%>

<!-- 
참고URL : 

JSP + Oracle 연결 테스트 예제 (JNDI) (톰캣셋팅) : http://e2xist.tistory.com/188



 -->
