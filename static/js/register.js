jQuery.validator.addMethod("check_password", function (value, element, params) {
    var pattern = new RegExp(params);
            return pattern.test(value);
}, "密码必须开头必须是以字母开头,且五位以上!");
$().ready(function () {
        $("#signupForm").validate({
            rules:{
                username:{
                    required:true,
                    minLength:2
                },
                password:{
                    required:true,
                    check_password: "^[a-zA-Z]\\w{5,}$"
                },
              confirm_password:{
                    required:true,
                  check_password: "^[a-zA-Z]\\w{5,}$",
                  equalTo:"#password"
              },
              email:{
                    required:true,
                    email:true
              }
            },
            message:{
                username:{
                    required:"用户名是必填选项",
                    minLength:"用户名两位以上"
                },
                password:{
                    required:"密码是必填选项",
                    check_password:"密码必须开头必须是以字母开头,且五位以上!"
                },
                confirm_password:{
                  required:"密码是必填选项",
                  check_password:"密码必须开头必须是以字母开头,且五位以上!"
                },
                email:{
                    required:"邮箱是必填选项",
                    email:"不符合邮箱规则!"
                }
            }

        })
    });



function email_send() {
var xmlhttp;
if (window.XMLHttpRequest) {
    // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
    xmlhttp = new XMLHttpRequest();
                  }
     else {
                      // IE6, IE5 浏览器执行代码
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
     }
        var emails = document.getElementById("email").value;
        if (emails !== "") {
            xmlhttp.open("POST", "/email_kk/", true);
            xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

            var strss = "email=" + emails;
            xmlhttp.send(strss);

            settime(document.getElementById("time_check"))
        }
        else {
            document.getElementById("tip_js").style.color="red";
            document.getElementById("tip_js").innerHTML = "请填写邮箱!"
        }

}
var countdown=60;
function settime(val) {

        if (countdown === 0) {
            val.removeAttribute("disabled");
            val.value = "免费获取验证码";
            countdown = 60;
            return;
        } else {
            val.setAttribute("disabled", true);
            val.value = "重新发送(" + countdown + ")";
            countdown--;
        }
        setTimeout(function () {
            settime(val)
        }, 1000)
}
