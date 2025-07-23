package com.tca.student;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddStudent")
public class AddStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher rd = request.getRequestDispatcher("Add.jsp");//This does'nt reveal the Add.jsp file in URL as it is called internally by request
		rd.forward(request, response);
		//OR
		//response.sendRedirect("Add.jsp"); but this reveals the Add.jsp file in URL which is not preferred
		
	}
	
    //It is used to save user data into 'student' table
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		PreparedStatement ps= null;
		
		final String DB_URL="jdbc:postgresql://localhost/ajdb19";
		final String DB_USER="root";
		final String DB_PWD="root@123";
		
		//Fetching values from input form(request object)
		int rno = Integer.parseInt(request.getParameter("rno"));
		String name= request.getParameter("name");
		double per = Double.parseDouble(request.getParameter("per"));
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String message="";
		
		try {
			Class.forName("org.postgresql.Driver");
			con=DriverManager.getConnection(DB_URL,DB_USER,DB_PWD);
			con.setAutoCommit(false);
			
			ps=con.prepareStatement("INSERT INTO STUDENT VALUES(?,?,?)");
			ps.setInt(1, rno);
			ps.setString(2, name);
			ps.setDouble(3, per);
			ps.executeUpdate();
			
			con.commit();
			message="<div class='alert alert-success mt-3 text-center container role='alert'>Record is saved successfully for Roll Number :"+rno+"</div>";
			
		}
		catch(Exception e) {
			//e.printStackTrace();
			
			try {
				con.rollback();
				
			} catch (SQLException e1) {
				
				//e1.printStackTrace();
			}
			
			message ="<div class=\"alert alert-danger mt-3 text-center container role=\"alert\">Unable to Save Record for Roll Number :"+rno+"</div>";
			
		}
		finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				///e.printStackTrace();
				message="Unable to Save Record for Roll Number :"+rno;
			}
			
		}
		//--------------------------------------------
		request.setAttribute("msg", message);
		
		RequestDispatcher rd = request.getRequestDispatcher("Add.jsp");
		rd.forward(request, response);
		out.println(message);
	}

}
	
