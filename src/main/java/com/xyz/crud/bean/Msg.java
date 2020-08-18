package com.xyz.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回类，用来返回json数据
 */
public class Msg {
    // 状态码，100-成功，200-失败
    private Integer code;
    // 提示信息
    private String msg;
    // 用户要返回给浏览器的信息，都封装到map集合中
    private Map<String,Object> extend = new HashMap<>();

    // 成功和失败的方法
    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("成功了");
        return msg;
    }
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("失败了");
        return msg;
    }
    // 将数据封装到本返回对象
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
