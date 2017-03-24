 $("#rbEditForm").click(function(){
         getFormData();
     });
   function getFormData() {
             //   alert("in fun");
            	var data = {};
            	$.ajax({
            		type : "GET",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/4",
            		data : data,
            		timeout : 100000,
                       
            		success : function(data) {
            			//console.log("SUCCESS: ", data);
            			//alert(data);
            		},
                         error: function(xhr, status, error) {
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                              }
            		,
            		done : function(e) {
            			//console.log("DONE");
            		}
            	});
            }
     