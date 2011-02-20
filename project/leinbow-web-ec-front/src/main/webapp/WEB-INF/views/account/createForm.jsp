<%@ include file="/WEB-INF/layouts/common/taglibs.jsp"%>


<div>
    <h1>
        Create Account
    </h1>
    <div class="span-12 last">
        <form:form modelAttribute="account" action="account" method="post">
              <fieldset>
                <legend>Account Fields</legend>
                <p>
                    <form:label	for="name" path="name" cssErrorClass="error">Name</form:label><br/>
                    <form:input path="name" /> <form:errors path="name" />
                </p>
                <p>
                    <form:label for="balance" path="balance" cssErrorClass="error">Balance</form:label><br/>
                    <form:input path="balance" /> <form:errors path="balance" />
                </p>
                <p>
                    <form:label for="equityAllocation" path="equityAllocation" cssErrorClass="error">Equity Allocation</form:label><br/>
                    <form:input path="equityAllocation" /> <form:errors path="equityAllocation" />
                </p>
                <p>
                    <form:label for="renewalDate" path="renewalDate" cssErrorClass="error">Renewal Date</form:label><br/>
                    <form:input path="renewalDate" /> <form:errors path="renewalDate" />
                </p>
                <p>
                    <input type="submit" />
                </p>
            </fieldset>
        </form:form>
    </div>
    <hr />
    <ul>
        <li> <a href="?lang=en">en</a> |  <a href="?lang=ja">ja</a> | <a href="?lang=ko">ko</a> | <a href="?lang=zh">zh</a> </li>
    </ul>
</div>
