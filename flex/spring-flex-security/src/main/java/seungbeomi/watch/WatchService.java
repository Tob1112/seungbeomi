package seungbeomi.watch;

import java.util.List;

import seungbeomi.user.model.User;

public interface WatchService {
	public void beginWatch();

	public void endWatch();

	public List<User> findUsers();
}
