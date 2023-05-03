package TiShoes.Service.Shipper;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import TiShoes.Model.Order_;
import TiShoes.Model.Status;
import TiShoes.Model.User;
import TiShoes.Model.Voucher;
import TiShoes.Service.User.ConnectService;
import TiShoes.Service.User.OrderService;

public class sDeliveryService {

	private ConnectService connectService;
	private Order_ order_;
	private Voucher voucher;
	private Status status;
	private User shipper;
	private OrderService orderService;

	public List<Order_> getAllOrder_by_shipper_id(int shipper_id) {
		List<Order_> li = null;
		try {
			connectService = new ConnectService();
			li = new ArrayList<>();
			Connection con = connectService.getConnect();
			Statement stmt;
			stmt = (Statement) con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from order_ "
					+ "Inner join voucher on order_.voucher_id = voucher.id "
					+ "Inner join status on order_.status_id = status.id "
					+ "Inner join user on order_.shipper_id = user.id "
					+ "Where request = 2 and shipper_id = "+ shipper_id + " group by order_.id");
			while (rs.next()) {
				order_ = new Order_();
				voucher = new Voucher();
				status = new Status();
				shipper = new User();
				
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

				shipper.setId(rs.getInt("shipper_id"));
				
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
				order_.setShipper(shipper);
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
	public List<Order_> search_order_by_string(String txt, int shipper_id) {
		List<Order_> li = new LinkedList<>();
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		for (Order_ o : get) {
			if (o.getFullname().toLowerCase().trim().contains(txt.toLowerCase().trim())
					|| o.getPhone_number().toLowerCase().trim().equals(txt.toLowerCase().trim())
					|| o.getEmail().toLowerCase().trim().contains(txt.toLowerCase().trim())
					|| o.getAddress().toLowerCase().trim().contains(txt.toLowerCase().trim())) {
				li.add(o);
			}
		}
		return li;
	}

	// sort by id - asc
	public List<Order_> sort_by_id_asc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o1.getId() - o2.getId();
			}
		});
		return get;
	}

	// sort by id - desc
	public List<Order_> sort_by_id_desc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getId() - o1.getId();
			}
		});
		return get;
	}

	// sort by fullname - asc
	public List<Order_> sort_by_fullname_asc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			Collator collator = Collator.getInstance(new Locale("vi", "VN"));

			@Override
			public int compare(Order_ o1, Order_ o2) {
				return collator.compare(o1.getFullname(), o2.getFullname());
			}
		});
		return get;
	}

	// sort by fullname - desc
	public List<Order_> sort_by_fullname_desc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			Collator collator = Collator.getInstance(new Locale("vi", "VN"));

			@Override
			public int compare(Order_ o1, Order_ o2) {
				return collator.compare(o2.getFullname(), o1.getFullname());
			}
		});
		return get;
	}

	// sort by email - asc
	public List<Order_> sort_by_email_asc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o1.getEmail().compareToIgnoreCase(o2.getEmail());
			}
		});
		return get;
	}

	// sort by email - desc
	public List<Order_> sort_by_email_desc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getEmail().compareToIgnoreCase(o1.getEmail());
			}
		});
		return get;
	}

	// sort by address - asc
	public List<Order_> sort_by_address_asc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			Collator collator = Collator.getInstance(new Locale("vi", "VN"));

			@Override
			public int compare(Order_ o1, Order_ o2) {
				return collator.compare(o1.getAddress(), o2.getAddress());
			}
		});
		return get;
	}

	// sort by address - desc
	public List<Order_> sort_by_address_desc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			Collator collator = Collator.getInstance(new Locale("vi", "VN"));

			@Override
			public int compare(Order_ o1, Order_ o2) {
				return collator.compare(o2.getAddress(), o1.getAddress());
			}
		});
		return get;
	}

	// sort by order_date - asc
	public List<Order_> sort_by_order_date_asc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o1.getOrder_date().compareTo(o2.getOrder_date());
			}
		});
		return get;
	}

	// sort by order_date - desc
	public List<Order_> sort_by_order_date_desc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getOrder_date().compareTo(o1.getOrder_date());
			}
		});
		return get;
	}

	// sort by status - asc
	public List<Order_> sort_by_status_asc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o1.getStatus().getStatus_name().compareToIgnoreCase(o2.getStatus().getStatus_name());
			}
		});
		return get;
	}

	// sort by status - desc
	public List<Order_> sort_by_status_desc(int shipper_id) {
		List<Order_> get = getAllOrder_by_shipper_id(shipper_id);
		Collections.sort(get, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getStatus().getStatus_name().compareToIgnoreCase(o1.getStatus().getStatus_name());
			}
		});
		return get;
	}
	
	public boolean canceled_order(int order_id) {
		try {
			connectService = new ConnectService();
			Connection conn = connectService.getConnect();
			String query = "update `Order_` set `request` = 0 where id = ?";
			PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
			preparedStmt.setInt(1, order_id);
			preparedStmt.executeUpdate();
			conn.close();
			return true;
		} catch (Exception e) {
			System.err.println("canceled order shipper error! ");
			System.err.println(e.getMessage());
		}
		return false;
	}
	
	public boolean delivered (int order_id) {
		try {
			connectService = new ConnectService();
			Connection conn = connectService.getConnect();
			String query = "update `Order_` set `request` = 0, `status_id` = 5 where id = ?";
			PreparedStatement preparedStmt = (PreparedStatement) conn.prepareStatement(query);
			preparedStmt.setInt(1, order_id);
			preparedStmt.executeUpdate();
			conn.close();
			return true;
		} catch (Exception e) {
			System.err.println("delivered this order shipper success! ");
			System.err.println(e.getMessage());
		}
		return false;
	}
	
	public boolean check_Order_ (int order_id) {
		orderService = new OrderService();
		Order_ r = orderService.get_all_order_by_order_id(order_id);
		if(r != null) {
			if(r.getStatus().getId()==4 && r.getQrcode() != null && r.getShipper().getId() != 0) {
				System.out.println(r.getId());
				return true;
			} else {
				System.out.println(r.getQrcode());
			}
		}
		return false;
	}
	
	public static void main(String[] args) {
		sDeliveryService s = new sDeliveryService();
		System.out.println(s.check_Order_(94));
	}
}

