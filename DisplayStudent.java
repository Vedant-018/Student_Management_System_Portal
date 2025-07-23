package com.tca.student;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tca.entites.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DisplayStudent")
public class DisplayStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		Connection con =null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		final String DB_URL="jdbc:postgresql://localhost/ajdb19";
		final String DB_USER="root";
		final String DB_PWD= "root@123";
		
		String qry="select * from student";
		
		
		String trno=request.getParameter("rno");
		String sbtn=request.getParameter("sbtn");
		
		if(sbtn==null) {
			
			qry="select * from student order by rno";
		}
		else if(sbtn.equals("Refresh")) {
			
			qry="select * from student order by rno";
		}
		else if(sbtn.equals("Search")) {
			
			qry="select * from student where rno = "+trno+"order by rno";
		}
		
		List<Student> L = new ArrayList();
		try {
			Class.forName("org.postgresql.Driver");
			con=DriverManager.getConnection(DB_URL,DB_USER,DB_PWD);
			ps=con.prepareStatement(qry);
			rs=ps.executeQuery();
			
			
			while(rs.next()) {
				int rno=rs.getInt("rno");
				String name=rs.getString("name");
				double per=rs.getDouble("per");
				
				Student S =new Student(rno,name,per);
				
				L.add(S);
	
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			L=null;
		}
		finally {
			
			
			try {
				con.close();
				rs.close();
			} catch (Exception e) {
				
				e.printStackTrace();
				L=null;
			}
		}
		
        request.setAttribute("listofstudents", L);
		
		RequestDispatcher rd = request.getRequestDispatcher("Display.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request,response);
	}


}
