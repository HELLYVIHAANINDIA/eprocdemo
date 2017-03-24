
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%@include file="includes/head.jsp"%>
		<title>eprocurement</title>

<script type="text/javascript"> 
	function validate() {
		var vbool = valOnSubmit();
		//alert(vbool);
		return vbool;
	}
	function GetCal(txtname, controlname, datetype) {

		if (datetype == 'datetime') {
			var date;
			new Calendar({
				inputField : txtname,
				trigger : controlname,
				dateFormat : "%d-%m-%Y %H:%M",
				showTime : true,
				onSelect : function() {
					date = this.selection.get()
					date = Calendar.intToDate(date);
					date = Calendar.printDate(date, "%d-%m-%Y %H:%M");
					this.hide();
					if (txtname == 'txtdob') {
						RndEndDt();
					}

					document.getElementById(txtname).focus();
				}
			});
		} else {

			new Calendar({
				inputField : txtname,
				trigger : controlname,
				showTime : false,
				dateFormat : "%d/%m/%Y",
				onSelect : function() {
					var date = Calendar.intToDate(this.selection.get());
					LEFT_CAL.args.min = date;
					LEFT_CAL.redraw();
					this.hide();
				}
			});

		}

		var LEFT_CAL = Calendar.setup({
			weekNumbers : false
		})
	}
</script>
</head>

<body>
	<div>
		<%@include file="includes/header.jsp"%>
		<!--Body Part Start-->
		<!--Body Part End-->
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>
