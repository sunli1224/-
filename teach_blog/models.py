# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
class z_title(models.Model):
    title = models.CharField(unique=True, max_length=70, verbose_name=u'章标题')
    text = models.TextField(verbose_name=u'内容')
    ordernum = models.PositiveIntegerField(verbose_name=u'章序号')
    readcount = models.PositiveIntegerField(default=0, verbose_name=u'阅读数')
    def __unicode__(self):
        return "【%s】--【%s】"%(self.title, self.ordernum)
    class Meta:
        ordering = ['ordernum']
        verbose_name = "章"
        verbose_name_plural = "章"
class j_title(models.Model):
    title = models.CharField(max_length=70, verbose_name=u'节标题')
    text = models.TextField(verbose_name=u'内容')
    ordernum = models.PositiveIntegerField(verbose_name=u'节序号')
    readcount = models.PositiveIntegerField(default=0, verbose_name=u'阅读数')
    article = models.ForeignKey(z_title, verbose_name=u'分类--章名称--章序号')
    def __unicode__(self):
        return "%s %s" %(self.title ,self.ordernum)
    class Meta:
        ordering = ["ordernum"]#默认按序号排序
        verbose_name = "节"
        verbose_name_plural = "节"

# Create your models here.
