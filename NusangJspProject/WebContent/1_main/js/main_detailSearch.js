$(function(){
	//초기 프론트 세팅
	var h1 = $("#searchBar").css("height");
	var int_h1 = parseInt(h1);
	var h1px = int_h1+10+"px";
	$("#detailSearch-pop").css("top",h1px);
	
	$('input[value="5"]').attr("checked","checked");
	
	//함수 세팅
	$("#searchBtn").click(function(){
		doSearch();
	});
	
	$("#detailSearchForm").submit(function(){
		doSearch();
	});
	
	$("#chooseAll").click(function(){
		chooseAll();
	});
	
	$("#closeBtn").click(function(){
		$("#detailSearch-pop").hide();
		
		var cd = $("#caretdown");
		var cu = $("#caretup");
		if(cu.css("display")=="inline-block"){
			cd.css("display","inline-block");
			cu.css("display","none");
		}
	});
	
	
	/*$(document).click(function(e){ 
 		if(e.target.className =="detailSearch-pop"
			//|| e.target.className =="form-check-input"
			//|| e.target.className =="form-check-label"
			|| e.target.id =="detailSearchBtn"
			) {return false}
			
 		$("#detailSearch-pop").stop().fadeOut(0);
	
		var cd = $("#caretdown");
		var cu = $("#caretup");
		if(cu.css("display")=="inline-block"){
			cd.css("display","inline-block");
			cu.css("display","none");
		}
 	});*/



});


function doSearch(){
	var vv = $("#searchBar").val();
	if(vv == ""){
		alert("''에 대한 검색결과가 없습니다. \n검색어를 입력해주세요.");
		exit;
	}
	var checkedCates = $("input[name='category']:checked");
	if(checkedCates.length == 0){
		alert("적어도 한 개 이상의 카테고리를 선택해주세요.");
		exit;
	}
	$("#searchWord").val(vv);
	$("#submitBtn").trigger("click");
}

function doDisplay(){
	var cd = $("#caretdown");
	var cu = $("#caretup");
	var pop = $("#detailSearch-pop");
	if(cu.css("display")=="none"){
		cd.css("display","none");
		cu.css("display","inline-block");
		pop.css("display","block");
	}else{
		cd.css("display","inline-block");
		cu.css("display","none");
		pop.css("display","none");
	}
}

function chooseAll(){
	var allBtn = $("#chooseAll");
	var categories = $("input[name='category']");
	
	if(allBtn.is(":checked") == false) {
		console.log("선택->해제");
		categories.prop("checked",false);
	}else{
		console.log("해제->선택");
		categories.prop("checked",true);
	}
}

