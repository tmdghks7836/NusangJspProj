package com.nusang.dao;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.nusang.dto.Buy_Reservation;
import com.nusang.dto.Location;
import com.nusang.dto.Payment_Market;
import com.nusang.dto.Payment_User;
import com.nusang.dto.Post;
import com.nusang.dto.Post_Picture;
import com.nusang.dto.User;

public class PostDao extends BasicDao<Post> {

	private static PostDao instance;

	public static PostDao getInstance() {

		if (instance == null) { // mapper의 namespace
			instance = new PostDao("postMapper.");
		}

		return instance;
	}

	private PostDao(String namespace) {
		super(namespace, "postno");
	}

	public int insertPost(Post post, List<String> fileSystemNames, Payment_Market pm) {
		SqlSession session = sqlSessionFactory.openSession();
		try {

			LocationDao.getInstance().insert(session, post.getLocation());
			Post_PictureDao.getInstance().insert(session, post.getPost_picture()); // 1
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("Post_picno 값 : " + post.getPost_picture().getPost_picno());
			System.out.println("locationno 값 : " + post.getLocation().getLocationno());
			insert(session, post);
			pm.setPost(post);
			Payment_MarketDao.getInstance().insert(session, pm);

			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return post.getPostno();
	}

	public int deletetPost_CreatePM(Payment_Market pm) {
		SqlSession session = sqlSessionFactory.openSession();
		int result = 0;
		try {

			deleteBy(session, pm.getPost().getPostno());
			result=  Payment_MarketDao.getInstance().insert(session, pm);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return result;
	}

	public int updatePost(Post post, List<String> fileSystemNames) {
		SqlSession session = sqlSessionFactory.openSession();
		int result = 0;
		try {

			LocationDao.getInstance().update(session, post.getLocation());
			Post_PictureDao.getInstance().update(session, post.getPost_picture());

			result = update(session, post);

			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return result;
	}

	public ArrayList<Post> findPostNearBy10km(Location comLocation) {
		SqlSession session = sqlSessionFactory.openSession();
		List<Post> postList = new ArrayList<Post>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("latitude", comLocation.getLatitude());
			map.put("longtitude", comLocation.getLongtitude());
			postList = session.selectList(namespace + "findPostNearBy10km", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return (ArrayList<Post>) postList;
	}
	
	public ArrayList<Post> findPostByLocation(Location userLocation, int distance) {
		SqlSession session = sqlSessionFactory.openSession();
		List<Post> postList = new ArrayList<Post>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("lat : " + userLocation.getLatitude());
			System.out.println("long : " + userLocation.getLongtitude());
			map.put("latitude", userLocation.getLatitude());
			map.put("longtitude", userLocation.getLongtitude());
			map.put("distance", distance);
			postList = session.selectList(namespace + "findPostByLocation", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return (ArrayList<Post>) postList;
	}

	public ArrayList<Post> findPostByKeyword(String searchWord,Location comLocation) {
		SqlSession session = sqlSessionFactory.openSession();
		List<Post> postList = new ArrayList<Post>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("lat : " + comLocation.getLatitude());
			System.out.println("long : " + comLocation.getLongtitude());
			map.put("latitude", comLocation.getLatitude());
			map.put("longtitude", comLocation.getLongtitude());
			map.put("searchWord", searchWord);
			postList = session.selectList(namespace + "findPostByKeyword", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return (ArrayList<Post>) postList;
	}
	public ArrayList<Post> findPostByDetailSearch(String searchWord, String categories, String order, int price_min, int price_max, int distance,
			Location userLocation) {
		SqlSession session = sqlSessionFactory.openSession();
		List<Post> postList = new ArrayList<Post>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("lat : " + userLocation.getLatitude());
			System.out.println("long : " + userLocation.getLongtitude());
			map.put("latitude", userLocation.getLatitude());
			map.put("longtitude", userLocation.getLongtitude());
			map.put("searchWord", searchWord);
			map.put("categories", categories);
			map.put("order", order);
			map.put("price_min", price_min);
			map.put("price_max", price_max);
			map.put("distance", distance);
			postList = session.selectList(namespace + "findPostByDetailSearch", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return (ArrayList<Post>) postList;
	}
	
	public ArrayList<Post> findPost_searchWordNull(String categories, String order, int price_min, int price_max, int distance,
			Location userLocation) {
		SqlSession session = sqlSessionFactory.openSession();
		List<Post> postList = new ArrayList<Post>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("lat : " + userLocation.getLatitude());
			System.out.println("long : " + userLocation.getLongtitude());
			map.put("latitude", userLocation.getLatitude());
			map.put("longtitude", userLocation.getLongtitude());
			map.put("categories", categories);
			map.put("order", order);
			map.put("price_min", price_min);
			map.put("price_max", price_max);
			map.put("distance", distance);
			postList = session.selectList(namespace + "findPostWithoutSearchword", map);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return (ArrayList<Post>) postList;
	}

	public int sellPost(int postno, int reserno) {

		SqlSession session = sqlSessionFactory.openSession();
		int result = 0;
		try {
			Post post = findByNo(session, postno);
			Buy_Reservation cur_Br = post.takeCurReservation();

			// 판매자 판매목록 저장
			Payment_User pu_bySeller = Payment_User.builder().price(cur_Br.getReser_price())
					.userno(post.getUser().getUserno()).business_partner(cur_Br.getUser())
					.productname(post.getProductname()).sellstate(2).build();

			// 구매자 구매목록 저장
			Payment_User pu_byBuyer = Payment_User.builder().price(cur_Br.getReser_price())
					.userno(cur_Br.getUser().getUserno()).business_partner(post.getUser())
					.productname(post.getProductname()).sellstate(1).build();

			Payment_UserDao.getInstance().insert(session, pu_bySeller);
			Payment_UserDao.getInstance().insert(session, pu_byBuyer);

			// 게시글 상태 변경
			result = updateBy(session, postno, "sellstate", 2);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return result;
	}
}
