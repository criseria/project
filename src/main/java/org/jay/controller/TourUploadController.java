package org.jay.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


import org.jay.domain.TourAttachDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@Controller
public class TourUploadController {

	@GetMapping("/touruploadAjax")
	public void touruploadAjax() {
		log.info("upload ajax");
	}
	
	@PostMapping(value = "/touruploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<TourAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update ajax post......");
		
		List<TourAttachDTO> list = new ArrayList<TourAttachDTO>();
		
		String uploadFolder = "D:\\workspace\\workspace_spring\\test02\\src\\main\\webapp\\resources\\image";
		String uploadFolderPath = getFolder();
		
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("--------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// 파일 정보를 담을 객체 생성
			TourAttachDTO tourattachVO = new TourAttachDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name : " + uploadFileName);
			tourattachVO.setTou_image(uploadFileName);
			
			// 중복 방지를 위한 UUID
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				tourattachVO.setUuid(uuid.toString());
				tourattachVO.setUploadPath(uploadFolderPath);
				
				
				// 이미지 파일 체크
				if(checkImageType(saveFile)) {
					tourattachVO.setFileType(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
				list.add(tourattachVO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	@GetMapping("/tourdisplay")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
	   log.info("fileName: " + fileName);
	   File file = new File("D:\\workspace\\workspace_spring\\test02\\src\\main\\webapp\\resources\\image" + fileName);
	   log.info("file : " + file);
	      
	   ResponseEntity<byte[]> result = null;
	      
	   try {
	      HttpHeaders header = new HttpHeaders();
	         
	      header.add("Content-Type", Files.probeContentType(file.toPath()));
	         
	      result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
	         
	   } catch (Exception e) {
	      e.printStackTrace();
	   }
	   return result;
	}
	
	@GetMapping(value = "/tourdownload", produces =MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		log.info("fileName : " + fileName);
		Resource resource = new FileSystemResource("D:\\workspace\\workspace_spring\\test02\\src\\main\\webapp\\resources\\image" + fileName);
		
		log.info("resource : " + resource);
		
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE / Edge");
				downloadName = URLEncoder.encode(resourceOriginalName, "utf-8").replaceAll("\\+", "");
				log.info("IE / Edge : " + downloadName);
			}else {
				log.info("Chrome");
				downloadName = new String(resourceOriginalName.getBytes("utf-8"), "ISO-8859-1");
			}
			header.add("Content-Disposition",
					"attachment; filename=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	
	@PostMapping("/tourdeleteFile")
	@ResponseBody
	public ResponseEntity<String> tourdeleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);
		
		File file = null;
		
		try {
			file = new File("D:\\workspace\\workspace_spring\\test02\\src\\main\\webapp\\resources\\image" + URLDecoder.decode(fileName, "utf-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted" ,HttpStatus.OK);
	}
}
