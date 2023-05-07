package TiShoes.Controller.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.User;
import TiShoes.Service.User.ProfileService;
import TiShoes.Service.User.StyleService;
import TiShoes.Service.User.UserService;

@Controller
public class PersonalDetailsController {
	private UserService userService;
	private StyleService styleService;
	private ProfileService profileService;

	@RequestMapping(value = { "/personal-details/{id}" })
	public ModelAndView loadHome(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");

		userService = new UserService();
		styleService = new StyleService();
		
		
		User u = userService.get_user_by_id(Integer.parseInt(id));
		
		String adr[] = u.getAddress().split("-");
		if (adr.length > 2) {
			String address = adr[0];
			String country = adr[1];
			String city = adr[2];
			mv.addObject("address", address.trim());
			mv.addObject("city", city.trim());
			mv.addObject("country", country.trim());
		}
		
		mv.addObject("user", u);
		mv.addObject("userID", u.getId());
		mv.addObject("user_id", u.getId());
		mv.addObject("avatar", userService.getAvatarByUserID(u.getId()));
		mv.addObject("style", styleService.getAllStyle());

		return mv;
	}
	
	@RequestMapping(value = { "/personal-details/block/{id}" })
	public ModelAndView block_user(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");

		HttpSession session = request.getSession();
		session.setAttribute("profile", id);

		return mv;
	}
	
	@RequestMapping(value = { "/personal-details/save-pw/{id}" })
	public ModelAndView save_pw(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");
		profileService = new ProfileService();
		userService = new UserService();
		String oldpw = request.getParameter("oldpw");
		String newpw = request.getParameter("newpw");
		HttpSession session = request.getSession();

		User u = userService.get_user_by_id(Integer.parseInt(id));
		if (oldpw != null && newpw != null) {
			if (profileService.check_pw(oldpw, u)) {
				if (profileService.update_pw(newpw, u)) {
					session.setAttribute("change", "pwtrue");
					return new ModelAndView("redirect: /SpringMVC/personal-details/" + id);
				}
			} else {
				session.setAttribute("change", "oldfalse");
				return new ModelAndView("redirect: /SpringMVC/personal-details/" + id);
			}
		}
		return mv;
	}

	@RequestMapping(value = { "/personal-details/save-intro/{id}" })
	public ModelAndView save_intro(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");

		return mv;
	}

	@RequestMapping(value = { "/personal-details/save-contact/{id}" })
	public ModelAndView save_contact(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");
		profileService = new ProfileService();
		userService = new UserService();
		String fullname = request.getParameter("fullname");
		String phonenumber = request.getParameter("phonenumber");
		String email = request.getParameter("email");
		
		System.out.println(fullname + " ==" +phonenumber +"==" +email);
		HttpSession session = request.getSession();
		User u = userService.get_user_by_id(Integer.parseInt(id));
		if (fullname != null && phonenumber != null && email != null) {
			System.out.println(fullname);
			if (profileService.update_contact(fullname, phonenumber, email, u)) {
				session.setAttribute("change", "contacttrue");
				return new ModelAndView("redirect: /SpringMVC/personal-details/" + u.getId());
			}
		}
		return mv;
	}

	@RequestMapping(value = { "/personal-details/save-address/{id}" })
	public ModelAndView save_address(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");
		profileService = new ProfileService();
		userService = new UserService();
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		HttpSession session = request.getSession();
		User u = userService.get_user_by_id(Integer.parseInt(id));
		if (address != null && district != null && city != null) {
			if (profileService.update_address(address, district, city, u)) {
				session.setAttribute("change", "addresstrue");
				return new ModelAndView("redirect: /SpringMVC/personal-details/" + id);
			}
		}
		return mv;
	}

	@RequestMapping(value = { "/personal-details/save-change" })
	public ModelAndView save_change(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("user/personal_details");
		String change = request.getParameter("change");
		HttpSession session = request.getSession();
		System.out.println("heare");
		if (change != null) {
			session.setAttribute("change", "");
		}
		return mv;
	}
}
