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
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Brand;
import TiShoes.Model.Style;
import TiShoes.Service.Admin.aBSGService;
import TiShoes.Service.Admin.aProd_Color_SizeService;
import TiShoes.Service.Admin.aProductService;
import TiShoes.Service.User.ProductService;
import TiShoes.Service.User.UserService;

@Controller
public class ShoesAddController {
	private ProductService productService;
	private aProd_Color_SizeService aProd_Color_SizeService;
	private aBSGService aBSGService;
	private UserService userService;
	private aProductService aProductService;

	@RequestMapping(value = "/admin/product/add-new-product/savefile", method = RequestMethod.POST)
	public ModelAndView upload(@RequestParam(value="filetag", required = false) MultipartFile file ,HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		ModelAndView mv = new ModelAndView("admin/shoes-add");
		
		aProductService = new aProductService();
		
		HttpSession session = request.getSession();
		String title = request.getParameter("title");
		String price = request.getParameter("price");
		String discount = request.getParameter("discount");
		String style = request.getParameter("style");
		String gender = request.getParameter("gender");
		String user = request.getParameter("user");
		String brand = request.getParameter("brand");
		String description = request.getParameter("description");
		
				
		if (title != null) {
			System.out.println(title);
		}
		if (price != null) {
			System.out.println(price);
		}
		if (discount != null) {
			System.out.println(discount);
		}
		if (style != null) {
			System.out.println(style);
		}
		if (gender != null) {
			System.out.println(gender);
		}
		if (user != null) {
			System.out.println(user);
		}
		if (brand != null) {
			System.out.println(brand);
		}
		if (description != null) {
			System.out.println(description);
		}
		
		String image = saveFile(file);
		if(image != null) {
			if (title != null && price != null && discount != null && style != null && gender != null && user != null
					&& brand != null && description != null) {
				if(aProductService.insert(title, Double.parseDouble(price), Integer.parseInt(discount), description,
						Integer.parseInt(style), image, Integer.parseInt(brand), Integer.parseInt(user),
						Integer.parseInt(gender))) {
					System.out.println("success");
					session.setAttribute("addproduct", "true");
				} else {
					session.setAttribute("addproduct", "false");
					System.out.println("unsuccess");
				}
			}
			return new ModelAndView("redirect: /SpringMVC/admin/product/add-product-color-size");
		}
		
		return mv;
	}

	private String saveFile(MultipartFile file) {
		if( file != null && !file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				//String rootpath = System.getProperty("catalina.home");
				
				File dir = new File("F:\\DATN-2023\\SpringMVC\\src\\main\\webapp\\assets\\images\\products");
				if(!dir.exists()) {
					dir.mkdir();
				}
				
				String name = String.valueOf("ti_shoes_"+new Date().getTime()+".jpg" );
				File serverFile = new File(dir.getAbsolutePath()+"\\"+name);
				
				System.out.println("path: " + serverFile.getPath());
				
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				
				return name;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value = { "/admin/product/add-new-product" })
	public ModelAndView loadNewProduct(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		ModelAndView mv = new ModelAndView("admin/shoes-add");

		productService = new ProductService();
		aProductService = new aProductService();
		aProd_Color_SizeService = new aProd_Color_SizeService();
		aBSGService = new aBSGService();
		userService = new UserService();

		List<Brand> brand = aBSGService.getAllBrand();
		List<Style> style = aBSGService.getAllStyle();
		Collections.sort(brand, new Comparator<Brand>() {
			@Override
			public int compare(Brand o1, Brand o2) {
				return o1.getBrand_name().compareTo(o2.getBrand_name());
			}
		
		});
		Collections.sort(style, new Comparator<Style>() {
			@Override
			public int compare(Style o1, Style o2) {
				return o1.getStyle_name().compareTo(o2.getStyle_name());
			}
		
		});
		mv.addObject("listBrand", brand);
		mv.addObject("listStyle", style);
		
		mv.addObject("listUser", userService.getAllUser());
		
		mv.addObject("listGender", aBSGService.getAllGender());
		mv.addObject("listColor", aProd_Color_SizeService.getAllColor());
		mv.addObject("listSize", aProd_Color_SizeService.getAllSize());

		mv.addObject("listProduct", productService.getAllProducts());

		mv.addObject("newProduct", "true");
		mv.addObject("product", "false");
		mv.addObject("colorSize", "false");
		mv.addObject("gallery", "false");
		mv.addObject("bsg", "false");

		return mv;
	}
}
