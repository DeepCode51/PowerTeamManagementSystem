package com.powerteam.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
public class PowerTeamConfig {

    /**
     * 网站的根路径 例如 /powerteam
     */
    private String webRoot;

    /**
     * 网站绝对物理路径 例如 D:/Tomcat/webapps/powerteam/WEB-INF/classes/
     */
    private String absoluteWebRoot;

    @Value("${powerTeam.title}")
    private String title;

    @Value("${powerTeam.pageSize}")
    private Integer pageSize;

    @Value("${powerTeam.baiduMapAk}")
    private String baiduMapAk;

    @Value("${spring.mail.username}")
    private String mailFrom;

	/**
	 * @return the webRoot
	 */
	public String getWebRoot() {
		return webRoot;
	}

	/**
	 * @param webRoot the webRoot to set
	 */
	public void setWebRoot(String webRoot) {
		this.webRoot = webRoot;
	}

	/**
	 * @return the absoluteWebRoot
	 */
	public String getAbsoluteWebRoot() {
		return absoluteWebRoot;
	}

	/**
	 * @param absoluteWebRoot the absoluteWebRoot to set
	 */
	public void setAbsoluteWebRoot(String absoluteWebRoot) {
		this.absoluteWebRoot = absoluteWebRoot;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the pageSize
	 */
	public Integer getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return the baiduMapAk
	 */
	public String getBaiduMapAk() {
		return baiduMapAk;
	}

	/**
	 * @param baiduMapAk the baiduMapAk to set
	 */
	public void setBaiduMapAk(String baiduMapAk) {
		this.baiduMapAk = baiduMapAk;
	}

	/**
	 * @return the mailFrom
	 */
	public String getMailFrom() {
		return mailFrom;
	}

	/**
	 * @param mailFrom the mailFrom to set
	 */
	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}
    
    
}
