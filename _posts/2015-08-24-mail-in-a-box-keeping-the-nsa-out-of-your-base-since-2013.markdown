---
layout: post
title: 'Mail In a Box: Keeping the NSA out of your base since 2013'
tags: OpenSource Cloud Self-Hosted Email Linux
categories: Linux EMail
excerpt: "Since before it was widely known that the internet wasn't as secure as we hoped, I've been one to run applications in my own environment instead of taking advantage of the commercialized products easily available. Sometimes it's simply for the sheer amount of control, and others it's because I don't want my Drunk Spending on Amazon to be tied to my email accounts. It's not always the best thing that Google and Amazon can now predict the exact days and times I'll be most inebriated and offer me 'Great deals'"
time: 45
difficulty: "Intermediate"
---

Since before it was widely known that the internet wasn't as secure as we hoped, I've been one to run applications in my own environment instead of taking advantage of the commercialized products easily available. Sometimes it's simply for the sheer amount of control, and others it's because I don't want my Drunk Spending on Amazon to be tied to my email accounts. It's not always the best thing that Google and Amazon can now predict the exact days and times I'll be most inebriated and offer me "Great deals"

That's where we're gonna start today! Lets take back our privacy one service at a time, and today's service is E-Mail. There are quite a few turn-key applications in a box that will create  fully functioning mail server that includes both sending and receiving connectors and a full fledged webmail client. The one I've come to know, and use is [Mail-in-a-Box](https://mailinabox.email/). That's not the only option out there, another quite popular turn-key systems is [iRedMail](http://www.iredmail.org/index.html). 

The cons of running your own mail server can be quite daunting especially if managing a machine that could be so vital to our personal and professional lives. Don't take that as a reason not to do it, but things you'll want to be aware of before undertaking something like this.

>* Having an email account get compromised is a real issue that I personally see daily in this industry. If that ends up happening to you, you're IP address will be placed on a Spam Black list and you won't be able to send out email until it's cleaned up
* The nature of the server market today is full our Cloud Providers. These companies have built their entire business on a use and throw away method. The server you spun up today, may have been someones spam bed yesterday
* If your email goes down at 1am the morning before a project is due, are you willing to fix it?

Those are the big points. MIAB has their own check list

###Pre-flight Checklist

> - Can I run my Mail-in-a-Box at home?
 - No. Computers on most residential networks are blocked from sending mail both on the sending end (e.g. your ISP blocking port 25) and on the receiving end (by blacklists) because residential computers are all too often hijacked to send spam. Your home IP address is also probably dynamic and lacks configurable “reverse DNS.” If any of these apply to you, you’ll need to use a virtual machine in the cloud.
- What will it cost?
 - This is going to cost you about $16 per month. Most of the cost is in having a (virtual) machine connected to the Internet 24/7. You can divide this among friends and share your Mail-in-a-Box if you’d like to split it up.
- Do I have time?
 - There’s also your time. Once a Mail-in-a-Box is set up, we hope it “just works” but when you are your own system administrator you must be prepared to resolve issues as they arise.
- How will this affect my website? (Advanced.)
 - If your website is just HTML pages and static files, you can copy it onto your Mail-in-a-Box for a really simple hosting solution. If you have a website already, be aware that your Mail-in-a-Box wants to take over your DNS so that it can configure it correctly for email, and we recommend you let the box do that, but you can configure the DNS to keep your website on another machine. You may also need to configure relaying for outbound transactional email.
- Can I modify my box after / use my box for something else too? (Advanced.)
 - No. Mail-in-a-Box must be installed on a fresh machine that will be dedicated to Mail-in-a-Box, and you cannot modify the box after installation (configuration changes will get overwritten by the box’s self-management). If you are looking for something more advanced, try iRedMail, Sovereign, or Modoboa.

If you are still with me, and ready to do this then lets dig in!

First, we need to find a server. That in and of itself is a not something to take lightly when dealing with a mail server that needs to have a clean IP address range. No company is giving  me money to tell you that they are awesome. So, this part I'll leave up to you. Start Googling "Quality providers for an email server"

An important thing to note, you need a **fresh** server. It needs to be 100% empty beyond the base Ubuntu 14.04 OS.

##Installation

I'm not even going to try and re-create the beautiful [documentation](https://mailinabox.email/guide.html) they've created. So I'll point you over there, and capture a few key points as the install goes.  

Installation starts with 1 line
{% highlight bash %}

curl -s https://mailinabox.email/bootstrap.sh | sudo bash

{% endhighlight %}

That's it, now we go through each prompt.

You'll be asked a series of questions that are rather self explanitory. What would your like your new email to me? What would you like to call the server? What country should you use for the SSL Certificate?

It'll spit out a few diagnostic information pieces

{% highlight bash %}

Primary Hostname: box.drunksysadmin.com
Public IP Address: xx.xx.xx.xx
Private IP Address: 172.xx.xx.xx
Mail-in-a-Box Version:  v0.13a

{% endhighlight %}

Then it will do more installation steps (again, I highly recommend following Mail-in-a-box's documentation for pictures!)

Once it's all done, you'll get something that looks like this

{% highlight bash %}


Your Mail-in-a-Box is running.

Please log in to the control panel for further instructions at:

    https://xx.xx.xx.xx/admin

You will be alerted that the website has an invalid certificate. Check that
the certificate fingerprint matches:

C0:9B:FF:04:2B:2D:8F:47:5A:8B:D5:88:B7:05:D3:4B:6C:22:80:5F

{% endhighlight %}
Boom! Login and start configuring. 

###Final Words

Is this something I'd recommend doing for someone who has minimal Linux Experience? Yes and No. Setting Mail-in-a-box up is not for the faint of heart, but my recommendation would be to head over to [Namecheap](http://www.namecheap.com) and setup a domain. Use that domain to install your mail server. Once you are comfortable enough with the setup, you can then move your primary domain over.

It's a great learning experience for anyone who really wants to dive into Linux, or someone who just wants to keep the NSA's hands out of your email!