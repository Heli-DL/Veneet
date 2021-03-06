<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Tietojen muuttaminen</title>
</head>
<body>
<form id="tiedot">
	<div class="container">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-8 div1"><h2>Muuta tietoja</h2></div>
					<div class="col-sm-4">
                        <button type="button" id="takaisin" class="btn btn-info">Takaisin listaukseen</button>
                    </div>
               	</div>
			</div>
			<table>
				<thead>			
					<tr>
						<th>Nimi</th>
						<th>Merkkimalli</th>
						<th>Pituus</th>
						<th>Leveys</th>
						<th>Hinta</th>
					</tr>
				</thead>
				<tbody>
					<tr>			
						<td><input type="text" name="nimi" id="nimi"></td>
						<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
						<td><input type="text" name="pituus" id="pituus"></td>
						<td><input type="text" name="leveys" id="leveys"></td>
						<td><input type="text" name="hinta" id="hinta" ></td>
						<td><input type="submit" id="tallenna" class="btn btn-info vali" value="Hyväksy"></td>			
					</tr>
				</tbody>
			</table>
			<span id="ilmo"></span>
		</div>
	</div>
	<input type ="hidden" name="tunnus" id="tunnus">
</form>
</body>
<script>
$ (document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaveneet.jsp";
	});
	
	$("#nimi").focus();
	
	var tunnus = requestURLParam("tunnus");
	$.ajax({url:"veneet/haeyksi/"+tunnus, type:"GET", dataType:"json", success:function(result) {
		$("#nimi").val(result.nimi);
		$("#merkkimalli").val(result.merkkimalli);
		$("#pituus").val(result.pituus);
		$("#leveys").val(result.leveys);
		$("#hinta").val(result.hinta);
		$("#tunnus").val(result.tunnus);
	}});
	
	$("#tiedot").validate({						
		rules: {	
			nimi:  {
				required: true,
				minlength: 2				
			},	
			merkkimalli:  {
				required: true,
				minlength: 2				
			},
			pituus:  {
				required: true,
				minlength: 1
			},	
			leveys:  {
				required: true,
				minlength: 1
			},
			hinta:  {
				required: true,
				minlength: 1
			}	
		},
		messages: {
			nimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			merkkimalli: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			leveys: {
				required: "Puuttuu",		
				email: "Ei kelpaa"		
			},
			hinta: {
				required: "Puuttuu",		
				email: "Ei kelpaa"		
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	});
	function paivitaTiedot(){	
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); 
		console.log(formJsonStr);
		$.ajax({url:"veneet", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) {        
			if(result.response==0){
	      	$("#ilmo").html("Tietojen päivittäminen epäonnistui.").css("color", "red");
	      }else if(result.response==1){			
	      	$("#ilmo").html("Tietojen päivittäminen onnistui.").css("color", "#019267");
			}
	  }});	
	}
});
</script>
</html>