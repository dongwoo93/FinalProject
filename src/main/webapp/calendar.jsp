<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<link href="resources/css/calendar.css" rel="stylesheet">
<!-- <link href="resources/css/calendar_print.css" rel="stylesheet" -->
<!-- 	media="print"> -->
<!-- <script src="resources/js/calendar.js"></script> -->
<!-- <script src="resources/js/jq.js"></script>   -->
<!-- <script src="resources/js/calendar.js"></script> -->  

<script>
	$(document).ready(function() {

		$('#calendar').fullCalendar({
			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'month,basicWeek,basicDay'
			},
			defaultDate : '2018-03-12',
			navLinks : true, // can click day/week names to navigate views
			editable : true,
			eventLimit : true, // allow "more" link when too many events
			events :{
// 				title : 'All Day Event',
// 				start : '2018-03-01'
			}  
		});
  
	});
</script>
<style>
body {
	margin: 40px 10px;
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar { 
	max-width: 900px;
	margin: 0 auto;
}
</style>
</head>
<body>

	<div id="calendar" class="fc fc-unthemed fc-ltr">
		<div class="fc-toolbar fc-header-toolbar">
			<div class="fc-left">
				<div class="fc-button-group">
					<button type="button"
						class="fc-prev-button fc-button fc-state-default fc-corner-left"
						aria-label="prev">
						<span class="fc-icon fc-icon-left-single-arrow"></span>
					</button>
					<button type="button"
						class="fc-next-button fc-button fc-state-default fc-corner-right"
						aria-label="next">
						<span class="fc-icon fc-icon-right-single-arrow"></span>
					</button>
				</div>
				<button type="button"
					class="fc-today-button fc-button fc-state-default fc-corner-left fc-corner-right fc-state-disabled"
					disabled="">today</button>
			</div>
			<div class="fc-right">
				<div class="fc-button-group">
					<button type="button"
						class="fc-month-button fc-button fc-state-default fc-corner-left fc-state-active">month</button>
					<button type="button"
						class="fc-basicWeek-button fc-button fc-state-default">week</button>
					<button type="button"
						class="fc-basicDay-button fc-button fc-state-default fc-corner-right">day</button>
				</div>
			</div>
			<div class="fc-center">
				<h2>August 2018</h2>
			</div>
			<div class="fc-clear"></div>
		</div>
		<div class="fc-view-container" style="">
			<div class="fc-view fc-month-view fc-basic-view" style="">
				<table class="">
					<thead class="fc-head">
						<tr>
							<td class="fc-head-container fc-widget-header"><div
									class="fc-row fc-widget-header">
									<table class="">
										<thead>
											<tr>
												<th class="fc-day-header fc-widget-header fc-sun"><span>Sun</span></th>
												<th class="fc-day-header fc-widget-header fc-mon"><span>Mon</span></th>
												<th class="fc-day-header fc-widget-header fc-tue"><span>Tue</span></th>
												<th class="fc-day-header fc-widget-header fc-wed"><span>Wed</span></th>
												<th class="fc-day-header fc-widget-header fc-thu"><span>Thu</span></th>
												<th class="fc-day-header fc-widget-header fc-fri"><span>Fri</span></th>
												<th class="fc-day-header fc-widget-header fc-sat"><span>Sat</span></th>
											</tr>
										</thead>
									</table>
								</div></td>
						</tr>
					</thead>
					<tbody class="fc-body">
						<tr>
							<td class="fc-widget-content"><div
									class="fc-scroller fc-day-grid-container"
									style="overflow: hidden; height: 648px;">
									<div class="fc-day-grid fc-unselectable">
										<div class="fc-row fc-week fc-widget-content fc-rigid"
											style="height: 108px;">
											<div class="fc-bg">
												<table class="">
													<tbody>
														<tr>
															<td
																class="fc-day fc-widget-content fc-sun fc-other-month fc-past"
																data-date="2018-07-29"></td>
															<td
																class="fc-day fc-widget-content fc-mon fc-other-month fc-past"
																data-date="2018-07-30"></td>
															<td
																class="fc-day fc-widget-content fc-tue fc-other-month fc-past"
																data-date="2018-07-31"></td>
															<td class="fc-day fc-widget-content fc-wed fc-past"
																data-date="2018-08-01"></td>
															<td class="fc-day fc-widget-content fc-thu fc-past"
																data-date="2018-08-02"></td>
															<td class="fc-day fc-widget-content fc-fri fc-past"
																data-date="2018-08-03"></td>
															<td class="fc-day fc-widget-content fc-sat fc-past"
																data-date="2018-08-04"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="fc-content-skeleton">
												<table>
													<thead>
														<tr>
															<td class="fc-day-top fc-sun fc-other-month fc-past"
																data-date="2018-07-29"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-07-29&quot;,&quot;type&quot;:&quot;day&quot;}">29</a></td>
															<td class="fc-day-top fc-mon fc-other-month fc-past"
																data-date="2018-07-30"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-07-30&quot;,&quot;type&quot;:&quot;day&quot;}">30</a></td>
															<td class="fc-day-top fc-tue fc-other-month fc-past"
																data-date="2018-07-31"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-07-31&quot;,&quot;type&quot;:&quot;day&quot;}">31</a></td>
															<td class="fc-day-top fc-wed fc-past"
																data-date="2018-08-01"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-01&quot;,&quot;type&quot;:&quot;day&quot;}">1</a></td>
															<td class="fc-day-top fc-thu fc-past"
																data-date="2018-08-02"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-02&quot;,&quot;type&quot;:&quot;day&quot;}">2</a></td>
															<td class="fc-day-top fc-fri fc-past"
																data-date="2018-08-03"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-03&quot;,&quot;type&quot;:&quot;day&quot;}">3</a></td>
															<td class="fc-day-top fc-sat fc-past"
																data-date="2018-08-04"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-04&quot;,&quot;type&quot;:&quot;day&quot;}">4</a></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="fc-row fc-week fc-widget-content fc-rigid"
											style="height: 108px;">
											<div class="fc-bg">
												<table class="">
													<tbody>
														<tr>
															<td class="fc-day fc-widget-content fc-sun fc-past"
																data-date="2018-08-05"></td>
															<td class="fc-day fc-widget-content fc-mon fc-past"
																data-date="2018-08-06"></td>
															<td class="fc-day fc-widget-content fc-tue fc-past"
																data-date="2018-08-07"></td>
															<td class="fc-day fc-widget-content fc-wed fc-past"
																data-date="2018-08-08"></td>
															<td class="fc-day fc-widget-content fc-thu fc-past"
																data-date="2018-08-09"></td>
															<td class="fc-day fc-widget-content fc-fri fc-past"
																data-date="2018-08-10"></td>
															<td class="fc-day fc-widget-content fc-sat fc-past"
																data-date="2018-08-11"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="fc-content-skeleton">
												<table>
													<thead>
														<tr>
															<td class="fc-day-top fc-sun fc-past"
																data-date="2018-08-05"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-05&quot;,&quot;type&quot;:&quot;day&quot;}">5</a></td>
															<td class="fc-day-top fc-mon fc-past"
																data-date="2018-08-06"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-06&quot;,&quot;type&quot;:&quot;day&quot;}">6</a></td>
															<td class="fc-day-top fc-tue fc-past"
																data-date="2018-08-07"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-07&quot;,&quot;type&quot;:&quot;day&quot;}">7</a></td>
															<td class="fc-day-top fc-wed fc-past"
																data-date="2018-08-08"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-08&quot;,&quot;type&quot;:&quot;day&quot;}">8</a></td>
															<td class="fc-day-top fc-thu fc-past"
																data-date="2018-08-09"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-09&quot;,&quot;type&quot;:&quot;day&quot;}">9</a></td>
															<td class="fc-day-top fc-fri fc-past"
																data-date="2018-08-10"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-10&quot;,&quot;type&quot;:&quot;day&quot;}">10</a></td>
															<td class="fc-day-top fc-sat fc-past"
																data-date="2018-08-11"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-11&quot;,&quot;type&quot;:&quot;day&quot;}">11</a></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="fc-row fc-week fc-widget-content fc-rigid"
											style="height: 108px;">
											<div class="fc-bg">
												<table class="">
													<tbody>
														<tr>
															<td class="fc-day fc-widget-content fc-sun fc-past"
																data-date="2018-08-12"></td>
															<td class="fc-day fc-widget-content fc-mon fc-past"
																data-date="2018-08-13"></td>
															<td class="fc-day fc-widget-content fc-tue fc-past"
																data-date="2018-08-14"></td>
															<td class="fc-day fc-widget-content fc-wed fc-past"
																data-date="2018-08-15"></td>
															<td class="fc-day fc-widget-content fc-thu fc-past"
																data-date="2018-08-16"></td>
															<td class="fc-day fc-widget-content fc-fri fc-past"
																data-date="2018-08-17"></td>
															<td class="fc-day fc-widget-content fc-sat fc-past"
																data-date="2018-08-18"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="fc-content-skeleton">
												<table>
													<thead>
														<tr>
															<td class="fc-day-top fc-sun fc-past"
																data-date="2018-08-12"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-12&quot;,&quot;type&quot;:&quot;day&quot;}">12</a></td>
															<td class="fc-day-top fc-mon fc-past"
																data-date="2018-08-13"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-13&quot;,&quot;type&quot;:&quot;day&quot;}">13</a></td>
															<td class="fc-day-top fc-tue fc-past"
																data-date="2018-08-14"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-14&quot;,&quot;type&quot;:&quot;day&quot;}">14</a></td>
															<td class="fc-day-top fc-wed fc-past"
																data-date="2018-08-15"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-15&quot;,&quot;type&quot;:&quot;day&quot;}">15</a></td>
															<td class="fc-day-top fc-thu fc-past"
																data-date="2018-08-16"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-16&quot;,&quot;type&quot;:&quot;day&quot;}">16</a></td>
															<td class="fc-day-top fc-fri fc-past"
																data-date="2018-08-17"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-17&quot;,&quot;type&quot;:&quot;day&quot;}">17</a></td>
															<td class="fc-day-top fc-sat fc-past"
																data-date="2018-08-18"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-18&quot;,&quot;type&quot;:&quot;day&quot;}">18</a></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="fc-row fc-week fc-widget-content fc-rigid"
											style="height: 108px;">
											<div class="fc-bg">
												<table class="">
													<tbody>
														<tr>
															<td class="fc-day fc-widget-content fc-sun fc-past"
																data-date="2018-08-19"></td>
															<td class="fc-day fc-widget-content fc-mon fc-past"
																data-date="2018-08-20"></td>
															<td class="fc-day fc-widget-content fc-tue fc-past"
																data-date="2018-08-21"></td>
															<td class="fc-day fc-widget-content fc-wed fc-past"
																data-date="2018-08-22"></td>
															<td class="fc-day fc-widget-content fc-thu fc-today "
																data-date="2018-08-23"></td>
															<td class="fc-day fc-widget-content fc-fri fc-future"
																data-date="2018-08-24"></td>
															<td class="fc-day fc-widget-content fc-sat fc-future"
																data-date="2018-08-25"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="fc-content-skeleton">
												<table>
													<thead>
														<tr>
															<td class="fc-day-top fc-sun fc-past"
																data-date="2018-08-19"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-19&quot;,&quot;type&quot;:&quot;day&quot;}">19</a></td>
															<td class="fc-day-top fc-mon fc-past"
																data-date="2018-08-20"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-20&quot;,&quot;type&quot;:&quot;day&quot;}">20</a></td>
															<td class="fc-day-top fc-tue fc-past"
																data-date="2018-08-21"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-21&quot;,&quot;type&quot;:&quot;day&quot;}">21</a></td>
															<td class="fc-day-top fc-wed fc-past"
																data-date="2018-08-22"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-22&quot;,&quot;type&quot;:&quot;day&quot;}">22</a></td>
															<td class="fc-day-top fc-thu fc-today "
																data-date="2018-08-23"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-23&quot;,&quot;type&quot;:&quot;day&quot;}">23</a></td>
															<td class="fc-day-top fc-fri fc-future"
																data-date="2018-08-24"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-24&quot;,&quot;type&quot;:&quot;day&quot;}">24</a></td>
															<td class="fc-day-top fc-sat fc-future"
																data-date="2018-08-25"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-25&quot;,&quot;type&quot;:&quot;day&quot;}">25</a></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="fc-row fc-week fc-widget-content fc-rigid"
											style="height: 108px;">
											<div class="fc-bg">
												<table class="">
													<tbody>
														<tr>
															<td class="fc-day fc-widget-content fc-sun fc-future"
																data-date="2018-08-26"></td>
															<td class="fc-day fc-widget-content fc-mon fc-future"
																data-date="2018-08-27"></td>
															<td class="fc-day fc-widget-content fc-tue fc-future"
																data-date="2018-08-28"></td>
															<td class="fc-day fc-widget-content fc-wed fc-future"
																data-date="2018-08-29"></td>
															<td class="fc-day fc-widget-content fc-thu fc-future"
																data-date="2018-08-30"></td>
															<td class="fc-day fc-widget-content fc-fri fc-future"
																data-date="2018-08-31"></td>
															<td
																class="fc-day fc-widget-content fc-sat fc-other-month fc-future"
																data-date="2018-09-01"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="fc-content-skeleton">
												<table>
													<thead>
														<tr>
															<td class="fc-day-top fc-sun fc-future"
																data-date="2018-08-26"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-26&quot;,&quot;type&quot;:&quot;day&quot;}">26</a></td>
															<td class="fc-day-top fc-mon fc-future"
																data-date="2018-08-27"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-27&quot;,&quot;type&quot;:&quot;day&quot;}">27</a></td>
															<td class="fc-day-top fc-tue fc-future"
																data-date="2018-08-28"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-28&quot;,&quot;type&quot;:&quot;day&quot;}">28</a></td>
															<td class="fc-day-top fc-wed fc-future"
																data-date="2018-08-29"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-29&quot;,&quot;type&quot;:&quot;day&quot;}">29</a></td>
															<td class="fc-day-top fc-thu fc-future"
																data-date="2018-08-30"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-30&quot;,&quot;type&quot;:&quot;day&quot;}">30</a></td>
															<td class="fc-day-top fc-fri fc-future"
																data-date="2018-08-31"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-08-31&quot;,&quot;type&quot;:&quot;day&quot;}">31</a></td>
															<td class="fc-day-top fc-sat fc-other-month fc-future"
																data-date="2018-09-01"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-01&quot;,&quot;type&quot;:&quot;day&quot;}">1</a></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										<div class="fc-row fc-week fc-widget-content fc-rigid"
											style="height: 108px;">
											<div class="fc-bg">
												<table class="">
													<tbody>
														<tr>
															<td
																class="fc-day fc-widget-content fc-sun fc-other-month fc-future"
																data-date="2018-09-02"></td>
															<td
																class="fc-day fc-widget-content fc-mon fc-other-month fc-future"
																data-date="2018-09-03"></td>
															<td
																class="fc-day fc-widget-content fc-tue fc-other-month fc-future"
																data-date="2018-09-04"></td>
															<td
																class="fc-day fc-widget-content fc-wed fc-other-month fc-future"
																data-date="2018-09-05"></td>
															<td
																class="fc-day fc-widget-content fc-thu fc-other-month fc-future"
																data-date="2018-09-06"></td>
															<td
																class="fc-day fc-widget-content fc-fri fc-other-month fc-future"
																data-date="2018-09-07"></td>
															<td
																class="fc-day fc-widget-content fc-sat fc-other-month fc-future"
																data-date="2018-09-08"></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="fc-content-skeleton">
												<table>
													<thead>
														<tr>
															<td class="fc-day-top fc-sun fc-other-month fc-future"
																data-date="2018-09-02"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-02&quot;,&quot;type&quot;:&quot;day&quot;}">2</a></td>
															<td class="fc-day-top fc-mon fc-other-month fc-future"
																data-date="2018-09-03"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-03&quot;,&quot;type&quot;:&quot;day&quot;}">3</a></td>
															<td class="fc-day-top fc-tue fc-other-month fc-future"
																data-date="2018-09-04"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-04&quot;,&quot;type&quot;:&quot;day&quot;}">4</a></td>
															<td class="fc-day-top fc-wed fc-other-month fc-future"
																data-date="2018-09-05"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-05&quot;,&quot;type&quot;:&quot;day&quot;}">5</a></td>
															<td class="fc-day-top fc-thu fc-other-month fc-future"
																data-date="2018-09-06"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-06&quot;,&quot;type&quot;:&quot;day&quot;}">6</a></td>
															<td class="fc-day-top fc-fri fc-other-month fc-future"
																data-date="2018-09-07"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-07&quot;,&quot;type&quot;:&quot;day&quot;}">7</a></td>
															<td class="fc-day-top fc-sat fc-other-month fc-future"
																data-date="2018-09-08"><a class="fc-day-number"
																data-goto="{&quot;date&quot;:&quot;2018-09-08&quot;,&quot;type&quot;:&quot;day&quot;}">8</a></td>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>



</body>
</html>