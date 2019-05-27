# -*- coding: utf-8 -*-
from __future__ import unicode_literals


from django.db import models
class Usertwo(models.Model):
    gender = (
        ('male','man'),
        ('female','woman'),
    )

    name = models.CharField(max_length=128,unique=True)
    password = models.CharField(max_length=256)
    email = models.EmailField(unique=True)
    sex = models.CharField(max_length=32, choices=gender,default='man')
    c_time = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return '%s'%(self.name)
    class Meta:
        # abstract = True
        ordering = ['c_time']
        verbose_name = 'username'
        verbose_name_plural = 'username'
# Create your models here.
