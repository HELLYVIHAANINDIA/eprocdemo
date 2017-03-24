<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="lbl_mapbidder" var="lbl_mapbidder"/>
<spring:message code="lbl_tender_view_companyprofile" var="var_lbl_coprofile"/>
<c:choose>
                    <c:when test="${not empty linksMap}">
                        <c:forEach items="${linksMap}" var="data" varStatus="cnt">
                        <table class="table table-striped table-responsive" style="min-height: 600px">
                        	<thead>
                        		<tr>
                        			<th colspan="3">Module:${data.key}</th>
                        		</tr>
                    		</thead>
                    		<tbody>
                        	<c:forEach items="${data.value}" var="link" varStatus="lnkCnt" step="3">
                            <tr id="searchResult_1">
                            	<c:if test="${data.value[lnkCnt.index].linkId ne ''}">
                            		<td id="tdLink"><input type="checkbox" id="chkLinkId_${data.value[lnkCnt.index].linkId}" name="chkLinkId" value="${data.value[lnkCnt.index].linkId}" class="unique" />${data.value[lnkCnt.index].linkName}
                            	</c:if>
								<c:if test="${data.value[lnkCnt.index+1].linkId ne ''}">
                            		<td id="tdLink"><input type="checkbox" id="chkLinkId_${data.value[lnkCnt.index+1].linkId}" name="chkLinkId" value="${data.value[lnkCnt.index+1].linkId}" class="unique" />${data.value[lnkCnt.index+1].linkName}
                            	</c:if>
								<c:if test="${data.value[lnkCnt.index+2].linkId ne ''}">
                            		<td id="tdLink"><input type="checkbox" id="chkLinkId_${data.value[lnkCnt.index+2].linkId}" name="chkLinkId" value="${data.value[lnkCnt.index+2].linkId}" class="unique" />${data.value[lnkCnt.index+2].linkName}
                            	</c:if>
                            </tr>
                            </c:forEach>
                            </tbody>
                            </table>
                        </c:forEach>
                        <tr id="searchResult_2">
                            <td colspan="4" class="a-center m-top_1 no-border">
                                <button class="btn btn-submit" type="submit" >Submit</button>
                            </td>
                        </tr>
                    </c:when>
                </c:choose>

                <script type="text/javascript">
                	var chkRolesLink =${chkRooleLinkId};
                	$.each(chkRolesLink, function( index, value ) {
                		var id = "#chkLinkId_"+value;
                		$(id).prop("checked", true);
            		});
                </script>
                
                