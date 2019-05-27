"""blog_sun URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from view import  home,raises,register,login,email_kk,layout,read,detail,search,tag,comment_kk,Python,answer,kk,up,intro,answer_two,modpass,email_ff,jump,error
from django.contrib import admin
from django.conf.urls.static import static
from django.conf import settings
app_name = 'blog_sun'
urlpatterns = [
    url('^up/(?P<up>.+)/$',up, name="up"),
    url('^down/(?P<kk>.+)/$',kk, name="kk"),
    url('^Python/(?P<Python>.+)/$',Python, name="Python"),
    url('^answer/$',answer),
    url('^answer_two/$',answer_two),
    url('^email_kk/$',email_kk),
    url('^email_ff/$',email_ff),
    url('^layout/$',layout),
    url('^register/$',register),
    url('^login/$',login),
    url('^home/$',home),
    url('^jump/$',jump),
    url('^error/$',error),
    url('^intro/$',intro),
    url('^raises/$',raises),
    url(r'^admin/', admin.site.urls),
    url(r'^search/$',search , name = 'search'),
    url(r'^read/(?P<id>\d+)/$',detail,name='detail'),
    url(r'^tag(?P<tag>\w+)/$',tag ,name='tag'),
    url('^comment_kk/$', comment_kk),
    url('^read/$',read),
    url('^modpass/$',modpass),
]
