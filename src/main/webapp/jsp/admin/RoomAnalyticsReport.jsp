<%@ page import="model.RoomReport"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,dao.RoomAnalyticsDAO,model.RoomUtilization"%>
<%@ page import="model.RoomReport"%>

<%
RoomReport report = (RoomReport) request.getAttribute("report");
%>

<%
RoomAnalyticsDAO dao = new RoomAnalyticsDAO();

List<RoomUtilization> list = dao.getRoomUtilization();
%>

<%
if (report == null) {
	response.sendRedirect(request.getContextPath() + "/GenerateRoomReportServlet");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Analytics Report</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: #f4f6f9;
	font-family: Arial;
}

.report-container {
	max-width: 900px;
	margin: 50px auto;
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
}

.report-title {
	text-align: center;
	margin-bottom: 40px;
	font-weight: bold;
}

.report-card {
	background: #f8f9fa;
	border-left: 6px solid #0d6efd;
	padding: 25px;
	margin-bottom: 25px;
	border-radius: 12px;
}

.report-card h4 {
	margin-bottom: 15px;
	color: #0d6efd;
}
</style>

</head>

<body>

	<div class="report-container">

		<div style="margin-bottom: 20px; display: flex; gap: 15px;">

			<!-- PRINT BUTTON -->
			<button onclick="window.print()"
				style="background: #0d6efd; color: white; border: none; padding: 10px 18px; border-radius: 6px; cursor: pointer; font-weight: bold;">

				🖨 Print Report</button>

			<!-- SAVE PDF BUTTON -->
			<button onclick="downloadPDF()"
				style="background: #198754; color: white; border: none; padding: 10px 18px; border-radius: 6px; cursor: pointer; font-weight: bold;">

				📄 Save as PDF</button>

		</div>

		<h1 class="report-title">📊 Classroom Analytics Report</h1>

		<!-- Peak Time -->
		<div class="report-card">

			<h4>⏰ Peak Time Analysis</h4>

			<p>
				<%=report.getPeakTime()%>
			</p>

		</div>

		<!-- Usage Pattern -->
		<div class="report-card">

			<h4>📈 Usage Pattern Analysis</h4>

			<p>
				<%=report.getUsagePattern()%>
			</p>

		</div>

		<!-- Resource Analytics -->
		<div class="report-card">

			<h4>🏫 Resource Analytics Report</h4>

			<p>
				<%=report.getBusiestRoom()%>
			</p>

			<p>
				<%=report.getUnderutilizedRoom()%>
			</p>

		</div>


		<div class="text-center mt-4">

			<a href="<%=request.getContextPath()%>/jsp/admin/RoomAnalytics.jsp"
				class="btn btn-dark btn-lg"> ⬅ Back To Analytics </a>

		</div>

	</div>

</body>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<script>
	function downloadPDF() {

		const element = document.body;

		const opt = {
			margin : 0.5,
			filename : 'Room_Analytics_Report.pdf',
			image : {
				type : 'jpeg',
				quality : 1
			},
			html2canvas : {
				scale : 2
			},
			jsPDF : {
				unit : 'in',
				format : 'a4',
				orientation : 'portrait'
			}
		};

		html2pdf().set(opt).from(element).save();
	}
</script>

</html>