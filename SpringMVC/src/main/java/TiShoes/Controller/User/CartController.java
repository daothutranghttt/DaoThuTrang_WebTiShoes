package TiShoes.Controller.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Cart;
import TiShoes.Model.Color_size;
import TiShoes.Service.User.CartService;
import TiShoes.Service.User.CheckoutService;
import TiShoes.Service.User.ColorService;
import TiShoes.Service.User.Color_sizeService;
import TiShoes.Service.User.StyleService;
import TiShoes.Service.User.UserService;

@Controller
public class CartController {
	private CartService cartService;
	private Color_sizeService color_sizeService;
	private ColorService colorService;
	private UserService userService;
	private CheckoutService checkoutService;
	private StyleService styleService;

	@RequestMapping(value = { "/cart/{id}" })
	public ModelAndView loadCartByUserID(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/cart-user");

		cartService = new CartService();
		color_sizeService = new Color_sizeService();
		colorService = new ColorService();
		userService = new UserService();
		styleService = new StyleService();

		String size = request.getParameter("size");
		String color = request.getParameter("color");
		String plus = request.getParameter("plus");
		String minus = request.getParameter("minus");
		String del_prod = request.getParameter("delete");
		String delete = request.getParameter("minusdelete");

		if (size != null) {
			if (cartService.update_size_in_cart_by_string(size)) {
				System.out.println("size: " + size);
			}
		}

		if (color != null) {
			if (cartService.update_color_in_cart_by_string(color)) {
				System.out.println("color: " + color);
			}
		}

		if (plus != null) {
			if (cartService.plus_product_in_cart_by_cart_id(Integer.parseInt(plus))) {
				System.out.println("plus: " + plus);
			}
		}
		if (minus != null && delete == null) {
			if (cartService.minus_product_in_cart_by_cart_id(Integer.parseInt(minus))) {
				System.out.println("minus: " + minus);
			}
		} else if (minus != null && delete != null) {
			if (cartService.minus_product_in_cart_by_cart_id(Integer.parseInt(minus))) {
				System.out.println("minus: " + minus);
			}
		}
		if (del_prod != null) {
			if (cartService.delete_cart_by_cart_id(Integer.parseInt(del_prod))) {
				System.out.println("delete: " + del_prod);
			}
		}
		// information to display in cart
		List<Cart> li = cartService.getAllCart();
		List<Cart> li_c = new ArrayList<>();
		for (Cart cart : li) {
			if (cart.getUser().getId() == Integer.parseInt(id)) {
				li_c.add(cart);
			}
		}
		if (li_c.size() > 0) {
			mv.addObject("cart", li_c);
		}
		if (!colorService.getAllColor().isEmpty()) {
			mv.addObject("listAllColor", colorService.getAllColor());
		}
		if (!color_sizeService.getCS().isEmpty()) {
			mv.addObject("hmProd_Color_Size", color_sizeService.getCS());
		}

		int id_ = Integer.parseInt(id);

		mv.addObject("style", styleService.getAllStyle());
		mv.addObject("userID", id_);
		mv.addObject("user_id", id_);
		mv.addObject("avatar", userService.getAvatarByUserID(Integer.parseInt(id)));
		return mv;
	}

	@RequestMapping(value = { "/cart" })
	public ModelAndView loadCart(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/cart");

		color_sizeService = new Color_sizeService();
		colorService = new ColorService();
		cartService = new CartService();
		checkoutService = new CheckoutService();
		styleService = new StyleService();

		String size = request.getParameter("size");
		String color = request.getParameter("color");
		String amount = request.getParameter("amount");
		String plus = request.getParameter("plus");
		String minus = request.getParameter("minus");
		String del_prod = request.getParameter("delete");
		String delete = request.getParameter("minusdelete");
		String process = request.getParameter("process");
		String process_delete = request.getParameter("process-delete");
		String order_id = request.getParameter("order-id");
		String id = request.getParameter("id");

		List<String> li = new LinkedList<>();
		Cookie arr[] = request.getCookies();
		if (arr != null) {
			for (Cookie o : arr) {
				li.add(o.getName());
			}
		}
		System.out.println(li);

		String txt = "";
		int csid = 0;
		if (id != null && amount == null && process == null) {
			csid = color_sizeService.firstColor_SizeById_Prod(Integer.parseInt(id));
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart") && csid != 0) {
					
					if (check_csid_addtocart(o.getValue(), csid, 1).equals("")) {
						txt = String.valueOf(csid) + "/" + o.getValue();
						o.setValue(txt);
						response.addCookie(o);
						System.out.println("here 153");
					} else {
						txt = check_csid_addtocart( o.getValue(), csid, 1);
						o.setValue(txt);
						response.addCookie(o);
						System.out.println("here 158");
					}
				} else if (!li.contains("addtocart") && csid != 0) {
					Cookie cart = new Cookie("addtocart", String.valueOf(csid));
					cart.setMaxAge(60 * 60 * 24);
					response.addCookie(cart);
					System.out.println("here 156: ---- " + csid);
				}
			}
		}

		if (process != null && amount != null && id != null) {
			int size_id = 0;
			int color_id = 0;
			int prod_id = 0;
			if (process.split("_").length > 2) {
				size_id = Integer.parseInt(process.split("_")[2]);
				color_id = Integer.parseInt(process.split("_")[1]);
				prod_id = Integer.parseInt(process.split("_")[0]);
				csid = color_sizeService.get_Color_size_id(size_id, color_id, prod_id);
			}
			String nCsid = "";
			for (int i = 0; i < Integer.parseInt(amount); i++) {
				if (i == 0) {
					nCsid = String.valueOf(csid);
				} else {
					nCsid += "/" + String.valueOf(csid);
				}
			}
			if (!li.contains("addtocart")) {
				Cookie cart = new Cookie("addtocart", nCsid);
				cart.setMaxAge(60 * 60 * 24);
				response.addCookie(cart);
				System.out.println("here 184");
			} else {
				if (arr != null && csid != 0) { // add to cart
					for (Cookie o : arr) {
						if (o.getName().equals("addtocart") && li.contains("addtocart")) {
							System.out.println(o.getValue()+"=="+csid);
							if (check_csid_addtocart(o.getValue(), csid, Integer.parseInt(amount)).equals("")) {
								txt = nCsid + "/" + o.getValue();
								o.setValue(txt);
								response.addCookie(o);
							} else {
								txt = check_csid_addtocart(o.getValue(), csid, Integer.parseInt(amount));
								o.setValue(txt);
								response.addCookie(o);
							}
						}
					}
					System.out.println("here 194");
				}
			}

		}
		if (process != null) {
			System.out.println("process: " + process);
		}

		if (process_delete != null && order_id != null) {
			System.out.println("process: " + process_delete);
			HashMap<Color_size, Integer> hm_delete = checkoutService
					.get_list_color_size_qty_by_string_process(process_delete);
			for (Color_size c : hm_delete.keySet()) {
				for (Cookie o : arr) {
					if (o.getName().equals("addtocart")) {
						String cook = cartService.delete_prod_in_cart_not_login(String.valueOf(c.getId()),
								o.getValue());
						o.setValue(cook);
						response.addCookie(o);
					}
				}
			}
			return new ModelAndView("redirect: /SpringMVC/thank/" + order_id);
		}

		if (size != null) { // change size
			System.out.println("size: " + size);
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					String cook = cartService.change_size_in_cart_not_login(size, o.getValue());
					o.setValue(cook);
					response.addCookie(o);
				}
			}
		}

		if (color != null) { // change color
			System.out.println("color: " + color);
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					String cook = cartService.change_color_in_cart_not_login(color, o.getValue());
					o.setValue(cook);
					response.addCookie(o);
				}
			}
		}

		if (amount != null) {
			System.out.println("amount: " + amount);
		}

		if (plus != null) { // plus
			System.out.println("plus: " + plus);
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					txt = o.getValue() + "/" + String.valueOf(plus);
					o.setValue(txt);
					response.addCookie(o);
				}
			}
		}
		if (minus != null) {
			System.out.println("minus: " + minus);
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					String cook = cartService.Minus_Prod_Card(minus, o.getValue());
					o.setValue(cook);
					response.addCookie(o);
				}
			}
		}
		if (delete != null) {
			System.out.println("delete minus: " + delete);
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					String cook = cartService.delete_prod_in_cart_not_login(delete, o.getValue());
					o.setValue(cook);
					response.addCookie(o);
				}
			}

		}
		if (del_prod != null) {
			System.out.println("delete: " + del_prod);
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					String cook = cartService.delete_prod_in_cart_not_login(del_prod, o.getValue());
					o.setValue(cook);
					response.addCookie(o);
				}
			}
		}

		for (Cookie o : arr) {
			if (o.getName().equals("addtocart")) {
				if (o.getValue().equals("") || o.getValue().equals("0")) {
					o.setValue("");
					o.setMaxAge(0);
					response.addCookie(o);
				}
				HashMap<Color_size, Integer> hm = color_sizeService.get_list_color_size_by_string(o.getValue());
				mv.addObject("listCart", hm);
			}
		}

		for (Cookie o : arr) {
			System.out.println(o.getName() + "===" + o.getValue());
		}

		if (!colorService.getAllColor().isEmpty()) {
			mv.addObject("listAllColor", colorService.getAllColor());
		}
		if (!color_sizeService.getCS().isEmpty()) {
			mv.addObject("hmProd_Color_Size", color_sizeService.getCS());
		}
		mv.addObject("style", styleService.getAllStyle());
		return mv;
	}

	@RequestMapping(value = { "/add-to-cart/{id}" })
	public void add_to_cart(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
		cartService = new CartService();
		color_sizeService = new Color_sizeService();

		String process = request.getParameter("process");
		Cookie arr[] = request.getCookies();
		List<String> li = new ArrayList<>();
		for (Cookie o : arr) {
			li.add(o.getValue());
		}
		String a[] = id.split("_");

		System.out.println(a.length);

		if (a.length > 2) {
			if (process != null) {
				String id_user = a[0];
				String id_prod = a[1];
				String qty = a[2];
				int id_color_size = color_sizeService.get_Color_size_id(Integer.parseInt(process.split("_")[2]),
						Integer.parseInt(process.split("_")[1]), Integer.parseInt(process.split("_")[0]));
				if (id_user != "" && id_prod != "") {
					cartService.insertIntoCartDB(Integer.parseInt(qty), id_color_size, Integer.parseInt(id_user));
				}
			} else {
				String id_user = a[0];
				String id_prod = a[1];
				String qty = a[2];
				int id_color_size = color_sizeService.firstColor_SizeById_Prod(Integer.parseInt(id_prod));
				if (id_user != "" && id_prod != "") {
					cartService.insertIntoCartDB(Integer.parseInt(qty), id_color_size, Integer.parseInt(id_user));
				}
			}
		} else if (a.length > 1) {
			String id_user = a[0];
			String id_prod = a[1];
			int id_color_size = color_sizeService.firstColor_SizeById_Prod(Integer.parseInt(id_prod));
			if (id_user != "" && id_prod != "") {
				cartService.insertIntoCartDB(1, id_color_size, Integer.parseInt(id_user));
			}
		}
	}

	public String check_csid_addtocart(String str, int id, int amount) {
		color_sizeService = new Color_sizeService();
		String rs = "";
		String arr[] = str.split("/");
		Color_size cs = color_sizeService.getByIdCS(id);
		boolean check = false;
		for (String s : arr) {
			if(!s.equals("")) {
				Color_size nCs = color_sizeService.getByIdCS(Integer.parseInt(s));
				if (nCs.getProd().getId() == cs.getProd().getId()) {
					rs = str.replaceAll(s, String.valueOf(id));
					check = true;
					break;
				} else {
					check = false;
				}
			}
		}
		if (check) {
			for (int i = 0; i < amount; i++) {
				rs = String.valueOf(id) + "/" + rs;
			}
		}
		return rs;
	}
}
