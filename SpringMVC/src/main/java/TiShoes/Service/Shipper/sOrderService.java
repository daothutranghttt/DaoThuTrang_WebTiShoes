package TiShoes.Service.Shipper;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import TiShoes.Model.Order_;
import TiShoes.Model.Status;
import TiShoes.Model.Voucher;
import TiShoes.Service.User.ConnectService;

public class sOrderService {

	private ConnectService connectService;
	private Order_ order_;
	private Voucher voucher;
	private Status status;

	public boolean take_order(int order_id, int shipper_id) {
		try {
			connectService = new ConnectService();
			Connection conn = connectService.getConnect();
			String query = "update `order_` set `request` = 2, `shipper_id`= ? where id = ?";
			PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
			preparedStmt.setInt(1, shipper_id);
			preparedStmt.setInt(2, order_id);
			preparedStmt.executeUpdate();
			conn.close();
			return true;

		} catch (Exception e) {
			System.err.println("Got an exception 48 s order service! ");
			System.err.println(e.getMessage());
		}
		return false;
	}

	public boolean check_exits_qr_code(int order_id) {
		List<Order_> li = getAllOrder();
		for (Order_ r : li) {
			if (r.getQrcode() != null) {
				if (!r.getQrcode().equals("")) {
					return true;
				}
			}
		}
		return false;
	}

	public List<Order_> getAllOrder() { // all order not delivery
		List<Order_> li = null;
		try {
			connectService = new ConnectService();
			li = new ArrayList<>();
			Connection con = connectService.getConnect();
			Statement stmt;
			stmt = (Statement) con.createStatement();
			ResultSet rs = stmt
					.executeQuery("select * from order_ " + "Inner join voucher on order_.voucher_id = voucher.id "
							+ "Inner join status on order_.status_id = status.id "
							+ "Where status.id = 3 and request = 0 " + "group by order_.id");
			while (rs.next()) {
				order_ = new Order_();
				voucher = new Voucher();
				status = new Status();

				status.setId(rs.getInt("status_id"));
				status.setStatus_name(rs.getString("status_name"));

				voucher.setId(rs.getInt("voucher_id"));
				voucher.setCode(rs.getString("code"));
				voucher.setVcdiscount(rs.getInt("vcdiscount"));
				voucher.setLimit(rs.getInt("limit"));
				voucher.setApplyfor(rs.getInt("applyfor"));
				voucher.setStart_date(rs.getTimestamp("start_date"));
				voucher.setEnd_date(rs.getTimestamp("end_date"));
				voucher.setCreated_at(rs.getTimestamp("created_at"));
				voucher.setUpdated_at(rs.getTimestamp("updated_at"));
				voucher.setDescription(rs.getString("description"));

				order_.setId(rs.getInt("id"));
				order_.setFullname(rs.getString("fullname"));
				order_.setEmail(rs.getString("email"));
				order_.setPhone_number(rs.getString("phone_number"));
				order_.setAddress(rs.getString("address"));
				order_.setOrder_date(rs.getDate("order_date"));
				order_.setUpdated_at(rs.getDate("updated_at"));
				order_.setVoucher(voucher);
				order_.setDiscount_at(rs.getDouble("discount_at"));
				order_.setNote(rs.getString("note"));
				order_.setStatus(status);
				order_.setMethod(rs.getString("method"));
				order_.setBill(rs.getString("bill"));
				order_.setRequest(rs.getInt("request"));
				order_.setQrcode(rs.getString("qrcode"));
				li.add(order_);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return li;
	}

}
