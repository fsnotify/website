+++
date = "2014-09-14T20:26:20-06:00"
title = "Introduction to File System Notifications"
+++

When a file or directory is created, modified or removed, the Operating System can inform any applications that wish to know. This can come in handy in many situations:

* Text editors know a file has changed externally and may offer to reload it.
* Applications know that there are changes to backup (Time Machine, Arq) or synchronize (Dropbox).
* Search engines (Spotlight) can update their search indexes.
* Static site generators (Hugo) can serve up changes as they are made.
* Development tools can rebuild code or run tests automatically.

To make this work, an application simply subscribes to be notified of events. 

At least it should be that simple, but unfortunately each Operating System has a different way of doing things.

> "Some of you may be familiar with existing file monitoring solutions... they are a pain in the butt to use, they are complex, they are not user friendly, and they have a lot of race conditions that you have to be aware of as a developer."  
> [Scaling Source Control at Facebook](http://www.youtube.com/watch?v=Dlguc63cRXg) by Durham Goode 

With [fsnotify][] you have a platform-independent interface to file system notifications in the [Go programming language][golang]. It tries to take the pain out of file system notifications so you can get on with writing your application.

This blog is here to provide updates on fsnotify itself and a deeper look at file system notifications for the curious. Until next time.

[golang]: http://golang.org/
[fsnotify]: https://github.com/go-fsnotify/fsnotify