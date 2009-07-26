package flora.common.dao;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.incrementer.DataFieldMaxValueIncrementer;

public class MyJdbcDaoSupport extends JdbcDaoSupport {
    private MessageSourceAccessor messageSourceAccessor;

    private DataFieldMaxValueIncrementer incrementer;

    public void setIncrementer(DataFieldMaxValueIncrementer incrementer) {
        this.incrementer = incrementer;
    }

    protected final DataFieldMaxValueIncrementer getIncrementer() {
        return incrementer;
    }

    public void setMessageSourceAccessor(
            MessageSourceAccessor newMessageSourceAccessor) {
        this.messageSourceAccessor = newMessageSourceAccessor;
    }

    protected final MessageSourceAccessor getMessageSourceAccessor() {
        return messageSourceAccessor;
    }
}
