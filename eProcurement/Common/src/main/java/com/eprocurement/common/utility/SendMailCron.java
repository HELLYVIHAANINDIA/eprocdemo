package com.eprocurement.common.utility;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import com.eprocurement.common.model.TblMailMessage;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;

@Service
//@EnableScheduling
public class SendMailCron {
	@Autowired
	private SpringMailSender mailSender;
	
	@Autowired
	private CommonService commonService;
	@Autowired
	private ExceptionHandlerService exceptionHandlerService;
	public static Boolean isDataAvailable=true;
	@Value("#{projectProperties['isProductionServer']}")
    private Boolean isProductionServer;
	
	/**
	 *  Cron expression : second, minute, hour, day of month, month, day(s) of week	
	 *  0 - is for seconds
	 *  1- 1 minute
	 *  1 - hour of the day. 
	 * @throws Exception
	 */

	@Scheduled(fixedDelay = 10000)
	public void fixedDelayTask() throws Exception {
		if(isProductionServer){
			StringBuilder mailmessageids=new StringBuilder("");
			if(isDataAvailable){
				List<TblMailMessage> list = commonService.getTblMailMessage();
				if(list!=null && !list.isEmpty()){
					try {
						mailmessageids = sendMailContent(list, mailmessageids);
						if (mailmessageids.length() > 0) {
							commonService.updateTblMailMessage(mailmessageids.substring(0, mailmessageids.length() - 1));
						}else{
							isDataAvailable = false;
						}
					} catch (Exception e) {
						exceptionHandlerService.writeLog(e);
						isDataAvailable = true;
					}
				}else{
					isDataAvailable = false;
				}
			}
		}
	}

	private StringBuilder sendMailContent(List<TblMailMessage> list, StringBuilder mailmessageids) throws Exception {
		for (TblMailMessage tblMailMessage : list) {
			boolean isSent = mailSender.sendMail("User", tblMailMessage.getMailBody(), tblMailMessage.getMailFrom(), tblMailMessage.getMailTo(), tblMailMessage.getMailSubject());
			if (isSent) {
				mailmessageids.append(tblMailMessage.getMailmessageid()).append(",");
			} else {
				isDataAvailable = true;
			}
		}
		return mailmessageids;
	}
}