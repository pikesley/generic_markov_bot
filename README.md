#Generic Markov Bot

[Parker Moore](https://github.com/parkr)'s [ebooks](https://github.com/parkr/ebooks) gem is [great](https://twitter.com/pikesley_ebooks), but I wanted something more generic, not tied to a Twitter archive. So I cooked this up.

##Twitter config

See [Dalton Hubble's great blogpost](http://dghubble.com/blog/posts/twitter-app-write-access-and-bots/) for instructions on setting up a Twitter bot. Once you've done this, you should have the credentials in _~/.twurlrc_. Use the `twurl_extractor.rb` script to fill in your _.env_:

    bundle
    ./twurl_extractor.rb <name_of_your_bot>

##Source text(s)

    mkdir sources/

Then put your source text(s) into that _sources/_ dir, as plain text files

##Tweet

    ./bot.rb

Er, and that's it

##Automate it

To run it out of Upstart, use a _/etc/init/markov-bot.conf_ like this:

    pre-start script
    bash << "EOF"
      mkdir -p /home/bot/log/
      chown -R bot /home/bot/log/
    EOF
    end script

    start on runlevel [2345]
    stop on runlevel [016]

    exec su - bot -c 'while [ 1 ] ; do cd generic_markov_bot ; ./bot.rb  >> /home/bot/log/markov.log ; sleep ${RANDOM:0:4} ; done'

Sweetened to taste, of course

##Bugs

Probably. As you can see, there are no tests here
