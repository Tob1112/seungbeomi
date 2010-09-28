package seungbeomi;

import java.util.List;

public interface UpdateYoshikiManagerDao {

	public void update(DefaultShinseishoYoshiki yoshiki);

	public void updateBatch(List<DefaultShinseishoYoshiki> yoshikiList);

}
