package TiShoes.Controller.Admin;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Color;
import TiShoes.Model.Color_size;
import TiShoes.Model.Product;
import TiShoes.Model.Sizes;
import TiShoes.Service.Admin.aBSGService;
import TiShoes.Service.Admin.aGalleryService;
import TiShoes.Service.Admin.aProd_Color_SizeService;
import TiShoes.Service.Admin.aProductService;
import TiShoes.Service.User.ProductService;
import TiShoes.Service.User.UserService;

@Controller
public class ShoesController {

	private ProductService productService;
	private aProd_Color_SizeService aProd_Color_SizeService;
	private aGalleryService aGalleryService;
	private aBSGService aBSGService;
	private UserService userService;
	private aProductService aProductService;

	@RequestMapping(value = { "/admin/product" })
	public ModelAndView loadProduct(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/shoes");

		productService = new ProductService();

		List<Product> product = productService.getAllProducts();
		Collections.sort(product, new Comparator<Product>() {
			@Override
			public int compare(Product o1, Product o2) {
				return o2.getId() - o1.getId();
			}
		});
		mv.addObject("listProduct", product);

		mv.addObject("newProduct", "false");
		mv.addObject("product", "true");
		mv.addObject("colorSize", "false");
		mv.addObject("gallery", "false");
		mv.addObject("bsg", "false");

		return mv;
	}
	

	@RequestMapping(value = { "/admin/color-size" })
	public ModelAndView loadColorSize(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/shoes");

		aProd_Color_SizeService = new aProd_Color_SizeService();

		List<Color_size> cls = aProd_Color_SizeService.getAllPCS();
		Collections.sort(cls, new Comparator<Color_size>() {
			@Override
			public int compare(Color_size o1, Color_size o2) {
				// TODO Auto-generated method stub
				return o2.getId() - o1.getId();
			}
		});
		List<Color> c = aProd_Color_SizeService.getAllColor();
		Collections.sort(c, new Comparator<Color>() {
			@Override
			public int compare(Color o1, Color o2) {
				// TODO Auto-generated method stub
				return o2.getId() - o1.getId();
			}
		
		});
		List<Sizes> s = aProd_Color_SizeService.getAllSize();
		Collections.sort(s, new Comparator<Sizes>() {
			@Override
			public int compare(Sizes o1, Sizes o2) {
				// TODO Auto-generated method stub
				return o2.getId() - o1.getId();
			}
		
		});
		mv.addObject("listPCS", cls);
		mv.addObject("listColor", c);
		mv.addObject("listSize", s);

		mv.addObject("newProduct", "false");
		mv.addObject("product", "false");
		mv.addObject("colorSize", "true");
		mv.addObject("gallery", "false");
		mv.addObject("bsg", "false");
		return mv;
	}

}
