---
layout: post
title: 'Gogs: A self hosted GitHub alternative on a diet'
categories: Linux Git
tags: OpenSource Linux Cloud Self-Hosted
excerpt: "What's better than hosting your own private GUI for Git so we can keep all of our potentially world ending code from the NSA? Alright, I'll move the tin foil hat to the side for another day. However, when that front end is only consuming 88mb of RAM and the closest competition (cough, cough, GitLab) eats an entire gigabyte before it even finishes starting you know we may have a winner."
time: 10
difficulty: "Beginner"
---

In walks [Gogs](https://try.gogs.io/){:target="_blank"}, a seriously streamlined platform for all of your revision control needs.

![](https://puu.sh/jILoV/ea1ff9bb78.png){:class="image fit"}

Now, don't get me wrong, GitLab, GitHub Enterprise and the Monopoly know as Atlassian have there own each established market sectors. You are not going to get every single feature of a multi thousand dollar licensed product. There are a few, almost hilariously missing pieces that makes Gogs unusable by any of not all team based development operations. Those two things are Pull Requests and any type of Code Review. However, as a single developer wanting a place to store my code that I'd never, ever want to see the light of day on GitHub. It's a seriously great middle ground between Enterprise and Hobby.
It also came to a surprise because for such an advanced looking product, they seem to have shown up over night. With just over [70 Pages](https://github.com/gogits/gogs/commits/master?page=76) of commits on GitHub starting in March of 2014, they have managed to create an amazing product that runs rather well, and has the added benefit of being written in GO. There is good news regarding the two blatant issues that prevent Gogs from becoming anything usable in this market, and thats [Gitea](https://github.com/go-gitea/gitea). *Disclaimer I have not extensively tested Gitea but it is at its core a fork of Gogs*

All your basic GitHub-esk functionality exists, you can create repos, both public and private, there's an issue tracker for each repo and of course SSH based access for secure commits and pulls.

![](https://puu.sh/jILnh/c9ea270be7.png){:class="image fit"}

Keep your eyes pealed for my post about getting it installed, but in all honesty it's so simple to install that a dedicated post is over kill! Not to mention, if you use one of their [Docker](https://github.com/gogits/gogs/tree/master/docker) configs or [VagrantFiles](https://github.com/geerlingguy/ansible-vagrant-examples/tree/master/gogs) you'll be up and running in a matter of seconds.

{% highlight bash %}

# Pull image from Docker Hub.
$ docker pull gogs/gogs

# Create local directory for volume.
$ mkdir -p /var/gogs

# Use `docker run` for the first time.
$ docker run --name=gogs -p 10022:22 -p 10080:3000 -v /var/gogs:/data gogs/gogs

# Use `docker start` if you have stopped it.
$ docker start gogs

{% endhighlight %}

That's it, 4 lines and you have your own GitHub. A more in-depth installation guide will be showing up soon, but for now you can head over to Gogs themselves and go thought their [documentation](http://gogs.io/docs/installation/install_from_binary.html)
