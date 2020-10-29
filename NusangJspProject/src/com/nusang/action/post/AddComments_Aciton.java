package com.nusang.action.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nusang.action.Action;
import com.nusang.action.ActionForward;
import com.nusang.dao.ReplyDao;
import com.nusang.dto.Reply;
import com.nusang.dto.User;

public class AddComments_Aciton implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ActionForward actionForward = new ActionForward();
		actionForward.setAsyncData("");

		User user = (User) request.getSession().getAttribute("user");
		int userno = user.getUserno();

		System.out.println("replyText : " + request.getParameter("replyText"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("postno", Integer.parseInt(request.getParameter("postno")));
		map.put("textbody", request.getParameter("replyText"));
		map.put("userno", userno);
		map.put("state", 1);
		ReplyDao.getInstance().insert(map);
		return actionForward;
	}
}