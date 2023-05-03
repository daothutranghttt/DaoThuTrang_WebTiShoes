package TiShoes.Controller.Admin;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Product;
import TiShoes.Service.Admin.aProd_Color_SizeService;
import TiShoes.Service.User.ColorService;
import TiShoes.Service.User.Color_sizeService;
import TiShoes.Service.User.ProductService;
import TiShoes.Service.User.SizeService;

@Controller
public class aProd_Color_SizeController {
	private ProductService shoesService;
	private aProd_Color_SizeService aProd_Color_SizeService;
	private ColorService colorService;
	private Color_sizeService product_color_sizeService;
	private SizeService sizeService;

	@RequestMapping(value = { "/admin/product/add-product-color-size" })
	public ModelAndView load_color_size(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/color-size-add");

		shoesService = new ProductService();
		aProd_Color_SizeService = new aProd_Color_SizeService();
		product_color_sizeService = new Color_sizeService();
		String conti = request.getParameter("continue");
		String cancel = request.getParameter("cancel");
		String product = request.getParameter("product");
		String color = request.getParameter("color");
		String li_size = "";
		for (int i = 32; i < 48; i++) {
			String size = request.getParameter("size" + String.valueOf(i));
			if (size != null) {
				if (!size.equals("")) {
					li_size += String.valueOf(i) + "_" + size + "/";
				} else {
					li_size += String.valueOf(i) + "_0/";
				}
			}
		}

		System.out.println(product + "==" + color + "===" + li_size);

		if (product != null && color != null && !li_size.equals("")) {
			if (product_color_sizeService.insertIntoColor_Size(li_size, Integer.parseInt(color),
					Integer.parseInt(product))) {
				System.out.println("add color size success");
				if(conti != null) {
					return new ModelAndView("redirect: /SpringMVC/admin/product/add-product-color-size");
				} else if(cancel != null) {
					System.out.println("a");
					return new ModelAndView("redirect: /SpringMVC/admin/gallery/add");
				}
			} else {
				mv.addObject("unsuccess", "false");
			}	
		}
		List<Product> liproduct = shoesService.getAllProducts();
		Collections.sort(liproduct, new Comparator<Product>() {
			@Override
			public int compare(Product o1, Product o2) {
				return o2.getId() - o1.getId();
			}

		});
		mv.addObject("listProduct", liproduct);
		mv.addObject("listColor", aProd_Color_SizeService.getAllColor());

		return mv;
	}

	@RequestMapping(value = { "/admin/color-size/add-color" })
	public ModelAndView add_color(HttpServletRequest request, HttpServletResponse response) {
		colorService = new ColorService();
		String name = request.getParameter("colorname");
		String rgb = request.getParameter("colorrgb");
		if (name != null && rgb != null) {
			if (colorService.insert(name, rgb)) {
				System.out.println("add color success!");
				return new ModelAndView("redirect: /SpringMVC/admin/color-size");
			}
			return new ModelAndView("redirect: /SpringMVC/admin/color-size");
		}
		return null;
	}

	@RequestMapping(value = { "/admin/color-size/add-size" })
	public ModelAndView add_size(HttpServletRequest request, HttpServletResponse response) {
		sizeService = new SizeService();
		String name = request.getParameter("sizenumber");

		if (name != null) {
			if (sizeService.insert(name)) {
				System.out.println("add size success!");
				return new ModelAndView("redirect: /SpringMVC/admin/color-size");
			}
			return new ModelAndView("redirect: /SpringMVC/admin/color-size");
		}

		return null;
	}
}
