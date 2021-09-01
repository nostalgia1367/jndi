<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	//===================================================
	//디비연결 변수
	//---------------------------------------------------
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	//===================================================

	//===================================================
	//쿼리 생성
	//---------------------------------------------------
	String query = " SELECT 'RESULT' FROM DUAL ";

	//---------------------------------------------------

	try {
		//===================================================
		// Oracle Connection Start
		//---------------------------------------------------
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:/comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/rw/myoracle");

		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		//===================================================

		while (rs.next()) { // 쿼리 결과 보여주기
			String rs_str = rs.getString(1);
			out.println(rs_str);
		}

	} catch (SQLException se) {
		out.println("[CONTENT]쿼리 에러 : SQLException ");
	} catch (NullPointerException ne) {
		out.println("[CONTENT]널 에러 : NullPointerException ");
	} catch (Exception e) {
		out.println("[CONTENT]에러 : Exception ");
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>