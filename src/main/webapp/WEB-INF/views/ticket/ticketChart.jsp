<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<br/><br/><br/>	
<div id="chartContainer" style="height: 400px; width: 100%;"></div>




<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script>
window.onload = function () {
	var dps = new Array();
	dps[0] = new Array();
var chart = new CanvasJS.Chart("chartContainer", {
	

	animationEnabled: true,
	theme: "light2",
	title:{
		text: "Site Traffic"
	},
	axisX: {
		intervalType: "month",
		interval: 1
	},
	axisY: {
		title: "Stock Price",
		prefix: "$",
		includeZero: false
	},
	toolTip:{
		shared:true
	},  
	legend:{
		cursor:"pointer",
		verticalAlign: "bottom",
		horizontalAlign: "left",
		dockInsidePlotArea: true,
		itemclick: toogleDataSeries
	},
	
	
	data: [{
		type: "line",
		showInLegend: true,
		name: "Total Visit",
		markerType: "square",
		xValueFormatString: "DD MMM, YY",
		dataPoints: dps[0]
	},{
		type: "line",
		showInLegend: true,
		name: "ss Visit",
		markerType: "square",
		xValueFormatString: "DD MMM, YY",
	dataPoints: dps[1]
	}]
});

var yValue;
var xValue;
<c:set var="sss" >
<fmt:formatDate value="${ticketBuyList.get(0).ticketBuyDt }" pattern="yy" />
</c:set>
yValue = new Date("${sss}");
xValue = parseFloat("${ticketBuyList.get(0).ticketFee}");
dps[0].push({
	x : xValue,
	y : yValue,});
	

dps[0].push({
	x : xValue,
	y : yValue,});
dps[0].push({
	x : xValue+10,
	y : yValue,});
dps[0].push({
	x : xValue+3,
	y : yValue,});
	
chart.render();

}
function toogleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	} else{
		e.dataSeries.visible = true;	
	}
	chart.render();
}


</script>