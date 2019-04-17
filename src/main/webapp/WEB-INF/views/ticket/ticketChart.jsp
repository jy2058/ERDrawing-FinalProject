<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<br/><br/><br/>	
<div id="chartContainer" style="height: 400px; width: 100%;"></div>


${ticketBuyList }

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<script>
window.onload = function () {
	for(var i=0; i<='${fn:length(ticketBuyList)}'; i++){
		console.log("==i"+i);
	}
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	theme: "light2",
	title:{
		text: "Site Traffic"
	},
	axisX:{
		valueFormatString: "DD MMM",
		crosshair: {
			enabled: true,
			snapToDataPoint: true
		}
	},
	axisY: {
		title: "Number of Visits",
		crosshair: {
			enabled: true
		}
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
	
	
	data: [
		
		{
		type: "line",
		showInLegend: true,
		name: "Total Visit",
		markerType: "square",
		xValueFormatString: "DD MMM, YY",
		color: "#F08080",
		
		dataPoints: [
			
			{ x: new Date(17, 0,01), y: 650 },
			{ x: new Date(17, 1,01), y: 650 },
			{ x: new Date(17, 2,01), y: 650 },
			{ x: new Date(17, 3,01), y: 650 }
		]
	},
	
	
	{
		type: "line",
		showInLegend: true,
		name: "Unique Visit",
		lineDashType: "dash",
		dataPoints: [
			{ x: new Date(17, 0,01), y: 510 },
			{ x: new Date(17, 1,01), y: 560 },
			{ x: new Date(17, 2,01), y: 560 },
			{ x: new Date(17, 3,01), y: 560 }
		]
	}]
});
chart.render();

function toogleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	} else{
		e.dataSeries.visible = true;
	}
	chart.render();
}

}
</script>