package com.second_hand.base.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
@Transactional(propagation=Propagation.REQUIRED)
public class FileUploadAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	private File file;
	private String fileFileName;
	private String fileFileContenType;
	private String filePath;
	//用于标记上传成功或失败
	private String message = "0"; 
	private String path;
	private String deleteFile;

	//删除文件
	public String deleteFile(){
		File file = new File(path);
		if(file.exists()){
			boolean d = file.delete();
			if(d){
				deleteFile = "0";
			}else {
				deleteFile = "1";
			}
		}
		return "deleteFile";
	}

	//用户头像上传
	@SuppressWarnings("deprecation")
	public String uploadUserImg(){
		String path=ServletActionContext.getRequest().getRealPath("/userImg/");
		File file = new File(path); // 判断文件夹是否存在,如果不存在则创建文件夹
		if (!file.exists()) {
			file.mkdirs();
		}
		try {
			//创建一个文件输入流
			FileInputStream inputStream = new FileInputStream(this.getFile());
			//创建一个文件输出流
			FileOutputStream outputStream = new FileOutputStream(path + "\\" +fileFileName);
			//创建一个缓冲区
			byte[] buf = new byte[1024];
			//判断输入流读到缓冲区是否已经读完的标识
			int length = 0;
			//循环将输入流读到缓冲区当中
			while ((length = inputStream.read(buf)) != -1) {
				//使用FileOutputStream输出流将缓冲区的数据写入到指定的目录下
				outputStream.write(buf, 0, length);
			}
			
			message = "1";
			filePath = path + "\\" +fileFileName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "uploadUserImg";
	}
	
	//商品照片上传
	@SuppressWarnings("deprecation")
	public String upload() {
		String path=ServletActionContext.getRequest().getRealPath("/goodspic/");
		File file = new File(path); // 判断文件夹是否存在,如果不存在则创建文件夹
		if (!file.exists()) {
			file.mkdirs();
		}
		try {
			//创建一个文件输入流
			FileInputStream inputStream = new FileInputStream(this.getFile());
			//创建一个文件输出流
			FileOutputStream outputStream = new FileOutputStream(path + "\\" +fileFileName);
			//创建一个缓冲区
			byte[] buf = new byte[1024];
			//判断输入流读到缓冲区是否已经读完的标识
			int length = 0;
			//循环将输入流读到缓冲区当中
			while ((length = inputStream.read(buf)) != -1) {
				//使用FileOutputStream输出流将缓冲区的数据写入到指定的目录下
				outputStream.write(buf, 0, length);
			}
			inputStream.close();
			outputStream.flush();
			outputStream.close();
			message = "1";
			filePath = path + "\\" +fileFileName;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return "upload";
	}

	/**
	 * @return the file
	 */
	public File getFile() {
		return file;
	}
	/**
	 * @param file the file to set
	 */
	public void setFile(File file) {
		this.file = file;
	}
	/**
	 * @return the fileFileName
	 */
	public String getFileFileName() {
		return fileFileName;
	}
	/**
	 * @param fileFileName the fileFileName to set
	 */
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	/**
	 * @return the fileFileContenType
	 */
	public String getFileFileContenType() {
		return fileFileContenType;
	}
	/**
	 * @param fileFileContenType the fileFileContenType to set
	 */
	public void setFileFileContenType(String fileFileContenType) {
		this.fileFileContenType = fileFileContenType;
	}
	/**
	 * @return the filePath
	 */
	public String getFilePath() {
		return filePath;
	}
	/**
	 * @param filePath the filePath to set
	 */
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the path
	 */
	public String getPath() {
		return path;
	}

	/**
	 * @param path the path to set
	 */
	public void setPath(String path) {
		this.path = path;
	}

	/**
	 * @return the deleteFile
	 */
	public String getDeleteFile() {
		return deleteFile;
	}

	/**
	 * @param deleteFile the deleteFile to set
	 */
	public void setDeleteFile(String deleteFile) {
		this.deleteFile = deleteFile;
	}

}
