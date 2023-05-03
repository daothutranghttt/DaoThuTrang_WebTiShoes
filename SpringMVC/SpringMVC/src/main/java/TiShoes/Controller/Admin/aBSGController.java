package TiShoes.Controller.Admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Service.Admin.aBSGService;
import TiShoes.Service.User.BrandService;
import TiShoes.Service.User.ColorService;
import TiShoes.Service.User.GenderService;
import TiShoes.Service.User.StyleService;

@Controller
public class aBSGController {
	private aBSGService aBSGService;
	private BrandService brandService;
	private StyleService styleService;
	private GenderService genderService;

	@RequestMapping(value = { "/admin/brand-style-gender" })
	public ModelAndView loadBSG(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/shoes");

		aBSGService = new aBSGService();

		mv.addObject("listBrand", aBSGService.getAllBrand());
		mv.addObject("listStyle", aBSGService.getAllStyle());
		mv.addObject("listGender", aBSGService.getAllGender());

		mv.addObject("newProduct", "false");
		mv.addObject("product", "false");
		mv.addObject("colorSize", "false");
		mv.addObject("gallery", "false");
		mv.addObject("bsg", "true");
		return mv;
	}

	@RequestMapping(value = { "/admin/brand-style-gender/add-brand" })
	public ModelAndView add_brand(HttpServletRequest request, HttpServletResponse response) {
		brandService = new BrandService();

		String name = request.getParameter("brand");
		if (name != null) {
			if (brandService.insert(name)) {
				System.out.println("add brand success!");
				return new ModelAndView("redirect: /SpringMVC/admin/brand-style-gender");
			}
			return new ModelAndView("redirect: /SpringMVC/admin/brand-style-gender");
		}
		return null;
	}

	@RequestMapping(value = { "/admin/brand-style-gender/add-style" })
	public ModelAndView add_style(HttpServletRequest request, HttpServletResponse response) {
		styleService = new StyleService();

		String name = request.getParameter("style");
		if (name != null) {
			if (styleService.insert(name)) {
				System.out.println("add style success!");
				return new ModelAndView("redirect: /SpringMVC/admin/brand-style-gender");
			}
			return new ModelAndView("redirect: /SpringMVC/admin/brand-style-gender");
		}
		return null;
	}

	@RequestMapping(value = { "/admin/brand-style-gender/add-gender" })
	public ModelAndView add_gender(HttpServletRequest request, HttpServletResponse response) {
		genderService = new GenderService();

		String name = request.getParameter("gender");
		if (name != null) {
			if (genderService.insert(name)) {
				System.out.println("add gender success!");
				return new ModelAndView("redirect: /SpringMVC/admin/brand-style-gender");
			}
			return new ModelAndView("redirect: /SpringMVC/admin/brand-style-gender");
		}
		return null;
	}

}
