#coding:utf-8
from activates.models import Activate
from User import models
from comment import models
from django.http import Http404,HttpResponse
from django.shortcuts import render,redirect
import re
import json
from email_code.Email_code import email_hh
from markdown import markdown
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from teach_blog.models import z_title,j_title
from django.utils.http import urlunquote
from comment_s.models import comment_ss,comment_ss_s
from teach_blog.remix_check.remix import remix
from redis_code import redis_hh
def intro(request):#编程页面逻辑
    try:
        return render(request, "intoduce.html",locals())
    except:
        return render(request, 'error.html', locals())
def up(request, up):#上一页逻辑
    father_mulu = z_title.objects.all()[0:23]
    son_mulu = j_title.objects.all()[0:26]
    search_title = urlunquote(up)
    all_list = remix()
    for item in range(0, len(all_list)):
        if all_list[item].title == search_title:
            teach_url = all_list[item - 1]
    return render(request, "up.html", locals())
def kk(request, kk):#下一页的逻辑
    father_mulu = z_title.objects.all()[0:23]
    son_mulu = j_title.objects.all()[0:26]
    search_title = urlunquote(kk)
    all_list = remix()
    for item in range(0, len(all_list)):
        try:
            if all_list[item].title == search_title:
                teach_url = all_list[item+1]
        except:
            teach_url = all_list[0]

    return render(request, "python.html", locals())

def answer_two(request):#留言板的二级评论
    if request.method == "GET":
        all_comment_k = comment_ss_s.objects.all()
        all_comment = comment_ss.objects.all()
        return render(request, 'answer.html', locals())
    try:
        username = request.session["username"]
        ssdata = request.POST
        comment_content_s = ssdata.get("cm_text")
        user_ss = ssdata.get("user_normal")
        # user_id_k =  models.Usertwo.objects.get(name=user_ss)
        # user_ll = user_id_k.id
        username_ss_s = comment_ss.objects.get(question_content= user_ss)
        username_s = models.Usertwo.objects.get(name=username)
        newcomment = comment_ss_s.objects.create(reply_content=unicode(comment_content_s), user_normal=username_s, reply_user=username_ss_s)
        newcomment.save()
        redirect('/answer/')
        return HttpResponse(json.dumps({"flag": "sucess"}))
    except:
        return HttpResponse(json.dumps({"flag": "false"}))
def answer(request):#留言板块一级评论
    if request.method == "GET":
        all_comment_k = comment_ss_s.objects.all()
        all_comment = comment_ss.objects.all()
        return render(request, 'answer.html', locals())
    try:
        username = request.session["username"]
        ssdata = request.POST
        comment_content_s = ssdata.get("cm_text")
        username_s = models.Usertwo.objects.get(name=username)
        newcomment = comment_ss.objects.create(question_content=unicode(comment_content_s), user_normal=username_s)
        newcomment.save()
        redirect('/answer/')
        return HttpResponse(json.dumps({"flag": "sucess"}))
    except:
        return HttpResponse(json.dumps({"flag": "false"}))
def Python(request, Python):#教程处理函数
    father_mulu = z_title.objects.all()[0:23]
    son_mulu = j_title.objects.all()[0:26]
    try:
        kk = urlunquote(Python)
        teach_url = z_title.objects.get(title=kk)
        teach_url.text = markdown(teach_url.text)
        teach_url.readcount +=1
        teach_url.save()
    except:
        kk = urlunquote(Python)
        teach_url = j_title.objects.get(title=kk)
        teach_url.text = markdown(teach_url.text)
        teach_url.readcount +=1
        teach_url.save()
    return render(request, "python.html", locals())
def read(request):#博文处理函数
    try:
        read_list = Activate.objects.all()
        for item in read_list:
            item.content = markdown(item.content)
        paginator = Paginator(read_list,3)
        page = request.GET.get('page')
        try:
            read_list = paginator.page(page)
        except PageNotAnInteger:
            read_list = paginator.page(1)
        except EmptyPage:
            read_list = paginator.num_pages
    except Activate.DoesNotExist:
        raise Http404
    return render(request, 'read.html', {'read_list': read_list , "error": False,"request":request})
def search(request):#博文查找函数
    if 'ss' in request.GET:
        ss = request.GET['ss']
        if not ss:
            return render(request,'home.html')
        else:
            read_list = Activate.objects.filter(title__icontains=ss)
            if len(read_list) == 0:
                return render(request,'read.html',{'read_list':read_list,'error' : True})
            else:
                return render(request, 'read.html', {'read_list': read_list , 'error': False})
    return redirect('/')
def tag(request,tag):#标签处理函数
    try:
        post_tag = Activate.objects.filter(category__iexact=tag)
    except Activate.DoesNotExist:
        raise Http404
    return render(request, 'tag.html',locals())
def comment_kk(request):#评论处理函数
    if request.method == "GET":
        return render(request, 'detail.html', locals())
    try:
        username = request.session["username"]
        ppdata = request.POST
        comment_text_k = ppdata.get("cm_text")
        id = ppdata.get("id")
        user_id_k = models.Usertwo.objects.get(name=username)
        article_id_k = Activate.objects.get(id=str(id))
        newcomment = models.Comment_bases.objects.create(comment_text=unicode(comment_text_k),article_id=article_id_k,user_id=user_id_k)
        newcomment.save()
        redirect('/detail/')
        return HttpResponse(json.dumps({"flag": "sucess"}))
    except:
        return HttpResponse(json.dumps({"flag": "false"}))
def detail(request, id):#单个博文处理函数
    try:
        post = Activate.objects.get(id=str(id))
        post.num += 1
        post.save()
        post.content = markdown(post.content)
        comment_hh = models.Comment_bases.objects.filter(article_id=post)
    except Activate.DoesNotExist:
        raise Http404
    return render(request, 'detail.html', {"id": json.dumps(str(id)),"post":post, "comment_hh": comment_hh,"request": request})
def home(request):#主页面
    return render(request, "home.html",locals())
def raises(request):#赞助界面
    return render(request, 'raise.html', locals())

def modpass(request):#修改密码的界面
    if request.method == "GET":
        return render(request, "modpass.html", locals())
    if request.method == "POST":
        username = request.POST.get("user")
        password = request.POST.get("pass")
        email = request.POST.get("email")
        if username == "":
            message = "未填写用户名"
        if password == "":
            message = "未填写密码"
        if email == "":
            message = "未填写邮箱"
        user = models.Usertwo.objects.filter(name=username)
        if not user:
            message = "用户名不存在"
        else:
            new_pattern = '^[a-zA-Z]\w{5,}$'
            real_match = re.match(new_pattern, password)
            if real_match == None:
                message = "新密码必须开头必须是以字母开头,且五位以上!"
            else:
                email_k = models.Usertwo.objects.filter(name=username,email=email)
                if not email_k:
                    message = "请输入注册邮箱！"
                else:
                    email_s = request.POST.get("email_p")
                    email_code = redis_hh.redis_link()
                    if email_code != email_s:
                        message = "验证码不正确"
                    else:
                        pass_word = models.Usertwo.objects.get(name=username)
                        pass_word.password = str(password)
                        pass_word.save()
                        return  redirect('/jump/')
    return render(request,'modpass.html',locals())


def login(request):#登陆界面
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")
        if username == "":
            message = "未填写用户名"
        if password == "":
            message = "未填写密码"
        try:
            user = models.Usertwo.objects.get(name=username)
            if user.password == password:
                request.session.set_expiry(0)
                request.session['is_login'] = True
                request.session['username'] = user.name
                request.session['passworld'] = user.password
                return redirect('/home/')
            else:
                message = "密码不正确"
        except:
            message = "用户不存在"
    username = " "
    password = " "
    return render(request,'login.html',locals())
def email_ff(request):#邮箱修改密码界面
    if request.method == "GET":
        return render(request, 'modpass.html', locals())
    postdata = request.POST.get("email")
    code  = email_hh(postdata)
    redis_hh.redis_cun(code)
    return HttpResponse(json.dumps({"flag": "sucess"}))
def email_kk(request):#邮箱注册界面
    if request.method == "GET":
        return render(request, 'register.html', locals())
    postdata = request.POST
    email = postdata.get("email")
    code = email_hh(email)
    redis_hh.redis_cun(code)
    return HttpResponse(json.dumps({"flag" : "sucess"}))

def register(request):#注册界面
    if request.session.get('is_login',None):
        return redirect('/home/')
    if request.method == 'POST':

        username = request.POST.get("username")
        password = request.POST.get("password")
        confirm_password = request.POST.get("confirm_password")
        email = request.POST.get("email")
        sex = request.POST.get('sex')
        if username == "":
            message = "用户名是必填字段!"
            return render(request, 'register.html', locals())
        else:
            same_name_user = models.Usertwo.objects.filter(name=username)
            if same_name_user:
                message = "用户名已经存在!"
            else:
                if password == "":
                    message = "密码是必填字段!"
                else:
                    pattern_2 = '^[a-zA-Z]\w{5,}$'
                    real_2 = re.match(pattern_2,password)
                    if real_2 == None:
                        message = "密码必须开头必须是以字母开头,且五位以上!"
                        return render(request,'register.html',locals())
                    else:
                        if confirm_password == "":
                            message = "密码是必填字段"
                        else:
                            real_3 = re.match(pattern_2,confirm_password)
                            if real_3 == None:
                                message = "密码必须开头必须是以字母开头!"
                                return render(request,'register.html',locals())
                            else:
                                if password != confirm_password:
                                    message = "密码不相同!"
                                else:
                                    if email == " ":
                                        message = "邮箱是必填字段"
                                        return render(request, 'register.html',locals())
                                    else:
                                        pattern_3 = "^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$"
                                        real_4 = re.match(pattern_3,email)
                                        if real_4 == None:
                                            message = "不符合邮箱规则!"
                                            return render(request, 'register.html', locals())
                                        else:
                                            same_name_email = models.Usertwo.objects.filter(email=email)
                                            if same_name_email:
                                                message="该邮箱已经注册过了!"
                                            else:
                                                 code = request.POST.get("Verification_code")
                                                 email_code = redis_hh.redis_link()
                                                 if email_code != code:
                                                     message = "验证码不正确"
                                                 else:
                                                      new_user = models.Usertwo.objects.create()
                                                      new_user.name = username
                                                      new_user.password = password
                                                      new_user.email = email
                                                      new_user.sex = sex
                                                      new_user.save()
                                                      return redirect('/login/')
    return render(request, 'register.html', locals())

def layout(request):#注销界面
    if not request.session.get('is_login',None):
        return redirect('/home/')
    request.session.flush()
    return redirect('/home/')
def jump(request):
    redirect('/login/')
    return  render(request, "JumpOther.html", locals())
def error(request):
    return render(request,"error.html", locals())

