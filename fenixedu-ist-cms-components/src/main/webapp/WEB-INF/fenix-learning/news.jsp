<%--

    Copyright © 2013 Instituto Superior Técnico

    This file is part of FenixEdu IST CMS Components.

    FenixEdu IST CMS Components is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FenixEdu IST CMS Components is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with FenixEdu IST CMS Components.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="page-header clearfix">
       <h1 class="pull-left">
               <spring:message code="news.title"/>
       </h1>
       <div class="pull-right">
               <spring:message code="news.number.posts"/>
               <div class="btn-group">
                       <a href="?posts=5" class="btn btn-default ${posts == 5 ? 'active' : ''}">5</a>
                       <a href="?posts=10" class="btn btn-default ${posts == 10 ? 'active' : ''}">10</a>
                       <a href="?posts=20" class="btn btn-default ${posts == 20 ? 'active' : ''}">20</a>
               </div>
       </div>
</div>

<c:forEach var="post" items="${allPosts}">
       <div class="panel panel-default">
               <div class="panel-body clearfix">
                       <h3 class="panel-title pull-left">
                               <strong><a href="${pageContext.request.contextPath}/cms/news/${post.site.slug}/${post.slug}"><c:out value="${post.name.content}"/></a></strong>
                       </h3>
                       <small class="pull-right">
                               <em>
                                       <spring:message code="news.published.in"/> ${post.creationDate.toString('dd-MM-YYYY')}
                                               <c:if test="${post.modified}">
                                                       - <spring:message code="news.modified.in"/> ${post.modificationDate.toString('dd-MM-YYYY')}
                                               </c:if>
                               </em>
                       </small>
               </div>
               <div class="panel-body">
                       <div>${post.body.content}</div>
                       <p class="text-right" style="margin: 0">
							<small>
								<em>
									<c:if test="${not empty post.createdBy}">
									<c:out value="${post.createdBy.profile.displayName}"/> -
									</c:if>

									<a href="${post.site.fullUrl}" target="_blank">
										<c:out value="${post.site.name.content}"/> - <c:out value="${post.categoriesString}"/>
									</a>
								</em>
							</small>
                       </p>
               </div>
       </div>
</c:forEach>

<style>.page-header,.page-header>h1{margin-top:0px;}.panel img{max-width:100%}</style>