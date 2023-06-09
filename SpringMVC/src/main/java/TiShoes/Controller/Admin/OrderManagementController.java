package TiShoes.Controller.Admin;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

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
import TiShoes.Service.Admin.aStatusService;
import TiShoes.Service.Shipper.QRCodeService;
import TiShoes.Service.User.Order_detailsService;

@Controller
public class OrderManagementController {
	private aOrderService _aOrderService;
	private aOrder_detailsSevice _aOrder_detailsSevice;
	private aStatusService _aStatusService;
	private Order_detailsService order_detailsService;
	private QRCodeService qrCodeService;


	@RequestMapping(value = { "/admin/order-management" })
	public ModelAndView loadManagement(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/order");

		_aOrderService = new aOrderService();
		qrCodeService = new QRCodeService();
		
		String id_order = String.valueOf(request.getParameter("id_order"));
		String status = String.valueOf(request.getParameter("status"));
		String bill = request.getParameter("bill");
		String endbill = request.getParameter("endbill");
		String print = request.getParameter("print");
		HttpSession session = request.getSession();
		if(bill != null) {
			session.setAttribute("bill", bill);
			System.out.println("session bill");
		}
		if(endbill != null) {
			session.setAttribute("bill", "false");
			System.out.println("session bill false end");
		}

		if (!id_order.equals("null") && !status.equals("null")) {
			if (_aOrderService.editStatusOrderById(Integer.parseInt(id_order), Integer.parseInt(status))) {
				System.out.println("Update status order success!");
			}
		} else {
			
		}
		
		if(print != null && bill != null) {
			String qrcode = qrCodeService.create_qr_code(bill);
			String barcode = qrCodeService.create_bar_code(bill);
			if(_aOrderService.packing_generator_qrcode(Integer.parseInt(bill), qrcode, barcode)) {
				System.out.println("packing success!");
				return new ModelAndView("redirect: /SpringMVC/admin/order-management/bill/"+bill);
			} else {
				System.out.println("packing unsuccess!");
			}
		} else {
			System.out.println("packing null!");
		}
		
		mv.addObject("management", "true");
		mv.addObject("editorder", "false");
		mv.addObject("orderdetails", "false");
		List<Order_> li = _aOrderService.getAllOrder();
		Collections.sort(li, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getId()-o1.getId();
			}
		
		});
		mv.addObject("listOrder", li);

		return mv;
	}

	@RequestMapping(value = { "/admin/order-management/edit-order" })
	public ModelAndView loadEditOrder(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/order");

		_aOrderService = new aOrderService();
		_aOrder_detailsSevice = new aOrder_detailsSevice();
		_aStatusService = new aStatusService();
		order_detailsService = new Order_detailsService();

		String id_order = String.valueOf(request.getParameter("id_order"));
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
				mv.addObject("total", (double) Math.round(total*100)/100);
			} else {
				mv.addObject("total", (double) Math.round((total - o.getDiscount_at())*100)/100);
			}
		}

		mv.addObject("management", "false");
		mv.addObject("editorder", "true");
		mv.addObject("orderdetails", "false");
		List<Order_> li = _aOrderService.getAllOrder();
		Collections.sort(li, new Comparator<Order_>() {
			@Override
			public int compare(Order_ o1, Order_ o2) {
				return o2.getId()-o1.getId();
			}
		
		});
		mv.addObject("listOrder", li);
		if (!_aStatusService.getAllStatus().isEmpty()) {
			mv.addObject("listStatus", _aStatusService.getAllStatus());
		}
		return mv;
	}

	@RequestMapping(value = { "/admin/order-management/order-details" })
	public ModelAndView loadOrderDetails(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("admin/order");

		_aOrderService = new aOrderService();
		_aOrder_detailsSevice = new aOrder_detailsSevice();
		_aStatusService = new aStatusService();
		order_detailsService = new Order_detailsService();

		String id_order = String.valueOf(request.getParameter("id_order"));
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
				mv.addObject("total", (double) Math.round(total*100)/100);
			} else {
				mv.addObject("total", (double) Math.round((total - o.getDiscount_at())*100)/100);
			}
		}

		mv.addObject("management", "false");
		mv.addObject("editorder", "false");
		mv.addObject("orderdetails", "true");
		if (!_aOrderService.getAllOrder().isEmpty()) {
			List<Order_> li = _aOrderService.getAllOrder();
			Collections.sort(li, new Comparator<Order_>() {
				@Override
				public int compare(Order_ o1, Order_ o2) {
					return o2.getId()-o1.getId();
				}
			
			});
			mv.addObject("listOrder", li);
		}
		if (!_aStatusService.getAllStatus().isEmpty()) {
			mv.addObject("listStatus", _aStatusService.getAllStatus());
		}
		return mv;
	}

	@RequestMapping(value = { "/admin/order-management/countermand/{id}" })
	public void countermand(@PathVariable String id) {
		_aOrderService = new aOrderService();
		if (_aOrderService.editStatusOrderById(Integer.parseInt(id), 6)) {
			System.out.println("Countermand success! (order management controller)");
		} else {
			System.out.println("Countermand unsuccess! (order management controller)");
		}
	}
}
