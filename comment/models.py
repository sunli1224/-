# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from activates.models import Activate
from User.models import Usertwo
class Comment_bases(models.Model):
    comment_text = models.TextField(blank=False)
    article_id = models.ForeignKey(Activate,on_delete=models.CASCADE)
    user_id = models.ForeignKey(Usertwo, on_delete=models.CASCADE)
    comment_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return "%s  %s %s %s"%(self.comment_text,self.user_id,self.comment_time,self.article_id)
    class Meta:
        ordering = ['-comment_time']
# Create your models here.
