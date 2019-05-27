#coding:utf-8
from email.mime.text import MIMEText
from email.header import Header
import smtplib
import random
def email_hh(email):
    temp = ""
    for i in range(6):
        ran = random.randrange(0, 4)
        if ran == 1:
            ran1 = random.randrange(0, 10)
            temp += str(ran1)
        else:
            ran2 = chr(random.randrange(65, 91))
            temp += ran2
    sender = "youdianxiaoshuai24@126.com"
    receiver = "%s" % email
    subject = "bblike博客"
    email_content = "%s" % temp
    username = "youdianxiaoshuai24@126.com"
    password = "sunli1224"

    msg = MIMEText(email_content, 'plain', 'utf-8')
    msg["Subject"] = Header(subject, 'utf-8')
    msg["From"] = sender
    smtp = smtplib.SMTP()
    smtp.connect("smtp.126.com")  # 发送邮件服务器的地址
    smtp.login(username, password)
    smtp.sendmail(sender, receiver, msg.as_string())
    smtp.quit()
    return temp
