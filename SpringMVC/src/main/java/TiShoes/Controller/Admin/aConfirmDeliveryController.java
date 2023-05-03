package TiShoes.Controller.Admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Service.Shipper.sDeliveryService;

@Controller
public class aConfirmDeliveryController {

	private sDeliveryService sDeliveryService;

	@RequestMapping(value = { "admin/packing" })
	public ModelAndView packing(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/barcode");
		mv.addObject("packing", "true");
		return mv;
	}
	
	@RequestMapping(value = { "admin/shipping" })
	public ModelAndView shipping(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/barcode");
		mv.addObject("shipping", "true");
		return mv;
	}

	@RequestMapping(value = { "admin/confirm-delivery/{id}" })
	public ModelAndView delivery_by_order_id(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/barcode");

		sDeliveryService = new sDeliveryService();

		if (sDeliveryService.check_Order_(Integer.parseInt(id))) {
			if (sDeliveryService.delivered(Integer.parseInt(id))) {
				System.out.println("delivered: " + id);
				mv.addObject("delivered", "true");
			} else {
				System.out.println("delivery unsuccess!");
				mv.addObject("delivered", "false");
			}
		} else {
			mv.addObject("delivered", "false");
		}

		return mv;
	}
}
