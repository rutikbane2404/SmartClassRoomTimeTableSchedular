package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;

import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import dao.NotificationDAO;
import util.DBConnection;
import util.EmailUtility;

@WebServlet("/ExportWeeklyPDFServlet")

public class ExportWeeklyPDFServlet
extends HttpServlet {

    protected void doGet(

            HttpServletRequest request,
            HttpServletResponse response

    )

    throws ServletException, IOException {

        try {

            // PDF PATH
            String pdfPath =

            getServletContext()

            .getRealPath("/")

            + "weekly_timetable.pdf";

            // CREATE PDF
            Document document =
            new Document();

            PdfWriter.getInstance(

                document,

                new FileOutputStream(pdfPath)

            );

            document.open();

            Font titleFont =
            FontFactory.getFont(

                FontFactory.HELVETICA_BOLD,
                20

            );

            Paragraph title =
            new Paragraph(

            "Weekly Smart Timetable",

            titleFont

            );

            title.setAlignment(
            Element.ALIGN_CENTER);

            document.add(title);

            document.add(new Paragraph(" "));

            // TABLE
            PdfPTable table =
            new PdfPTable(7);

            table.setWidthPercentage(100);

            table.addCell("Day");
            table.addCell("Class");
            table.addCell("Subject");
            table.addCell("Faculty");
            table.addCell("Room");
            table.addCell("Start");
            table.addCell("End");

            Connection con =
            DBConnection.getConnection();

            String sql =

            "SELECT t.day_of_week, " +

            "c.class_name, " +

            "s.subject_name, " +

            "u.name faculty_name, " +

            "r.room_number, " +

            "t.start_time, " +

            "t.end_time " +

            "FROM timetable t " +

            "JOIN classes c " +

            "ON t.class_id=c.class_id " +

            "JOIN subjects s " +

            "ON t.subject_id=s.subject_id " +

            "JOIN faculty f " +

            "ON t.faculty_id=f.faculty_id " +

            "JOIN users u " +

            "ON f.faculty_id=u.user_id " +

            "JOIN classrooms r " +

            "ON t.room_id=r.room_id";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ResultSet rs =
            ps.executeQuery();

            while(rs.next()){

                table.addCell(
                rs.getString("day_of_week"));

                table.addCell(
                rs.getString("class_name"));

                table.addCell(
                rs.getString("subject_name"));

                table.addCell(
                rs.getString("faculty_name"));

                table.addCell(
                rs.getString("room_number"));

                table.addCell(
                rs.getString("start_time"));

                table.addCell(
                rs.getString("end_time"));
            }

            document.add(table);

            document.close();

            // EMAIL ALL FACULTY
            String facultySql =

            "SELECT email FROM users " +

            "WHERE role='FACULTY'";

            PreparedStatement facultyPs =
            con.prepareStatement(facultySql);

            ResultSet facultyRs =
            facultyPs.executeQuery();

            while(facultyRs.next()){

                String facultyEmail =

                facultyRs.getString("email");

                EmailUtility.sendEmailWithAttachment(

                    facultyEmail,

                    "📅 New Weekly Timetable",

                    "Dear Faculty,\n\n" +

                    "New weekly timetable " +

                    "has been uploaded.\n\n" +

                    "Please check attachment.",

                    pdfPath
                );
            }

            // SEND NOTIFICATIONS
            NotificationDAO notifyDao =
            new NotificationDAO();

            notifyDao
            .sendNotificationToAllStudents(

            "📢 New Weekly Timetable Uploaded"

            );

            // DOWNLOAD PDF
            response.setContentType(

            "application/pdf");

            response.setHeader(

            "Content-Disposition",

            "attachment; filename=weekly_timetable.pdf"

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