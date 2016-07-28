---
layout: post
title: 'Automated Amazon EBS Snapshots - Ubuntu 14.04 LTS'
categories: Linux Python
tags: AWS EBS Ubuntu Cloud Linux Python
excerpt: "Wouldn't it be cool if we could schedule EBS Snapshots with features like backup purging based on how old they are, or possibly target specific instances that are tagged"
time: 20
difficulty: "Intermediate"
---
Wouldn't it be cool if we could schedule EBS Snapshots with features like backup purging based on how old they are, or possibly target specific instances that are tagged?

I ran across a great repository that's aptly named "[aws-missing-tools](https://github.com/colinbjohnson/aws-missing-tools)" that's been created by [Colin Johnson](https://github.com/colinbjohnson).

It contains an insane amount of awesome stuff, but this post will detail one specific tool named [ec2-automate-backup](https://github.com/colinbjohnson/aws-missing-tools/tree/master/ec2-automate-backup). We're specifically going to use the the ec2-automate-backup-awscli.sh script and not the ec2-automate-backup.sh. The script we're using utilizes the awscli python package where as the other script utilizes EC2 API Tools. ec2-automate-backup was created to provide easy backup/snapshot functionality for multiple EC2 EBS volumes

*One thing to note, the server you run that script from does not have to be within the Amazon umbrella. It'll work anywhere.*

<div align="center" markdown="1">
# Installation
</div>


#### We need two packages before getting started, Python 2.x or 3.x and Setup Tools

{% highlight shell %}

sudo apt-get update
apt-get install python python-setuptools

{% endhighlight %}


#### Use easy_install to install pip

{% highlight bash %}

easy_install pip

{% endhighlight %}

### Finally use pip to install awscli

{% highlight bash %}
pip install awscli
{% endhighlight %}


<div align="center" markdown="1">
# Configuration
</div>

### Run the awscli configuration tool and fill in, your Access Key ID, your Secret Access Key, Default Region (us-east-1, us-west-1, us-west-2, etc) and finally output format

{% highlight bash %}

aws configure
  AWS Access Key ID [None]: 1234564789987654321
  AWS Secret Access Key [None]: abcdefghijklmnop
  Default region name [None]: us-west-2
  Default output format [None]: json

{% endhighlight %}

### Create a new user named backup-agent, and create the home directory

{% highlight bash %}

useradd -m -d /home/backup-agent -s /bin/bash backup-agent

{% endhighlight %}

### Download the [ec2-automate-backup-awscli.sh](https://github.com/colinbjohnson/aws-missing-tools/blob/master/ec2-automate-backup/ec2-automate-backup-awscli.sh) script  

{% highlight bash %}

curl -O https://raw.githubusercontent.com/colinbjohnson/aws-missing-tools/master/ec2-automate-backup/ec2-automate-backup-awscli.sh

{% endhighlight %}


<div align="center" markdown="1">
# Directions For Use
</div>

### Example of Use

`ec2-automate-backup-awscli.sh -v vol-6d6a0527`

the above example would provide a single backup of the EBS volumeid vol-6d6a0527. The snapshot would be created with the description "vol-6d6a0527_2012-09-07".

#### Required Parameters

ec2-automate-backup-awscli.sh requires one of the following two parameters be provided:

`-v <volumeid>` - the "volumeid" parameter is required to select EBS volumes for snapshot if ec2-automate-backup-awscli.sh is run using the "volumeid" selection method - the "volumeid" selection method is the default selection method.
    
`-t <tag>` - the "tag" parameter is required if the "method" of selecting EBS volumes for snapshot is by tag (-s tag). The format for tag is key=value (example: Backup=true) and the correct method for running ec2-automate-backup-awscli.sh in this manner is ec2-automate-backup-awscli.sh -s tag -t Backup=true.
#### Optional Parameters
`-r <region>` - the region that contains the EBS volumes for which you wish to have a snapshot created.

`-s <selection_method>` - the selection method by which EBS volumes will be selected. Currently supported selection methods are "volumeid" and "tag." The selection method "volumeid" identifies EBS volumes for which a snapshot should be taken by volume id whereas the selection method "tag" identifies EBS volumes for which a snapshot should be taken by a key=value format tag.

`-c <cron_primer_file>` - running with the -c option and a providing a file will cause ec2-automate-backup-awscli.sh-awscli.sh to source a file for environmental configuration - ideal for running ec2-automate-backup-awscli.sh-awscli.sh under cron. An example cron primer file is located in the "Resources" directory and is called cron-primer.sh.

`-n` - tag snapshots "Name" tag as well as description

`-h` - tag snapshots "InitiatingHost" tag to specify which host ran the script

`-k <purge_after_days>` - the period after which a snapshot can be purged. For example, running "ec2-automate-backup-awscli.sh-awscli.sh -v "vol-6d6a0527 vol-636a0112" -k 31" would allow snapshots to be removed after 31 days. purge_after_days creates two tags for each volume that was backed up - a PurgeAllow tag which is set to PurgeAllow=true and a PurgeAfter tag which is set to the present day (in UTC) + the value provided by -k.

`-p` - the -p flag will purge (meaning delete) all snapshots that were created more than "purge after days" ago. ec2-automate-backup-awscli.sh looks at two tags to determine which snapshots should be deleted - the PurgeAllow and PurgeAfter tags. The tags must be set as follows: PurgeAllow=true and PurgeAfter=YYYY-MM-DD where YYYY-MM-DD must be before the present date.
<div align="center" markdown="1">
# Potential Uses and Methods of Use
</div>

To backup multiple EBS volumes use ec2-automate-backup-awscli.sh as follows: 

`ec2-automate-backup-awscli.sh -v "vol-6d6a0527 vol-636a0112"`

To backup a selected group of EBS volumes on a daily schedule tag each volume you wish to backup with the tag "Backup=true" and run ec2-automate-backup-awscli.sh using cron as follows:

`0 0 * * * ec2-automate-backup-awscli.sh -s tag -t "Backup=true"`

To backup a selected group of EBS volumes on a daily and/or monthly schedule tag each volume you wish to backup with the tag "Backup-Daily=true" and/or "Backup-Monthly=true" and run ec2-automate-backup-awscli.sh using cron as follows:

`0 0 * * * backup-agent /home/backup-agent/ec2-automate-backup-awscli.sh -s tag -t "Backup-Daily=true"`

`0 0 1 * * backup-agent /home/backup-agent/ec2-automate-backup-awscli.sh -s tag -t "Backup-Monthly=true"`

To perform daily backup using cron and to load environment configuration with a "cron-primer" file:

`0 0 * * * backup-agent /home/backup-agent/ec2-automate-backup-awscli.sh -c /home/backup-agent/cron-primer.sh -s tag -t "Backup=True"`

`-u` - the -u flag will tag snapshots with additional data so that snapshots can be more easily located. Currently the two user tags created are Volume="ebs_volume" and Created="date." These can be easily modified in code.