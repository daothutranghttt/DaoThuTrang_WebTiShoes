package TiShoes.Service.Mail;

import java.util.Properties;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;

@Controller
public class EmailService {
	public void sendEmail(String from, String to, String subject, String message) {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);
		mailSender.setUsername("thutrang9901@gmail.com");
		mailSender.setPassword("fqfzhyeinufkuxvs");

		Properties pr = new Properties();
		pr.put("mail.smtp.starttls.enable", "true");
		pr.put("mail.smtp.auth", "true");
		pr.put("mail.transport.protocol", "smtp");
		pr.put("mail.debug", "true");
		pr.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		mailSender.setJavaMailProperties(pr);

		SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
		simpleMailMessage.setFrom(from);
		simpleMailMessage.setTo(to);
		simpleMailMessage.setSubject(subject);
		simpleMailMessage.setText(message);
		mailSender.send(simpleMailMessage);
	}
}
