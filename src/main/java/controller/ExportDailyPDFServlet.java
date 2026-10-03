package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import dao.NotificationDAO;
import util.DBConnection;
import util.EmailUtility;

@WebServlet("/ExportDailyPDFServlet")
public class ExportDailyPDFServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String date = request.getParameter("date");

            System.out.println("📅 Date: " + date);

            // ✅ SAME AS WEEKLY (IMPORTANT)
            String pdfPath =
            getServletContext().getRealPath("/") +
            "daily_timetable.pdf";

            // ================= PDF CREATE =================
            Document document = new Document();

            PdfWriter.getInstance(
                document,
                new FileOutputStream(pdfPath)
            );

            document.open();

            Font titleFont =
            FontFactory.getFont(
                FontFactory.HELVETICA_BOLD, 20
            );

            Paragraph title =
            new Paragraph(
                "Daily Smart Timetable (" + date + ")",
                titleFont
            );

            title.setAlignment(Element.ALIGN_CENTER);

            document.add(title);
            document.add(new Paragraph(" "));

            // ================= TABLE =================
            PdfPTable table = new PdfPTable(6);

            table.setWidthPercentage(100);

            table.addCell("Class");
            table.addCell("Subject");
            table.addCell("Faculty");
            table.addCell("Room");
            table.addCell("Start");
            table.addCell("End");

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT c.class_name, s.subject_name, " +
            "u.name faculty_name, r.room_number, " +
            "dt.start_time, dt.end_time " +
            "FROM daily_timetable dt " +
            "JOIN classes c ON dt.class_id=c.class_id " +
            "JOIN subjects s ON dt.subject_id=s.subject_id " +
            "JOIN faculty f ON dt.faculty_id=f.faculty_id " +
            "JOIN users u ON f.faculty_id=u.user_id " +
            "JOIN classrooms r ON dt.room_id=r.room_id " +
            "WHERE dt.lecture_date=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, date);

            ResultSet rs = ps.executeQuery();

            boolean hasData = false;

            while (rs.next()) {

                hasData = true;

                table.addCell(rs.getString("class_name"));
                table.addCell(rs.getString("subject_name"));
                table.addCell(rs.getString("faculty_name"));
                table.addCell(rs.getString("room_number"));
                table.addCell(rs.getString("start_time"));
                table.addCell(rs.getString("end_time"));
            }

            if (!hasData) {
                document.add(new Paragraph("No lectures found"));
            } else {
                document.add(table);
            }

            document.close();

            System.out.println("✅ PDF Created");

            // ================= EMAIL =================
            String facultySql =
            "SELECT email FROM users WHERE role='FACULTY'";

            PreparedStatement facultyPs =
            con.prepareStatement(facultySql);

            ResultSet facultyRs =
            facultyPs.executeQuery();

            while (facultyRs.next()) {

                String facultyEmail =
                facultyRs.getString("email");

                EmailUtility.sendEmailWithAttachment(
                    facultyEmail,
                    "📅 Daily Timetable",
                    "Dear Faculty,\n\n" +
                    "Today's timetable has been uploaded.\n\n" +
                    "Please check attachment.",
                    pdfPath
                );
            }

            System.out.println("📧 Emails sent");

            // ================= NOTIFICATION =================
            NotificationDAO notifyDao =
            new NotificationDAO();

            notifyDao.sendNotificationToAllStudents(
                "📢 Daily Timetable Uploaded for " + date
            );

            // ================= DOWNLOAD =================
            response.setContentType("application/pdf");

            response.setHeader(
                "Content-Disposition",
                "attachment; filename=daily_timetable.pdf"
            );

            java.nio.file.Files.copy(
                new File(pdfPath).toPath(),
                response.getOutputStream()
            );

            response.getOutputStream().flush();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}