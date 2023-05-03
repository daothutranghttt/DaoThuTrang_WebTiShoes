package TiShoes.Controller.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Voucher;
import TiShoes.Service.User.ColorService;
import TiShoes.Service.User.ProductService;
import TiShoes.Service.User.SizeService;
import TiShoes.Service.User.StyleService;
import TiShoes.Service.User.UserService;
import TiShoes.Service.User.VoucherService;
import TiShoes.Service.User.Voucher_saveService;

@Controller
public class VoucherController {

	private UserService userService;
	private ProductService productService;
	private StyleService styleService;
	private SizeService sizeService;
	private ColorService colorService;
	private VoucherService voucherService;
	private Voucher_saveService voucher_saveService;

	@RequestMapping(value = { "voucher/{id}" })
	public ModelAndView loadVoucher(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/voucher");

		productService = new ProductService();
		styleService = new StyleService();
		sizeService = new SizeService();
		colorService = new ColorService();
		userService = new UserService();
		voucherService = new VoucherService();

		HashMap<String, String> hm = new HashMap<>();
		List<String> li = null;
		String txt = "";

		String addtocart = request.getParameter("add-to-cart");
		String price = String.valueOf(request.getParameter("price"));
		String stylename = String.valueOf(request.getParameter("stylename"));
		String sortby = String.valueOf(request.getParameter("sortby"));
		String size = String.valueOf(request.getParameter("size"));
		String rate = String.valueOf(request.getParameter("rate"));
		String color = String.valueOf(request.getParameter("color"));
		String gender = String.valueOf(request.getParameter("gender"));

		Cookie arr[] = request.getCookies();
		if (arr != null) {
			li = new ArrayList<>();
			for (Cookie o : arr) {
				li.add(o.getName());
			}
		}
		if (arr != null) {
			for (Cookie o : arr) {
				if (o.getName().equals("addtocart")) {
					if (addtocart != null) {
						txt = o.getValue() + "/" + addtocart;
						o.setValue(txt);
						o.setMaxAge(60 * 60 * 24);
						response.addCookie(o);
						return new ModelAndView("redirect:/cart");
					}

				} else if (!li.contains("addtocart")) {
					if (addtocart != null) {
						Cookie cart = new Cookie("addtocart", addtocart);
						cart.setMaxAge(60 * 60 * 24);
						response.addCookie(cart);
						return new ModelAndView("redirect:/cart");
					}
				}
			}
		}

		// keep value when selectif(!size.equals("null")) {
		if (!sortby.equals("null")) {
			mv.addObject("selectedSortBy", sortby);
			hm.put("sortby", sortby);
			System.out.println(sortby);
		}
		if (!price.equals("null")) {
			mv.addObject("checkedPrice", price);
			hm.put("price", price);
		}
		if (!stylename.equals("null")) {
			mv.addObject("checkedStyleName", stylename);
			hm.put("stylename", stylename);
		}
		if (!rate.equals("null")) {
			mv.addObject("checkedRate", rate);
			hm.put("rate", rate);
		}
		if (!gender.equals("null")) {
			mv.addObject("checkedGender", gender);
			hm.put("gender", gender);
		}
		if (!size.equals("null")) {
			mv.addObject("checkedSize", productService.getSizeCheckedByString(size));
			hm.put("size", size);
		}
		if (!color.equals("null")) {
			mv.addObject("checkedColor", productService.getColorCheckedByString(color));
			hm.put("color", color);
		}

		mv.addObject("color", colorService.getAllColor());
		mv.addObject("listSize", sizeService.getAllSize());
		mv.addObject("style", styleService.getAllStyle());

		if (color.equals("null") && size.equals("null") && gender.equals("null") && sortby.equals("null")
				&& price.equals("null") && stylename.equals("null") && rate.equals("null")) {
			if (productService.getAllProducts().size() == 0) {
				mv.addObject("listProducts", "");
			} else {
				mv.addObject("listProducts", productService.getAllProducts());
			}
		} else {
			if (!productService.getAllProductsColorSize(hm).isEmpty()) {
				if (productService.getAllProductsColorSize(hm).size() == 0) {
					mv.addObject("listProducts", "");
				} else {
					mv.addObject("listProducts", productService.getAllProductsColorSize(hm));
				}
			}
		}

		mv.addObject("userID", id);
		int id_user = Integer.parseInt(id);
		mv.addObject("id_user", id_user);
		mv.addObject("avatar", userService.getAvatarByUserID(Integer.parseInt(id)));

		HashMap<Voucher, Integer> rs = voucherService.get_expiry_date();

		mv.addObject("listVoucher", rs);
		return mv;
	}

	@RequestMapping(value = { "voucher/save/{id}_{id_vc}" })
	public ModelAndView save_oucher(@PathVariable("id") String id, @PathVariable("id_vc") String id_vc,
			HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/voucher");
		voucher_saveService = new Voucher_saveService();
		
		if (voucher_saveService.insert(Integer.parseInt(id), Integer.parseInt(id_vc))) {
			System.out.println("save vch success! (user_id,vc_id) = ("+id +","+id_vc+")");
		}
		
		return mv;
	}
}
