package com.eprocurement.etender.controller;

import java.awt.Color;
import java.awt.Insets;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.lowagie.text.DocumentException;

@Controller
public class ExportController {

	@Value("#{projectProperties['doc_upload_path']}")
	private String docUploadPath;
	
	@Autowired
	ExceptionHandlerService exceptionHandlerService;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	ServletContext context;
	private static StringBuilder stylesheet = new StringBuilder();
	
	
    @RequestMapping(value = "/exportDataFromPage", method = RequestMethod.POST)
    public void generatePDF(HttpServletRequest request, HttpServletResponse response) {
    	try {
        	int generateType =  StringUtils.hasLength(request.getParameter("txtGenerateType")) ? Integer.parseInt(request.getParameter("txtGenerateType")) : 0;
        	String pdfBuffer =  request.getParameter("pdfBuffer");//setFileDefaultData(request); 
            String fileName = request.getParameter("fileName");
            
            if (StringUtils.hasLength(pdfBuffer) && StringUtils.hasLength(fileName)) {
            	reportGeneration(pdfBuffer, fileName, (docUploadPath), generateType, response, request);
            } else {
            	response.sendRedirect(request.getHeader("referer"));
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
    }
    
    @RequestMapping(value = "/ajaxcall/deleteFile", method = RequestMethod.POST)
    @ResponseBody
    public String DeleteFile(@RequestParam("filePath") String filePath) {
    	File file = new File(filePath);
        deleteIfExist(file);
    	return filePath;
    }
    
    private void reportGeneration(String pdfBuffer, String fileName, String path, int generateType, HttpServletResponse response, HttpServletRequest request) throws IOException, DocumentException, ServletException {
    	pdfBuffer = pdfBuffer.replace("<br>", "<br/>").replace("&nbsp;", " ").replace(" & ", "&amp;").replace("colSpan", "colspan").replace("=\"\"","").replace("BR", "br/");
        
    	File destFolder = new File(path + File.separator + "temp");
        if (destFolder.exists() == false) {
            destFolder.mkdirs();
        }
        if(fileName == null || fileName.isEmpty() || fileName.indexOf("undefined") != -1){
        	fileName = "dataExported";
        }
        fileName = fileName.trim();
        String filePath = path + File.separator + "temp" + File.separator + fileName;
        File file = new File(filePath);
    	ServletOutputStream outputStream = response.getOutputStream();
    	FileOutputStream fos = new FileOutputStream(file);
    	//String cssPath1 = "eProcurement";
        /*if(request.getRequestURL().indexOf(request.getContextPath()) != -1){
        	cssPath1 = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getContextPath())+request.getContextPath().length());
        }*/
        StringBuilder htmls = generateFinalData(request,generateType,pdfBuffer);
        Document htmlParseTagCompleteString = Jsoup.parse(htmls.toString());     
        String finalData= htmlParseTagCompleteString.toString();
        finalData = finalData.replace("&", "&amp;");
    if(generateType == 0) {
        	response.setContentType("application/pdf");
       		response.setContentType("application/octet-stream");
	        response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + ".pdf\"");
            PD4ML pd4mlRender = new PD4ML();
            pd4mlRender.useServletContext(request.getServletContext());
            //pd4mlRender.enableDebugInfo();
            pd4mlRender.addStyle(request.getServletContext().getRealPath("/resources/template1/css/style.css"), true);
            pd4mlRender.addStyle(request.getServletContext().getRealPath("/resources/css/bootstrap.min.css"), true);
            pd4mlRender.addStyle(request.getServletContext().getRealPath("/resources/js/datatable/css/buttons.dataTables.min.css"), true);
            pd4mlRender.adjustHtmlWidth();   
            pd4mlRender.setHtmlWidth(800);
            pd4mlRender.setPageSize(PD4Constants.A4);
            pd4mlRender.setPageInsets(new Insets(20, 15, 25, 15));
            //pd4mlRender.enableSmartTableBreaks(true);
            
            PD4PageMark footer = new PD4PageMark(); // page number is displayed in pdf footer
            footer.setAreaHeight(20);
            footer.setFontSize(12);
            footer.setColor(Color.darkGray);
            footer.setPageNumberTemplate("Page $[page] of $[total]");
            footer.setPageNumberAlignment(PD4PageMark.RIGHT_ALIGN);
            pd4mlRender.setPageFooter(footer);
            finalData = finalData.replaceAll("word-break", "word-wrap");
            InputStream stream = new ByteArrayInputStream(finalData.getBytes(Charset.forName("UTF-8"))); 
            InputStreamReader isr = new InputStreamReader(stream, "UTF-8");
            //pd4mlRender.useTTF(fontPath, true);
            //pd4mlRender.render(isr,outputStream);
            pd4mlRender.render(isr,fos);
            FileInputStream fis= new FileInputStream(file);
            int i = 0;
            while((i=fis.read())!= -1){
            	outputStream.write(i);
            }
            fis.close();
            deleteIfExist(file); 
        } else if(generateType == 2) {
           response.setContentType("text/html;charset=UTF-8");
           response.setCharacterEncoding("UTF-8");
           response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + ".html\"");
           outputStream.write(htmls.toString().getBytes());
       } else if(generateType == 3) {
           response.setContentType("application/vnd.ms-word");
           response.setCharacterEncoding("UTF-8");
           response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + ".doc\"");
           outputStream.write(finalData.getBytes());
       } else if(generateType == 4) {
           response.setContentType("application/vnd.ms-excel");
           response.setCharacterEncoding("UTF-8");
           response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + ".xls\"");
           finalData = removeSpecialChars(finalData); 
           outputStream.write(finalData.getBytes());
       } 
    }
	
    /*private String setFileDefaultData(HttpServletRequest request) throws MalformedURLException {    	        
    	int generateType =  StringUtils.hasLength(request.getParameter("txtGenerateType")) ? Integer.parseInt(request.getParameter("txtGenerateType")) : 0;
    	URL url = new URL(request.getRequestURL().toString());
        
    	StringBuilder imagePath = new StringBuilder();
    	if(generateType == 0 || generateType == 1 || generateType == 5) {
    		imagePath.append(((url.getPort() != 80) && (url.getPort() != 443) && (url.getPort() != -1)) ? "http" : "http").append("://").append(url.getHost());  // internalIp
    		if ((url.getPort() != 80) && (url.getPort() != 443) && (url.getPort() != -1)) {
            	imagePath.append(":").append(url.getPort());
            }
    	} else if (generateType == 2){
    		imagePath.append(((url.getPort() != 80) && (url.getPort() != 443) && (url.getPort() != -1)) ? "http" : "https").append("://").append(url.getHost());
    		if ((url.getPort() != 80) && (url.getPort() != 443) && (url.getPort() != -1)) {
            	imagePath.append(":").append(url.getPort());
            }
    	}
        imagePath.append(request.getContextPath()).append("/resources/static-images/Logo/eMarketPlace.png");
        
        String headerLogo = "";
        if(generateType == 0 || generateType == 1 || generateType == 2 || generateType == 5){
        	headerLogo = "<div style='margin: 15px 10%;' align='center'><img width=\"100%\" src=\""+imagePath+"\" /></div>";
        }
        return headerLogo + request.getParameter("pdfBuffer");
    }*/
    
    public StringBuilder generateFinalData(HttpServletRequest request, int generateType, String pdfBuffer){		
        StringBuilder htmls = new StringBuilder();
        //String cssPath1 = "eProcurement";
        /*if(request.getRequestURL().indexOf(request.getContextPath()) != -1){
        	cssPath1 = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getContextPath())+request.getContextPath().length());
        }*/
        htmls.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
        htmls.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
        htmls.append("<head>");
       /* if(stylesheet.length() <= 0){
        	stylesheet.append(getHTMLContent(cssPath1+"/resources/template1/css/style.css"));
        	stylesheet.append(getHTMLContent(cssPath1+"/resources/css/bootstrap.min.css"));
        	stylesheet.append(getHTMLContent(cssPath1+"/resources/js/datatable/css/buttons.dataTables.min.css"));
        }
        */
        /*htmls.append("<link rel='stylesheet' href='"+cssPath1+"/resources/template1/css/style.css' />");	
    	htmls.append("<link rel='stylesheet' href='"+cssPath1+"/resources/css/bootstrap.min.css' />");
    	htmls.append("<link rel='stylesheet' href='"+cssPath1+"/resources/js/datatable/css/buttons.dataTables.min.css' />");*/
    	/*htmls.append("<style type=\"text/css\">");
    	htmls.append(stylesheet);
    	//htmls.append(".noExport{display:none;} table{width: 100%;} table tr td {word-wrap: break-word;} .box-body{display: block !important;} .box-title{font-size: 20px !important; font-weight: bold !important; color: black !important}");
        htmls.append("</style>");*/
        htmls.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
		if(generateType == 3) {
	        htmls.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
	    } else { 
	        htmls.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
	    }
		htmls.append("</head>");
        htmls.append("<body>").append(pdfBuffer).append("</body></html>");
        return htmls; 
	}
    
   /* private String pdfGenerationForPrint(String pdfBuffer, String fileName, File file, int generateType, HttpServletResponse response, HttpServletRequest request) throws IOException, DocumentException, ServletException {
        pdfBuffer = pdfBuffer.replaceAll("<br>", "<br/>").replaceAll("Â­ ","-").replaceAll("&shy; "," ").replaceAll("Ã‚"," ").replaceAll("&nbsp;"," ").replaceAll("&", "&amp;").replaceAll("colSpan", "colspan").replace("=\"\"","");
        FileOutputStream fos = new FileOutputStream(file);
        
        StringBuilder htmls = generateFinalData(request,generateType,pdfBuffer);
        Document htmlParseTagCompleteString = Jsoup.parse(htmls.toString());		
        String finalData= AbcUtility.reverseReplaceSpecialChars(htmlParseTagCompleteString.toString());
    	
        PD4ML pd4mlRender = new PD4ML();
        //pd4mlRender.enableDebugInfo();
        pd4mlRender.adjustHtmlWidth();                
        String fontPath = request.getServletContext().getRealPath("/WEB-INF/i18n/fonts");
        pd4mlRender.useTTF(fontPath, true );
        pd4mlRender.setDefaultTTFs("Calibri","Times New Roman", "Arial"); 
        //pd4mlRender.enableSmartTableBreaks(true);
        finalData = finalData.replaceAll("word-break", "word-wrap");
        StringReader stringDate = new StringReader(finalData);
        pd4mlRender.render(stringDate,fos);

        return file.getAbsolutePath();  
	}*/
    
    private void deleteIfExist(File file) {
    	try {
    		if (file.exists()){
    			file.delete();
    		}
    	}catch(Exception e) {
    		exceptionHandlerService.writeLog(e);
    	}
    }
    
    public static String removeSpecialChars(String str) {
		 return str.replaceAll("(?s)&amp;lt;.*?&amp;gt;", " ");
	}
    
    
    /*   if(false && ( generateType == 0 || generateType == 1)) {
        	com.lowagie.text.Document document = new com.lowagie.text.Document();
        	//String fileNameWithPath = path + "PDF-HtmlWorkerParsed.pdf";
        	//FileOutputStream fos = new FileOutputStream( fileNameWithPath );
        	PdfWriter pdfWriter = PdfWriter.getInstance( document, fos );
        	document.open();
        	// if required, you can add document meta data
        	document.addAuthor( "Ravinder" );
        	//document.addCreator( creator );
        	document.addSubject( "HtmlWoker Parsed Pdf from iText" );
        	document.addCreationDate();
        	document.addTitle( "HtmlWoker Parsed Pdf from iText" );

        	HTMLWorker htmlWorker = new HTMLWorker( document );
        	htmlWorker.parse( new StringReader( pdfBuffer ) );

        	document.close();
        	fos.close();

        	FileInputStream fis = new FileInputStream(file);
            byte[] buf = new byte[(int) file.length()];
            int offset = 0;
            int numRead = 0;
            while ((offset < buf.length) && ((numRead = fis.read(buf, offset, buf.length - offset)) >= 0)) {
                offset += numRead;
            }
            
            // gets MIME type of the file
            String mimeType = context.getMimeType(filePath);
            if (mimeType == null) {        
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }
             
            // modifies response
            response.setContentType(mimeType);
            response.setContentLength((int) file.length());
            response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName.trim() +".pdf\"");
            outputStream = response.getOutputStream();
            outputStream.write(buf);
            outputStream.flush();
            outputStream.close();
            document.close();
            fos.close();
            deleteIfExist(file); 
       }*/
    
    public static String getHTMLContent(String reqUrl) {

        URL url;
        StringBuilder inputLine = new StringBuilder("");
        try {
            url = new URL(reqUrl);
            URLConnection conn = url.openConnection();

            // open the stream and put it into BufferedReader
            BufferedReader br = new BufferedReader(
                               new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = br.readLine()) != null) {
                    inputLine.append(line);
            }
            br.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return inputLine.toString();
    }
}