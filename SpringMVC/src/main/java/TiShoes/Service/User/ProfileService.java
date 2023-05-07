package TiShoes.Service.User;

import java.sql.Connection;
import java.util.List;

import com.mysql.jdbc.PreparedStatement;

import TiShoes.Model.User;

public class ProfileService {
	private UserService userService;
	private MD5Service MD5Service;
	private ConnectService connectService;

	public List<User> getAllUser() {
		userService = new UserService();
		return userService.getAllUser();
	}

	public boolean check_pw(String oldpw, User u) {
		MD5Service = new MD5Service();
		if (u.getPassword().trim().equals(MD5Service.StringToMD5(oldpw.trim()))) {
			return true;
		}
		return false;
	}

	public boolean update_pw(String newpw, User u) {
		try {
			MD5Service = new MD5Service();
			newpw = MD5Service.StringToMD5(newpw);
			connectService = new ConnectService();
			Connection conn = connectService.getConnect();
			// check id_prod
			String query = "UPDATE `user` SET `password`= ? WHERE `id` = ?";
			PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
			preparedStmt.setString(1, newpw);
			preparedStmt.setInt(2, u.getId());
			preparedStmt.executeUpdate();
			conn.close();
			return true;
		} catch (Exception e) {
			System.err.println("Got an exception! Update password profileService (43)");
			System.err.println(e.getMessage());
		}
		return false;
	}

	public boolean update_contact(String fullname, String phonenumber, String email, User u) {
		try {
			MD5Service = new MD5Service();
			fullname = MD5Service.decodeText(fullname);
			connectService = new ConnectService();
			Connection conn = connectService.getConnect();
			// check id_prod
			String query = "UPDATE `user` SET `fullname`= ?, `phone_number`= ?, `email`= ? WHERE `id` = ?";
			PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
			preparedStmt.setString(1, fullname);
			preparedStmt.setString(2, phonenumber);
			preparedStmt.setString(3, email);
			preparedStmt.setInt(4, u.getId());
			preparedStmt.executeUpdate();
			conn.close();
			return true;
		} catch (Exception e) {
			System.err.println("Got an exception! Update password profileService (68)");
			System.err.println(e.getMessage());
		}
		return false;
	}

	public boolean update_address(String address, String district, String city, User u) {
		try {
			MD5Service = new MD5Service();
			address = MD5Service.decodeText(address);
			district = MD5Service.decodeText(district);
			city = MD5Service.decodeText(city);
			String adr = address + " - " + district + " - " + city;
			connectService = new ConnectService();

			Connection conn = connectService.getConnect();
			// check id_prod
			String query = "UPDATE `user` SET `address`= ? WHERE `id` = ?";
			PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
			preparedStmt.setString(1, adr);
			preparedStmt.setInt(2, u.getId());
			preparedStmt.executeUpdate();
			conn.close();
			return true;
		} catch (Exception e) {
			System.err.println("Got an exception! Update password profileService (93)");
			System.err.println(e.getMessage());
		}
		return false;
	}

}
