package flora.user.dao.ibatis.sqlmapdao;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import flora.common.exception.NotFoundDataException;
import flora.user.dao.SequenceDao;
import flora.user.model.Sequence;

public class SequenceSqlMapDao extends SqlMapClientDaoSupport implements SequenceDao{

	public synchronized int getNextId(String name) {
    Sequence sequence = new Sequence(name, -1);

    sequence = (Sequence) getSqlMapClientTemplate().queryForObject("Sequence.getSequence", sequence);
    if (sequence == null) {
      throw new NotFoundDataException("Error: A null sequence was returned from the database (could not get next " + name + " sequence).");
    }
    Object parameterObject = new Sequence(name, sequence.getNextId() + 1);
    getSqlMapClientTemplate().update("Sequence.updateSequence", parameterObject);

    return sequence.getNextId();
  }

}
