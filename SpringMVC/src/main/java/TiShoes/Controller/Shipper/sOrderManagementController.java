package TiShoes.Controller.Shipper;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import TiShoes.Model.Order_;
import TiShoes.Service.Admin.aOrderService;
import TiShoes.Service.Admin.aOrder_detailsSevice;
import TiShoes.Service.Admin.aStatusService;
import TiShoes.Service.Shipper.QRCodeService;
import TiShoes.Service.Shipper.sOrderService;
import TiShoes.Service.User.OrderService;
import TiShoes.Service.User.Order_detailsService;

@Controller
public class sOrderManagementController {
	private aOrder_detailsSevice _aOrder_detailsSevice;
	private aStatusService _aStatusService;
	private sOrderService sOrderService;
	private aOrderService _aReceiptService;
	private Order_detailsService order_detailsService;

	@RequestMapping(value = { "/shipper/order-management" })
	public ModelAndView loadManagement(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("shipper/s-order");
		sOrderService = new sOrderService();
		HttpSession session = request.getSession();

		String shipper_id = "";
		if (session.getAttribute("shipperID") != null) {
			shipper_id = String.valueOf(session.getAttribute("shipperID"));
		}

		String id_order = request.getParameter("id_order");
		String ok = request.getParameter("ok");
		if (id_order != null && !shipper_id.equals("")) {
			sOrderService = new sOrderService();
			if (sOrderService.take_order(Integer.parseInt(id_order), Integer.parseInt(shipper_id))) {
				session.setAttribute("takeorder", "true");
				System.out.println("takeorder: true");
			} else {
				session.setAttribute("takeorder", "false");
				System.out.println("takeorder: false");
			}

		}
		if (ok != null) {
			session.setAttribute("takeorder", "none");
			System.out.println("takeorder: none");
		}

		mv.addObject("management", "true");
		mv.addObject("editorder", "false");
		mv.addObject("orderdetails", "false");
		List<Order_> li = sOrderService.getAllOrder();
		Collections.sort(li, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getId() - o1.getId();
			}
		});
		mv.addObject("listOrder", li);

		return mv;
	}

	@RequestMapping(value = { "/shipper/order-management/order-details" })
	public ModelAndView loadOrderDetails(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("shipper/s-order");

		_aReceiptService = new aOrderService();
		_aOrder_detailsSevice = new aOrder_detailsSevice();
		_aStatusService = new aStatusService();
		sOrderService = new sOrderService();
		
		order_detailsService = new Order_detailsService();
		
		String id_order = String.valueOf(request.getParameter("id_order"));
		if (!id_order.equals("null")) {
			Order_ o = _aReceiptService.getOrderByID(Integer.parseInt(id_order));
			if (_aReceiptService.getOrderByID(Integer.parseInt(id_order)) != null) {
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

		mv.addObject("management", "false");
		mv.addObject("editorder", "false");
		mv.addObject("orderdetails", "true");
		if (!sOrderService.getAllOrder().isEmpty()) {
			List<Order_> li = sOrderService.getAllOrder();
			Collections.sort(li, new Comparator<Order_>() {
				@Override
				public int compare(Order_ o1, Order_ o2) {
					return o2.getId() - o1.getId();
				}

			});
			mv.addObject("listOrder", li);
		}
		if (!_aStatusService.getAllStatus().isEmpty()) {
			mv.addObject("listStatus", _aStatusService.getAllStatus());
		}
		return mv;
	}

}
