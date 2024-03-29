package flex.samples.product;
import java.io.Serializable;

public class Product implements Serializable {

    static final long serialVersionUID = 103844514947365244L;

    private int productId;
    private String name;
    private String description;
    private String image;
    private String category;
    private double price;
    private int qtyInStock;

    public Product() {

    }

    public Product(int productId, String name, String description, String image, String category, double price, int qtyInStock) {
		this.productId = productId;
		this.name = name;
		this.description = description;
		this.image = image;
		this.category = category;
		this.price = price;
		this.qtyInStock = qtyInStock;
	}

    public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getQtyInStock() {
		return qtyInStock;
	}
	public void setQtyInStock(int qtyInStock) {
		this.qtyInStock = qtyInStock;
	}

	/**
		 *
		 * @return
		 * @author
		 */
		public String toString() {
			StringBuffer buffer = new StringBuffer();
			buffer.append("Product[");
			buffer.append(" productId = ").append(productId);
			buffer.append(" name = ").append(name);
			buffer.append(" description = ").append(description);
			buffer.append(" image = ").append(image);
			buffer.append(" category = ").append(category);
			buffer.append(" price = ").append(price);
			buffer.append(" qtyInStock = ").append(qtyInStock);
			buffer.append("]");
			return buffer.toString();
		}

}