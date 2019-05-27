# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
class Activate(models.Model):
    title = models.CharField(max_length=256,blank=False)#文章标题
    author = models.CharField(max_length=256,blank=False)#文章作者
    category = models.CharField(max_length=50,blank=True)#文章标签
    datatime = models.DateTimeField(auto_now_add=True)#文章填入时间
    content = models.TextField(blank=False)#文章内容
    # picture = models.ImageField(upload_to='blog_mine',verbose_name='image',null=True)#插入图片
    num = models.IntegerField(default=0)
    code = models.TextField()#代码区间
    def __unicode__(self):
        return "%s" %(self.title)

    class Meta:
        ordering = ['-datatime']
# Create your models here.
