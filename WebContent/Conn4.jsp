<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%

    // JNDI 부터 DataSource 얻자
    Context ctx = new InitialContext();
    DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/rw/myoracle");
 
    Connection conn = null;
    Statement stmt = null;
 
    try {
        // 데이터소스와 DB연결해서 명령객체를 가지고 오자.
        conn = ds.getConnection();
        stmt = conn.createStatement();
    
        // 쿼리문 실행
        try {
    
            // Create a statement and execute the query on it
            stmt.execute("select * from EPN_ARTICLE_COMMENT3");
    
            // 결과레코드및 메타데이터
            ResultSet r = stmt.getResultSet();
            while (r.next()) {
                    out.println("<BR />" + r.getInt("COMMENT_ID")); 
                    out.println("<BR />" + r.getString("CONTENT"));               
            }
    
            // Clean up
            stmt.close();
            conn.close();
    
        } catch (SQLException se) {
            out.println(se.toString());
        } catch (Exception e) {
            out.println(e.toString());
        }
    
    } finally {
       
        try { if(stmt != null) stmt.close(); } catch (Exception e) {}
        try { if(conn != null) conn.close(); } catch (Exception e) {}
    }
%>