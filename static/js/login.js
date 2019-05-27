$(function () {
    $("#signupForm").validate({
    rules:{
        username: "required",
        password: "required",
    },
        message:{
        username: "请填写用户名",
        password: "请填写密码",
        },
    });
});