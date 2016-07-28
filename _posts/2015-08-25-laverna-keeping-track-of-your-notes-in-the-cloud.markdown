---
layout: post
title: 'Laverna: Keeping track of your notes in the cloud'
tags: OpenSource Cloud Self-Hosted Notes Linux
categories: Linux NodeJS
excerpt: "Keeping with the theme of *build your own cloud* today we're gonna take a look at Laverna. A node.js alternative to OneNote, EverNote, and EtherPad."
time: 30
difficulty: "Intermediate"
---
The application stores all your notes in your browser local storage spaces such as indexedDB or localStorage, which is good for security reasons, because only you have access to them. Currently you can sync your notes to DropBox and Remote Storage. It's also highly secure because all of the data is stored in your browser (unless you decide to use Cloud Sync). This is also a downside if you want to have your notes on every device you own. If that's the case, you'll need use Cloud Sync

# [Demo](https://laverna.cc)

# Installation

To begin, we need a fresh Ubuntu 14.04 LTS Server. Mine will be using my AWS EC2 instance.

Now, lets add our Laverna user

{% highlight bash %}
useradd laverna -m -d /home/laverna -s /bin/bash
{% endhighlight %}

Next, we need to make sure that we have NodeJS, NPM, and GIT installed

{% highlight bash %}
apt-get install nodejs npm git
{% endhighlight %}

Because Ubuntu is sometimes strange, we need to SymLink our nodejs binary to node

{% highlight bash %}
ln -s /usr/bin/nodejs /usr/bin/nnode
{% endhighlight %}

After we have our basics completed, lets switch to the laverna user and goto our home directory

{% highlight bash %}
su laverna
cd ~
{% endhighlight %}
Lets clone the Laverna repo

{% highlight bash %}
git clone https://github.com/Laverna/laverna.git
{% endhighlight %}

Once cloned, enter the newly created directory

{% highlight bash %}
cd laverna
{% endhighlight %}

Checkout the current working production branch

{% highlight bash %}
git checkout 0.6.2
{% endhighlight %}
Use NPM to install bower, grunt, and grunt-cli

{% highlight bash %}
npm install bower
npm install grunt
npm install grunt-cli
{% endhighlight %}
Next, Alias bower and grunt for this session

{% highlight bash %}
alias bower="./node_modules/bower/bin/bower"
alias grunt="./node_modules/grunt-cli/bin/grunt"
{% endhighlight %}

Install Laverna's dependencies
{% highlight bash %}
npm install && bower install
{% endhighlight %}

Build Laverna

{% highlight bash %}
grunt build
{% endhighlight %}

Now that we have Laverna built into static files, we need to create a Virtual Host in our Web Server. Here's an example for NGINX

{% highlight bash %}
server  {
    listen  80;
    root /home/laverna/laverna/app;
    index index.html;
    server_name  notes.hudson.bz;
    error_log  /var/log/nginx/notes.hudson.bz-error.log warn;
    access_log  /var/log/nginx/notes.hudson.bz.com-access.log combined;
        location ~* \.(jpg|jpeg|gif|css|png|js|ico|html)$ {
          access_log off;
          expires max;
        }
        location ~ /\.ht {
          deny  all;
        }
}
{% endhighlight %}

Finally, navigate to your site.
Bonus Task

**Add an SSL Certificate for even more security!**

Example NGINX virtual host for SSL

{% highlight bash %}
server  {
    listen  80;
    root /home/laverna/laverna/app;
    index index.html;
    server_name  notes.hudson.bz;
    error_log  /var/log/nginx/notes.hudson.bz-error.log warn;
    access_log  /var/log/nginx/notes.hudson.bz.com-access.log combined;
        location ~* \.(jpg|jpeg|gif|css|png|js|ico|html)$ {
          access_log off;
          expires max;
        }
        location ~ /\.ht {
          deny  all;
        }
}
server {
    listen 443;
    root /home/laverna/laverna/app;
    index index.html;
    server_name  notes.hudson.bz;
    ssl                   on;
    ssl_certificate       /home/laverna/ssl/certbundle.pem;
    ssl_certificate_key   /home/laverna/ssl/privkey.key;
    ssl_prefer_server_ciphers on;
    ssl_protocols         TLSv1;
    ssl_ciphers           ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM;
    error_log  /var/log/nginx/notes.hudson.bz-error.log warn;
    access_log  /var/log/nginx/notes.hudson.bz.com-access.log combined;
}
{% endhighlight %}
# Enable Cloud Storage

## Warning

### You must use HTTPS for DropBox syncing

You can generate a self-signed certificate if you need to

Create a DropBox API Key [here](https://www.dropbox.com/developers/apps)

When you create a new app at Dropbox's Developer site you should keep in mind that:
{% highlight bash %}
1) Type of app should be Dropbox API app
2) Choose the type of access you need
  App folder – Access to a single folder created specifically for your app.
3)  Name
  Should be unique
{% endhighlight %}

![](/assets/images/Screen-Shot-2016-07-28-11-40-44.png)
Once created, we need to add a Redirect URI. Under OAuth2 Redirect URIs add the following
`https://mydomain.com/dropbox.html`

Click Add

![](/assets/images/Screenshot-2015-08-25-01-20-50.png){:class="image fit"}

Now, Go to Laverna settings [https://mydomain.com/index.html#/settings](https://mydomain.com/index.html#/settings) and find Cloud Storage. Click DropBox, and enter your API Key in the box below.

*I recommend while you're in settings, that you check the Use Encryption Box*

Then click Save!

![](/assets/images/Screenshot-2015-08-25-01-24-06.png){:class="image fit"}

You'll be prompted to Authorize the app. Once that's done, you'll return to your Laverna app and your notes will be synced! They are saved in ~/Dropbox/Apps/AppName

## You now have an amazing note keeping app, that can be accessed anywhere
