package util;

import java.io.File;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailUtility {

    private static final String senderEmail =
            System.getenv("EMAIL_USERNAME");

    private static final String senderPassword =
            System.getenv("EMAIL_PASSWORD");

    public static void sendEmailWithAttachment(

            String receiverEmail,
            String subject,
            String messageText,
            String filePath

    ) {

        try {

            Properties props = new Properties();

            props.put("mail.smtp.auth", "true");

            props.put("mail.smtp.starttls.enable", "true");

            props.put("mail.smtp.host", "smtp.gmail.com");

            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(

                props,

                new Authenticator() {

                    protected PasswordAuthentication
                    getPasswordAuthentication() {

                        return new PasswordAuthentication(

                                senderEmail,
                                senderPassword
                        );
                    }
                }
            );

            Message message =
            new MimeMessage(session);

            message.setFrom(
            new InternetAddress(senderEmail));

            message.setRecipients(

                Message.RecipientType.TO,

                InternetAddress.parse(receiverEmail)

            );

            message.setSubject(subject);

            // TEXT PART
            MimeBodyPart textPart =
            new MimeBodyPart();

            textPart.setText(messageText);

            // FILE ATTACHMENT
            MimeBodyPart attachmentPart =
            new MimeBodyPart();

            attachmentPart.attachFile(
            new File(filePath));

            Multipart multipart =
            new MimeMultipart();

            multipart.addBodyPart(textPart);

            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);

            // SEND
            Transport.send(message);

            System.out.println(
            "Email Sent Successfully");

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}