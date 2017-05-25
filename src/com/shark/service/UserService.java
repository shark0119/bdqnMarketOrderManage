package com.shark.service;

import java.util.List;

import com.shark.dao.UserDao;
import com.shark.dao.impl.UserDaoImpl;
import com.shark.entity.User;
import com.shark.sql.GenerateSql;
import com.shark.sql.UserSql;
import com.shark.util.CommonUtil;

public class UserService {
	private GenerateSql gs = null;
	private UserDao ud = new UserDaoImpl();
	
	/**
	 * �����û�
	 * @param user �����û���Ч��Ϣ��ʵ���������ID�ʹ������������ݿ��Զ�����
	 * @return �ɹ����ز����user���� ʧ�ܷ���null
	 */
	public User addUser (User user){
		String sql = "{call addUser (?, ?, ?, ?, ?, ?)}";
		gs = new UserSql(sql, user.getUsername(), user.getPwd(), 
						user.getStatus(), user.getRole());
		User u1 = ud.addUser(gs);
		user.setId(u1.getId());
		user.setCreateTime(u1.getCreateTime());
		return user;
	}
	/**
	 * ��ȡȫ���û�����
	 * @return �ɽ����ת��������ʵ�弯��,���ݿ�ʧ�ܷ���null, ��ѯ�ɹ����ؼ��ϣ�����Ԫ�ظ���Ϊ0��ʾ�޶�Ӧ��¼
	*/
	public List<User> getUserList (){
		String sql = " select * from tb_user ";
		return ud.getUserList(new UserSql (sql));
	}
	/**
	 * ��ҳ��ѯʱʹ�õ��û����ϻ�ȡ
	 * @param pageIndex ��ǰҳ��
	 * @param pageSize ÿһҳ��ʾ�ĸ���
	 * @return �ɽ����ת��������ʵ�弯��,���ݿ�ʧ�ܷ���null, ��ѯ�ɹ����ؼ��ϣ�����Ԫ�ظ���Ϊ0��ʾ�޶�Ӧ��¼
	 */
	public List<User> getUserList (int pageIndex, int pageSize){
		String sql = "select * from "+
				" (select rownum rn, t1.* from (select * from tb_user) t1) " +
				" where rn > ? and rn <= ? ";
		return ud.getUserList(new UserSql(sql, (pageIndex-1)*pageSize, pageIndex*pageSize));
	}
	/**
	 * ��ȡ�ܵ��û�����
	 * @return �û�������
	 */
	public int getUserCount (){
		String sql = "select count(id) from tb_user";
		return CommonUtil.getCount(new UserSql(sql));
	}
	/**
	 * �����ṩ���û�ID��ɾ���û�
	 * @return �ɹ�Ϊtrue ʧ��ΪFALSE
	 */
	public boolean deleteUser (int id){
		String sql = "delete from tb_user where id = ?";
		gs = new UserSql(sql, id);
		return -1 != ud.updateUser(gs);
	}
	/**
	 * �����û�ID��ȡ�û�
	 * @param id
	 * @return ���ز�ѯ�����û���ʧ�ܷ���null
	 */
	public User getUser (int id){
		String sql = "select * from tb_user where id = ?";
		gs = new UserSql(sql, id);
		return ud.getUser(gs);
	}
}