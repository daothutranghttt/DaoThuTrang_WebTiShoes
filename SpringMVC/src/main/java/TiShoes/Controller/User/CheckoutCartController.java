package TiShoes.Controller.User;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Cart;
import TiShoes.Model.Color_size;
import TiShoes.Model.User;
import TiShoes.Service.Admin.aStatisticsService;
import TiShoes.Service.User.CartService;
import TiShoes.Service.User.CheckoutService;
import TiShoes.Service.User.Color_sizeService;
import TiShoes.Service.User.OrderService;
import TiShoes.Service.User.Order_detailsService;
import TiShoes.Service.User.ProductService;
import TiShoes.Service.User.StatisticsService;
import TiShoes.Service.User.VoucherService;
import TiShoes.Service.User.Voucher_saveService;

@Controller
public class CheckoutCartController {
	private VoucherService voucherService;
	private Order_detailsService order_detailsService;
	private OrderService orderService;
	private CartService cartService;
	private CheckoutService checkoutService;
	private Color_sizeService color_sizeService;
	private ProductService productService;
	private StatisticsService statisticsService;
	private Voucher_saveService voucher_saveService;

	@RequestMapping(value = { "cart/checkout/user-cart/{id}" })
	public ModelAndView checkout_ok_cart(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		order_detailsService = new Order_detailsService();
		orderService = new OrderService();
		voucherService = new VoucherService();
		cartService = new CartService();
		color_sizeService = new Color_sizeService();
		productService = new ProductService();
		statisticsService = new StatisticsService();
		voucher_saveService = new Voucher_saveService();

		HttpSession session = request.getSession();

		String fullname = request.getParameter("fullname");
		String phone_number = request.getParameter("phone");
		String email = request.getParameter("email");
		String city = request.getParameter("city");
		String town = request.getParameter("town");
		String village = request.getParameter("village");
		String note = request.getParameter("note");
		String method = request.getParameter("method");
		String vccode = request.getParameter("vccode");
		String vchid = request.getParameter("vchid");
		int vc_id = 1;
		if (vccode != null) {
			vc_id = voucherService.getVoucherIdByCode(vccode);

		}
		if (vchid != null) {
			if (!vchid.equals("")) {
				vc_id = Integer.parseInt(vchid);
				System.out.println("vchid (69): " + vchid);
			}
		}
		if (note == null) {
			note = "";
		}
		if (method == null) {
			method = "COD";
		}
		double total = 0;
		List<Cart> liCart = cartService.get_all_cart_by_string(id);
		User u = null;
		if (liCart.size() > 0) {
			for (Cart cart : liCart) {
				// calculator total product price
				if (cart.getColor_size().getProd().getDiscount() > 0) {
					total += cart.getColor_size().getProd().getPrice() * cart.getQuantity()
							- cart.getColor_size().getProd().getPrice() * cart.getQuantity()
									* cart.getColor_size().getProd().getDiscount() / 100;
				} else {
					total += cart.getColor_size().getProd().getPrice() * cart.getQuantity();
				}
				u = cart.getUser();
			}
		}
		int vch_discount = voucherService.getDiscountById_Voucher(vc_id);
		double dis = 0;
		if (vch_discount > 0) {
			dis = (double) Math.round(vch_discount * total) / 100;
		}

		if (method != null) {
			phone_number = u.getPhone_number();
		}

		if (city != null && town != null && village != null && fullname != null && phone_number != null
				&& email != null) {
			String address = city + " - " + town + " - " + village;
			if (vc_id == 0) {
				vc_id = 1;
			}
			if (orderService.insertIntoOrder(fullname, email, phone_number, address, vc_id, note, method, dis)
					&& statisticsService.update_order_num_in_statistics_DB()) {
				if (vc_id != 1) {
					voucherService.update_limit_voucher(vc_id);
				}
				if (vch_discount == 0) {
					vch_discount = 1;
				}
				for (Cart cart : liCart) {
					double price_at = 0;
					if (cart.getColor_size().getProd().getDiscount() > 0) {
						price_at = cart.getColor_size().getProd().getPrice() - cart.getColor_size().getProd().getPrice()
								* cart.getColor_size().getProd().getDiscount() / 100;
					} else {
						price_at = cart.getColor_size().getProd().getPrice();
					}
					if (order_detailsService.insertIntoOrder_details(price_at, cart.getQuantity(),
							cart.getColor_size().getProd().getId(), cart.getColor_size().getSize().getId(),
							cart.getColor_size().getColor().getId(), phone_number, email)
							&& color_sizeService.updateColor_size_Quantity(cart.getColor_size().getSize().getId(),
									cart.getColor_size().getColor().getId(), cart.getColor_size().getProd().getId(),
									cart.getQuantity())
							&& productService.updateProduct_Sold(cart.getColor_size().getProd().getId(),
									cart.getQuantity())
							&& cartService.delete_cart_by_cart_id(cart.getId())
							&& voucher_saveService.update(cart.getUser().getId(), vc_id)) {
						if (!method.equals("COD")) {
							statisticsService.update_revenue_product_num_in_statistics_DB(1,
									price_at * cart.getQuantity());
						}
					}
				}
				int order_id = orderService.get_last_order_id_by(phone_number, email);
				System.out.println("buy cart success this checkout cart controller");
				System.out.println(vc_id + "_" + method);

				if (!method.equals("COD")) {
					if (dis != 0.0) {
						if (total < 50) {
							statisticsService.update_revenue_product_num_in_statistics_DB(0, -dis + 11.00);
						} else {
							statisticsService.update_revenue_product_num_in_statistics_DB(0, -dis);
						}

					}
				}

				return new ModelAndView("redirect: /SpringMVC/thank/" + order_id);
			} else {
				System.out.println("buy cart unsuccess this");
				return new ModelAndView("redirect: /SpringMVC/cart/checkout-cart/" + id);
			}
		}
		return null;
	}

	@RequestMapping(value = { "checkout-cart" })
	public ModelAndView checkout_cart_not_login(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/checkout-cart");

		checkoutService = new CheckoutService();

		String process = String.valueOf(request.getParameter("process"));

		String fullname = String.valueOf(request.getParameter("fullname"));
		String phone_number = String.valueOf(request.getParameter("phone"));
		String email = String.valueOf(request.getParameter("email"));
		String city = request.getParameter("city");
		String town = request.getParameter("town");
		String village = request.getParameter("village");
		String note = String.valueOf(request.getParameter("note"));
		String method = String.valueOf(request.getParameter("method"));
		String address = city + " - " + town + " - " + village;

		HashMap<Color_size, Integer> hm = checkoutService.get_list_color_size_qty_by_string_process(process);

		mv.addObject("listCart", hm);

		if (method.equals("null")) {
			method = "COD";
		}

		double totalPayment = checkoutService.get_total_by_string_process(process);

		mv.addObject("totalPayment", totalPayment);
		mv.addObject("process", process);
		// back home
		mv.addObject("back_home", "cart");

		return mv;
	}

	@RequestMapping(value = { "checkout-cart/ok" })
	public ModelAndView checkout_cart_not_login_ok(HttpServletRequest request, HttpServletResponse response) {

		checkoutService = new CheckoutService();
		orderService = new OrderService();
		order_detailsService = new Order_detailsService();
		color_sizeService = new Color_sizeService();
		statisticsService = new StatisticsService();
		String process = String.valueOf(request.getParameter("process"));

		String fullname = request.getParameter("fullname");
		String phone_number = request.getParameter("phone");
		String email = request.getParameter("email");
		String city = request.getParameter("city");
		String town = request.getParameter("town");
		String village = request.getParameter("village");
		String note = request.getParameter("note");
		String method = request.getParameter("method");
		String address = city + " - " + town + " - " + village;
		HashMap<Color_size, Integer> hm = checkoutService.get_list_color_size_qty_by_string_process(process);
		if (method == null) {
			method = "COD";
		}

		if (city != null && town != null && village != null && fullname != null && phone_number != null
				&& email != null) {
			if (orderService.insertIntoOrder(fullname, email, phone_number, address, 1, note, method, 0)
					&& statisticsService.update_order_num_in_statistics_DB()) {
				for (Color_size c : hm.keySet()) {
					double price_at = 0;
					if (c.getProd().getDiscount() > 0) {
						price_at = c.getProd().getPrice() - c.getProd().getPrice() * c.getProd().getDiscount() / 100;
					} else {
						price_at = c.getProd().getPrice();
					}
					if (order_detailsService.insertIntoOrder_details(price_at, hm.get(c), c.getProd().getId(),
							c.getSize().getId(), c.getColor().getId(), phone_number, email)
							&& color_sizeService.updateColor_size_Quantity(c.getSize().getId(), c.getColor().getId(),
									c.getProd().getId(), hm.get(c))
							&& productService.updateProduct_Sold(c.getProd().getId(), hm.get(c))) {

					}
				}
				int order_id = orderService.get_last_order_id_by(phone_number, email);
				System.out.println("buy cart success this checkout cart controller (192)");
				return new ModelAndView(
						"redirect: /SpringMVC/cart?process-delete=" + process + "&order-id=" + order_id);
			} else {
				System.out.println("buy cart unsuccess this");
				return new ModelAndView("redirect: /SpringMVC/checkout-cart?process=" + process);
			}
		}
		return null;
	}
}
