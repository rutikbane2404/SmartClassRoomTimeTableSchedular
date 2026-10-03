package dao;

import java.sql.*;
import model.User;
import util.DBConnection;

public class UserDAO {

	public User login(String email, String password, String role){

	    User user = null;

	    try{

	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT * FROM users WHERE email=? AND password=? AND role=?";

	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, email);
	        ps.setString(2, password);
	        ps.setString(3, role);

	        ResultSet rs = ps.executeQuery();

	        if(rs.next()){

	            user = new User();

	            user.setUserId(rs.getInt("user_id"));
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setRole(rs.getString("role"));
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return user;
	}
}