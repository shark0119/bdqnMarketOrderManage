package com.shark.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shark.dao.BaseDao;
import com.shark.dao.RoleDao;
import com.shark.entity.Role;

public class RoleDaoImpl extends BaseDao implements RoleDao {

	@Override
	public List<Role> getRoleList() {
		String sql = "select * from mk_role";
		List<Role> roleList = null;
		if (!this.getConnection())
			return null;
		ResultSet rset = this.executeQuery(sql);
		try {
			Role role = null;
			roleList = new ArrayList<>();
			while (rset.next()){
				role = new Role();
				role.setRid(rset.getInt("roleId"));
				role.setRname(rset.getString("roleName"));
				roleList.add(role);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return roleList;
	}

	@Override
	public String getRoleName(int id) {
		if (!this.getConnection())
			return null;
		String sql = " select rolename from mk_role where roleid= "+ id +" ";
		ResultSet rset = this.executeQuery(sql);
		try {
			if (rset.next()){
				return rset.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();	
		} finally {
			this.closeAll();
		}	
		return null;
	}

}
