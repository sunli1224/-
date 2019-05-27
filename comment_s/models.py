# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from User.models import Usertwo
from django.db import models
class comment_ss(models.Model):
    question_content = models.TextField(blank=False,verbose_name="评论内容")
    datatime = models.DateTimeField(auto_now_add=True, verbose_name="评论时间")
    user_normal = models.ForeignKey(Usertwo,on_delete=models.CASCADE,verbose_name="评论者")
    def __unicode__(self):
        return "【%s】--【%s】" %(self.user_normal, self.question_content)

    class Meta:
        ordering = ['-datatime']
        verbose_name = "一级评论"
        verbose_name_plural = "一级评论"

class comment_ss_s(models.Model):
    reply_content = models.TextField(blank=False,verbose_name="评论内容")
    datatime = models.DateTimeField(auto_now_add=True)
    user_normal = models.ForeignKey(Usertwo, on_delete=models.CASCADE,verbose_name="评论用户")
    reply_user = models.ForeignKey(comment_ss,on_delete=models.CASCADE,verbose_name="评论的用户")
    def __unicode__(self):
        return  "【%s】--【%s】--【%s】"%(self.reply_user, self.reply_content, self.user_normal)

    class Meta:
        ordering = ['-datatime']
        verbose_name = "二级评论"
        verbose_name_plural = "二级评论"



# Create your models here.
