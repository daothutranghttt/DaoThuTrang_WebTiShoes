package TiShoes.Model;

public class Voucher_save {
	private int id;
	private Voucher voucher;
	private User user;
	private int quanttity;
	private int status;

	public Voucher_save() {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Voucher getVoucher() {
		return voucher;
	}

	public void setVoucher(Voucher voucher) {
		this.voucher = voucher;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getQuanttity() {
		return quanttity;
	}

	public void setQuanttity(int quanttity) {
		this.quanttity = quanttity;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
