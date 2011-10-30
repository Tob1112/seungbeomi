package auction.dao;

import auction.model.Bid;
import auction.model.Item;

/**
 * Business DAO operations related to the <tt>Item</tt> entity.
 * 
 * @see Item
 * @author Christian Bauer
 */
public interface ItemDAO extends GenericDAO<Item, Long> {

	Bid getMaxBid(Long itemId);

	Bid getMinBid(Long itemId);

}
