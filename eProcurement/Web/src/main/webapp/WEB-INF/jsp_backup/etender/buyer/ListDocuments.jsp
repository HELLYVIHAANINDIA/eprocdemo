<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="viewUploadedFile">
	<table class="table">
	<thead>
			<tr>
				<th style="display:none;">Doc Id</th>
				<th>Sr.No.</th>
				<th>Document Name</th>
				<th>Description</th>
				<th>Type</th>
				<th>Date</th>
 				<th>Action</th>
			</tr>
	</thead>
	<tbody id="DocLst">
			<c:choose>
				<c:when test="${not empty lstDocuments}">
					<c:forEach items="${lstDocuments}" var="item" varStatus="indx">
						<tr>
							<td style="display: none;">${item["officerDocId"]}</td>
							<td>${indx.count}</td>
							<td>${item["fileName"]}</td>
							<td>${item["description"]}</td>
							<td>${item["fileType"]}</td>
							<td>${item["createdOn"]}</td>
							<td>
							<c:choose>
							<c:when test="${documentEndDateOver ne true}">
							 <a href="${pageContext.servletContext.contextPath}/ajax/downloadbriefcasefile/${item["officerDocId"]}">Download</a>
							 </c:when>
							 <c:otherwise>
							 	Document download time is over.
							 </c:otherwise>
							 </c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr><td colspan="7">No record found.</td></tr>
				</c:otherwise>
		</c:choose>
		</tbody>	
</table>
</div>
