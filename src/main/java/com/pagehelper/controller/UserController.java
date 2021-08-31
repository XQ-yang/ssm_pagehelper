package com.pagehelper.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pagehelper.entity.User;
import com.pagehelper.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * (User)表控制层
 *
 * @author 小强
 * @since 2021-08-30 19:21:06
 */
@Controller
@RequestMapping("user")
public class UserController {
    /**
     * 服务对象
     */
    @Resource
    private UserService userService;

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @ResponseBody
    @GetMapping("selectOne/{id}")
    public User selectOne(@PathVariable("id") Integer id) {
        return this.userService.queryById(id);
    }


    @RequestMapping("/hello")
    public String hello() {
        return "hello";
    }


    @RequestMapping("queryAll")
    public String queryAll(User user, @RequestParam(value = "page", defaultValue = "1") Integer page, Model model,HttpServletRequest request) {

        HttpSession session = request.getSession();
        //将搜索信息保存到session
        if (user.getName() != null || user.getPassword() != null){
            session.setAttribute("userinfo",user);
            System.err.println(session.getAttribute("userinfo"));
        }
        //获取指定页数据，大小为5
        PageHelper.startPage(page, 5);
        //紧跟的第一个select方法被分页
        List<User> users = userService.queryAll((User) session.getAttribute("userinfo"));
        //使用PageInfo包装数据,navigatePage为导航页显示的页数
        PageInfo pageInfo = new PageInfo(users, 5);
        model.addAttribute("pageInfo", pageInfo);


        return "allUser";
    }


    @RequestMapping("/insert")
    public String insert(User user) {
        userService.insert(user);
        System.err.println("addUser==>" + user);
        List<User> users = userService.queryAll();
        //使用PageInfo包装数据
        PageInfo pageInfo = new PageInfo(users);
        int total = (int) pageInfo.getTotal();
        //设置跳转页数
        if ((total % 5) != 0) {
            return "redirect:queryAll?page=" + ((total / 5) + 1);
        }
        return "redirect:queryAll?page=" + (total / 5);

    }


    @ResponseBody
    @RequestMapping("/toUpdate")
    public User toUpdate(@RequestParam("id") int id) {
        User user = userService.queryById(id);
        System.err.println("updateUserBefore==>" + user);
        return user;
    }

    @RequestMapping("/update")
    public String update(User user) {
        userService.update(user);
        System.err.println("updateUser==>" + user);
        return "redirect:queryAll";
    }

    @RequestMapping("/deleteById")
    public String deleteById(@RequestParam("id") int id) {
        User user = userService.queryById(id);
        System.err.println("deleteUser==>" + user);
        userService.deleteById(id);
        List<User> users = userService.queryAll();
        //使用PageInfo包装数据
        PageInfo pageInfo = new PageInfo(users);
        int total = (int) pageInfo.getTotal();
        if ((total % 5) != 0) {
            return "redirect:queryAll?page=" + ((total / 5) + 1);
        }
        return "redirect:queryAll?page=" + (total / 5);
    }


    /*@RequestMapping("/queryByCondition")
    public String queryByCondition(User user,Model model,@RequestParam(value = "page", defaultValue = "1") Integer page){
        //获取指定页数据，大小为8
        PageHelper.startPage(page, 5);
        //紧跟的第一个select方法被分页
        List<User> users = userService.queryByCondition(user);
        //使用PageInfo包装数据
        PageInfo pageInfo = new PageInfo(users, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "allUser";
    }*/


}
