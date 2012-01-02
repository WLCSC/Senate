Senate!
=======

More documentation to come.  For now, all you need to know is that it's a brainstorming, idea management, and voting Rails app.  All authentication is LDAP based at the moment - non-LDAP is there but not working.  

How To
------

* bundle install
* edit/create config/database.yml & config/app_config.yml
* rake db:setup

Note that LDAP users don't exist until the first time they log in.

Log in as someone who you said is an admin (or log in and then make yourself an admin through the console).  Front page-worthy news can be submitted with the "Submit New News" link at the bottom left.  you should also set up some groups to play with.

All the exciting stuff happens inside Chambers.  In a chamber, you have Announcements (chamber specific news), discussion boards, Proposals (thumbs up/down idea discussion), Ballots (voting), Titles (for certain users to get additional stuff after their name), and Permissions (controlling which users/groups can do what inside your chamber).