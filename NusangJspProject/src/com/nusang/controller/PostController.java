package com.nusang.controller;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nusang.action.Action;
import com.nusang.action.ActionForward;
import com.nusang.action.post.AddComments_Aciton;
import com.nusang.action.post.Buy_ReservationAction;
import com.nusang.action.post.CreatePost_Action;
import com.nusang.action.post.ReadPost_Action;
import com.nusang.action.post.UpdatePost_Action;
import com.nusang.controller.assistance.ConAsist;

@WebServlet("/post/*")
public class PostController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Action action = null;
		ActionForward actionForward = null;
		String requestPage = ConAsist.getRequestName(request);
		actionForward = ConAsist.checkLogin(request);
		if (actionForward == null) {

			try {
				switch (requestPage) {
				case "readPost":
					action = new ReadPost_Action();
					actionForward = action.execute(request, response);
					break;
				case "updatePost":
					action = new UpdatePost_Action();
					actionForward = action.execute(request, response);
					break;
				case "createPost":
					action = new CreatePost_Action();
					actionForward = action.execute(request, response);
					break;
				case "moveMkPost":
					actionForward = new ActionForward();
					actionForward.setNextPath(ConAsist.URL_MKPOST);
					break;
				case "addComments":
					AddComments_Aciton A_A = new AddComments_Aciton();
					actionForward = A_A.execute(request, response);
					break;
				case "buy_reservation":
					action = new Buy_ReservationAction();
					actionForward = action.execute(request, response);
					break;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		actionForward.moveUrl(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
