package com.nusang.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nusang.dto.User;

import lombok.Data;

@Data
public class ActionForward {
	private String nextPath;
	private EActionType actionType = EActionType.FORWARD;
	private String asyncData;

	public String getNextPath() {
		System.out.println("nextpath: " + nextPath);
		return nextPath;
	}

	public void setNextPath(String nextPath) {
		this.nextPath = nextPath;
	}

	public void setAsyncData(String asyncData) {
		this.asyncData = asyncData;
		actionType = EActionType.ASYNC;
	}

	public void moveUrl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		switch (getActionType()) {
		case FORWARD:
			request.getRequestDispatcher( getNextPath()).forward(request, response);
			break;

		case REDIRECT:
			response.sendRedirect(getNextPath());
			break;

		case ASYNC:
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(getAsyncData());
			break;
		}
	}

}
