<%--

    Copyright © 2013 Instituto Superior Técnico

    This file is part of FenixEdu IST Pre Bolonha.

    FenixEdu IST Pre Bolonha is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FenixEdu IST Pre Bolonha is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with FenixEdu IST Pre Bolonha.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<html:xhtml/>

<h2><bean:message key="message.success.changePersonalData" bundle="ADMIN_OFFICE_RESOURCES" /></h2>

<bean:define id="link">
	/listDFACandidacy.do?method=viewCandidacy&candidacyID=<bean:write name="candidacyID" />
</bean:define>

<html:link action="<%= link %>" >
	<bean:message key="link.candidacy.back" bundle="ADMIN_OFFICE_RESOURCES" />
</html:link>
