---
layout: default
title: Vizir | Growl notifications for Grid'5000 jobs
---

<a href="http://github.com/priteau/vizir">
	<img style="position: absolute; top: 0; right: 0; border: 0;" src="http://s3.amazonaws.com/github/ribbons/forkme_right_white_ffffff.png" alt="Fork me on GitHub" />
</a>

# Vizir

    Disconnected from OAR job 960063

Ever been disconnected from Grid'5000 machines with a message like this one, losing part or all of your work?

Vizir is a simple Ruby script for [Mac OS X](http://www.apple.com/macosx/) that monitors your interactive jobs on [Grid'5000](http://www.grid5000.fr/).
It triggers [Growl](http://growl.info/) notifications when your reservations are going to terminate, allowing you to save your work and/or your deployed environments.

![A Growl notification](images/Growl.png)

## Usage

Simply run Vizir in the background, specifying your Grid'5000 login name with the <tt>--login</tt> switch.

    $ vizir --login priteau &

By default, Vizir triggers a notification every minute during the 10 minutes preceding the end of a reservation.

## Installation

Run the following if you haven't already:

    $ gem sources -a http://gems.github.com

Install the gem:

    $ sudo gem install priteau-vizir

Vizir uses [RubyCocoa](http://rubycocoa.sourceforge.net/) to trigger Growl notifications.
RubyCocoa is shipped with Mac OS X 10.5, so it should work out of the box on Leopard.

## Advanced usage

You can even send push notifications to your iPhone using [Prowl](https://prowl.weks.net/).
No more nodes shutting down silently while you take a coffee break!

![A Prowl push notification](images/Prowl.png)

## Bug reports / Feature requests

You can report any bug or ask for features by opening a ticket on [GitHub](http://github.com/priteau/vizir/issues) and labeling it with *bug* or *feature*.
Please open a different ticket for each issue.

Or, if you're old school, you can send me an [email](mailto:priteau@gmail.com).

## Getting the source

Clone it from [GitHub](http://github.com/priteau/vizir):

    $ git clone git://github.com/priteau/vizir.git

## Copyright

Copyright © 2009 Pierre Riteau. Vizir is released under the [MIT license](http://github.com/priteau/vizir/raw/master/LICENSE).
