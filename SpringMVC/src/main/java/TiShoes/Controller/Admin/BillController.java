package TiShoes.Controller.Admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Order_;
import TiShoes.Service.Admin.aOrderService;
import TiShoes.Service.Admin.aOrder_detailsSevice;
import TiShoes.Service.User.Order_detailsService;

@Controller
public class BillController {
	private aOrderService _aOrderService;
	private aOrder_detailsSevice _aOrder_detailsSevice;
	private Order_detailsService order_detailsService;

	@RequestMapping(value = { "/admin/order-management/bill/{id}" })
	public ModelAndView bill(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		if (session.getAttribute("bill") != null) {
			String bill = String.valueOf(session.getAttribute("bill"));
			if (bill.equals("") || bill.equals("false")) {
				return new ModelAndView("redirect: /SpringMVC/admin/order-management");
			}
		} else {
			return new ModelAndView("redirect: /SpringMVC/admin/order-management");
		}

		ModelAndView mv = new ModelAndView("admin/bill");

		_aOrderService = new aOrderService();
		_aOrder_detailsSevice = new aOrder_detailsSevice();
		order_detailsService = new Order_detailsService();
		
		String id_order = id;
		if (!id_order.equals("null")) {
			Order_ o = _aOrderService.getOrderByID(Integer.parseInt(id_order));
			if (_aOrderService.getOrderByID(Integer.parseInt(id_order)) != null) {
				mv.addObject("orderById", o);
			}
			if (!_aOrder_detailsSevice.getOrder_detailsByIdOrder(Integer.parseInt(id_order)).isEmpty()) {
				mv.addObject("orderDetailsById",
						_aOrder_detailsSevice.getOrder_detailsByIdOrder(Integer.parseInt(id_order)));
			}
			double total = order_detailsService.total_order_by_id_order(Integer.parseInt(id_order));
			if (total < 50) {
				total = total + 11.0 - o.getDiscount_at();
				mv.addObject("total", (double) Math.round(total * 100) / 100);
			} else {
				mv.addObject("total", (double) Math.round((total - o.getDiscount_at()) * 100) / 100);
			}
		}

		mv.addObject("orderid", id);
		return mv;
	}
}
