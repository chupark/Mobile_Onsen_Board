<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script type="text/javascript"
src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function() {
	$('#goBtn').on('click', function() {
		var params = $('#aForm').serialize();
		$.ajax({
			url : 'xx.jsp',
			data : params,
			success : function(data) {
				var succ = data.trim();
				if(succ == "Y") {
					location.href = "b.jsp";
				} else {
					alert('실패 : id가 일치하지 않음');
				}
			}
		});
	});
});
</script>
</head>

<body>
<form id="aForm" name="aForm" method="post">
<input type="text" name="id" value="dano" />
<input type="password" name="pw" value="1234" />
<input type="button" id="goBtn" value="Click" />
</form>
</body>

</html>