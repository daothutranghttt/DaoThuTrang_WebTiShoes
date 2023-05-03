package TiShoes.Controller.Admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Service.Admin.aUserService;
import TiShoes.Service.Mail.EmailService;

@Controller
public class aVerifyEmailController {
	private aUserService aUserService;
	private EmailService emailService;

	@RequestMapping(value = { "verify" })
	public ModelAndView loadLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/verify");

		aUserService = new aUserService();
		emailService = new EmailService();

		String username = request.getParameter("username");
		String pw = request.getParameter("password");
		if (username != null && pw != null) {
			if (aUserService.check_login(username, pw) != 0) {
				int adminID = aUserService.check_login(username, pw);
				emailService.sendEmail("thutrang9901@gmail.com", "thutrang9901@gmail.com", "Verify",
						"http://localhost:8888/SpringMVC/admin/login?id=" + adminID);
			} else {
				return new ModelAndView("redirect: /SpringMVC/admin/login?username=" + username + "&password=" + pw);
			}
		}
		return mv;
	}
}