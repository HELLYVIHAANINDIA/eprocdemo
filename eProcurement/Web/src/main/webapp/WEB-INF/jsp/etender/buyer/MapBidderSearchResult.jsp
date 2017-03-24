<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="lbl_mapbidder" var="lbl_mapbidder"/>
<spring:message code="lbl_tender_view_companyprofile" var="var_lbl_coprofile"/>
<c:choose>
    <c:when test="${sessionExpired eq true}">sessionexpired</c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${mappingtype eq 2 or mappingtype eq 3}">
                <c:choose>
                    <c:when test="${not empty lstUnmappedBidder}">
                        <c:forEach items="${lstUnmappedBidder}" var="data" varStatus="cnt">
                            <tr id="searchResult_1">
                                <td id="tdMapBidder">
                                <input type="checkbox" id="chkBidderId" name="chkBidderId" value="${data[0]}_${data[6]}" class="unique" />
                                <td class="a-center">${cnt.count}</td>
                                <td width="25%" class="line-height">
                                	${data[1]}
                                    <br/>${data[2]}
                                    <br/>${data[3]}
                                    <br/>${data[5]}-${data[4]}
                                    <input type="hidden" value="${data[0]}_${data[6]}" name="UnMappedCoId"/>
                                </td>
                                <%-- <td><abc:href href="common/admin/viewbidderprofile/${data[0]}" label="${data[1]}" target="_blank" title="${var_lbl_coprofile}"/></td> --%>
                            </tr>
                        </c:forEach>
                        <tr id="searchResult_2">
                            <td colspan="4" class="a-center m-top_1 no-border">
                                <button class="btn btn-submit" type="submit" value="">${lbl_mapbidder}</button>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr id="searchResult_1">
                            <c:choose>
                                <c:when test="${isBidderMapped eq true}">
                                    <td colspan="4" id="tdNoRecord"><spring:message code="msg_tender_biddermap_alreadymap"/></td>
                                </c:when>
                                <c:otherwise>
                                    <td colspan="5"><spring:message code="msg_tender_biddermap_empty"/></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </c:when>
             <c:otherwise>
                        <td colspan="5"><spring:message code="msg_auc_biddermap_empty"/></td>
                    </c:otherwise>
                </c:choose>
    </c:otherwise>
</c:choose>
