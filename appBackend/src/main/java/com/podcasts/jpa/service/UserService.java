package com.podcasts.jpa.service;

import com.podcasts.jpa.mapper.RoleMapper;
import com.podcasts.jpa.mapper.UserMapper;
import com.podcasts.jpa.pojo.Role;
import com.podcasts.jpa.pojo.User;
import com.podcasts.jpa.util.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    UserMapper userMapper;
    @Autowired
    RoleMapper roleMapper;
//    @Autowired
//    UserRolesMapper userRolesMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 通过用户名查找用户信息
        User user = userMapper.findUserByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("用户不存在");
        }
        return user;
    }

    public User getUser(String name, Long id) {
        // 查找用户信息
        User user = null;
        Message message = null;
        if (id != null) {
            try {
                user = userMapper.getById(id);
//                user.setPassword("********");
            } catch (Exception e) {
                System.out.println(e);
            }
        } else if (name != null) {
            user = (User) loadUserByUsername(name);
//            user.setPassword("********");
        }
        return user;
    }

    public Message getUserDetail(String name, Long id) {
        // 查找用户信息
        User user = null;
        Message message = null;
        if (id != null) {
            try {
                user = userMapper.getById(id);
                user.setPassword("********");
                message = new Message(true, 200, "", user);
            } catch (Exception e) {
                System.out.println(e);
                message = new Message(false, 400, "请求参数不存在", "");
                return message;
            }
        } else if (name != null) {
            user = (User) loadUserByUsername(name);
            user.setPassword("********");
            message = new Message(true, 200, "", user);
        } else {
            message = new Message(false, 400, "请求参数不存在", "");
        }
        return message;
    }

    public Message create(User user, User nowUser) {
        Message message = null;
        // 用户id为空，表明为创建用户
        try {
            loadUserByUsername(user.getUsername());
            message = new Message(false, 400, "用户名已存在", "");
            return message;
        } catch (Exception e) {
            User user1 = user.createUser();
            user1.setId(-1L);
            user1.setUsername(user.getUsername());
            user1.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
            Role role = roleMapper.getById(2L);
            // 默认权限为用户
            List<Role> rs1 = new ArrayList<>();
            rs1.add(role);
            user1.setRoles(rs1);
            user1.setPower(2L);
            User user2 = userMapper.save(user1);
            message = new Message(true, 200, "1", user2);
        }
        return message;
    }

    public Message save(User user, User nowUser) {
        // 创建用户、更新用户
        Message message = null;
        if (user.getId() == null) {
            // 用户id为空，表明为创建用户
            try {
                loadUserByUsername(user.getUsername());
                message = new Message(false, 400, "用户名已存在", "");
                return message;
            } catch (Exception e) {
                User user1 = user.createUser();
                user1.setId(-1L);
                user1.setUsername(user.getUsername());
                user1.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
                Role role = roleMapper.getById(2L);
                // 默认权限为用户
                List<Role> rs1 = new ArrayList<>();
                rs1.add(role);
                user1.setRoles(rs1);
                user1.setPower(2L);
                User user2 = userMapper.save(user1);
                message = new Message(true, 200, "1", user2);
            }
        } else if (user.getPassword() == null && nowUser.getPower() == 1) {
            // id不为空，用户密码为空，表明修改权限
            try {
                Long id = user.getId();
                userMapper.getById(id);
            } catch (Exception e) {
                message = new Message(false, 400, "id不存在，请核对", "");
                return message;
            }
//            userRolesMapper.changeRoles(user.getId(), user.getPower());
//            userRolesMapper.changePower(user.getId(), user.getPower());
            message = new Message(true, 200, "修改成功", "");
        } else if (user.getPower() == null && nowUser.getId() == user.getId() || user.getPower() == null && nowUser.getPower() == 1) {
            // id不为空，用户权限为空，表明修改密码
            try {
                Long id = user.getId();
                userMapper.getById(id);
            } catch (Exception e) {
                message = new Message(false, 400, "id不存在，请核对", "");
                return message;
            }
            userMapper.changePassword(user.getId(), new BCryptPasswordEncoder().encode(user.getPassword()));
            message = new Message(true, 200, "修改成功", "");
        }
        return message;
    }

    public Message delete(Long id) {
        // 删除用户
        User user = null;
        Message message = null;
        try {
            userMapper.deleteById(id);
        } catch (Exception e) {
            message = new Message(false, 400, "请求参数不存在", "");
            return message;
        }
        message = new Message(true, 200, "删除成功", "".toString());
        return message;
    }
}
