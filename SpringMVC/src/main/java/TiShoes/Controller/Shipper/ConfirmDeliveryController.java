package TiShoes.Controller.Shipper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Order_;
import TiShoes.Model.Statistics;
import TiShoes.Service.Admin.aOrderService;
import TiShoes.Service.Admin.aOrder_detailsSevice;
import TiShoes.Service.Shipper.sDeliveryService;
import TiShoes.Service.Shipper.sOrderService;
import TiShoes.Service.User.StatisticsService;

@Controller
public class ConfirmDeliveryController {

	private sDeliveryService sDeliveryService;
	private StatisticsService statisticsService;
	private aOrder_detailsSevice aOrder_detailsSevice;
	private sOrderService sOrderService;

	@RequestMapping(value = { "shipper/confirm-delivery" })
	public ModelAndView delivery(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("shipper/s-confirm-delivery");
		return mv;
	}

	@RequestMapping(value = { "shipper/cancel-order" })
	public ModelAndView cancel(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("shipper/s-cancel");
		return mv;
	}

	@RequestMapping(value = { "shipper/confirm-delivery/{id}" })
	public ModelAndView delivery_by_order_id(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("shipper/s-confirm-delivery");
		statisticsService = new StatisticsService();
		sDeliveryService = new sDeliveryService();
		aOrder_detailsSevice = new aOrder_detailsSevice();
		sOrderService = new sOrderService();
		System.out.println("aaaaaaaaaaaa");
		if (sDeliveryService.check_Order_(Integer.parseInt(id))) {
			if (sDeliveryService.delivered(Integer.parseInt(id))) {
				System.out.println("delivered: " + id);
				if (o != null) {
					if (!o.getMethod().equals("COD")) {
						mv.addObject("delivered", "true");
						System.out.println("dddddddddđ!");
					} else {
						if (statisticsService.update_revenue_product_num_in_statistics_DB(
								aOrder_detailsSevice.get_qty_by_order_id(Integer.parseInt(id)),
								aOrder_detailsSevice.get_revenue_by_order_id(Integer.parseInt(id)))) {
							mv.addObject("delivered", "true");
							System.out.println("uuuuuuuuuuuuuuuuuu!");
						}
						System.out.println("daaaaaaaaaaaaa!");
					}
				} else {
					if (statisticsService.update_revenue_product_num_in_statistics_DB(
							aOrder_detailsSevice.get_qty_by_order_id(Integer.parseInt(id)),
							aOrder_detailsSevice.get_revenue_by_order_id(Integer.parseInt(id)))) {
						mv.addObject("delivered", "true");
						System.out.println("eeeeeeeeee!");
					}
					System.out.println("9ooooooo nulllll!");
				}
			} else {
				System.out.println("delivery unsuccess!");
				mv.addObject("delivered", "false");
			}
		} else {
			mv.addObject("delivered", "false");
			System.out.println("delivery unsuccess 70!");
		}

		return mv;
	}

	@RequestMapping(value = { "shipper/cancel-order/{id}" })
	public ModelAndView cancel_by_order_id(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("shipper/s-cancel");
		statisticsService = new StatisticsService();
		sDeliveryService = new sDeliveryService();
		aOrder_detailsSevice = new aOrder_detailsSevice();
		sOrderService sOrderService = new sOrderService();
		if (sDeliveryService.check_Order_(Integer.parseInt(id))) {
			if (sOrderService.cancel(Integer.parseInt(id))) {
				mv.addObject("cancel", "true");
			} else {
				System.out.println("cancel unsuccess!");
				mv.addObject("cancel", "false");
			}
		} else {
			mv.addObject("cancel", "false");
		}

		return mv;
	}
}
