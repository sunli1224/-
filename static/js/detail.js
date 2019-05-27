function comment_send(){
var xmlhttp;
if (window.XMLHttpRequest) {
    // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
    xmlhttp = new XMLHttpRequest();
                  }
     else {
                      // IE6, IE5 浏览器执行代码
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
     }
        var cm_text = document.getElementById("comment_text").value;
        if (cm_text !== "") {
            xmlhttp.open("POST", "/comment_kk/", true);
            xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var strss = "cm_text=" + cm_text;
            xmlhttp.send(strss);
        }
        else {
            document.getElementById("comment_js").style.color="red";
            document.getElementById("comment_js").innerHTML = "填写内容不能为空!"
        }

}