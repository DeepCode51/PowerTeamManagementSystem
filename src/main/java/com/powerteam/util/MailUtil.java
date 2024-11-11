package com.powerteam.util;

import com.powerteam.config.PowerTeamConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Component
public class MailUtil {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private PowerTeamConfig powerTeamConfig;

    @Async
    public void sendMail(String subject, String body, String[] to, String[] cc) {
        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper mail = new MimeMessageHelper(mimeMessage);
            mail.setSubject(subject);
            mail.setText(body);
            mail.setFrom(powerTeamConfig.getMailFrom());
            mail.setTo(to);
            if (cc != null) {
                mail.setCc(cc);
            }

            javaMailSender.send(mimeMessage);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    @Async
    public void sendMail(String subject, String body, String to) {
        String[] toList = {to};
        sendMail(subject, body, toList, null);
    }
}
