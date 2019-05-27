#coding:utf-8
from teach_blog.models import z_title,j_title
def remix():
    all_list = []
    father_mulu = z_title.objects.all()
    son_mulu = j_title.objects.all()
    for item in father_mulu:
        all_list.append(item)
        for kk in son_mulu:
            if item.id == kk.article:
                all_list.append(kk)
    return all_list