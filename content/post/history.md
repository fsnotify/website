+++
date = "2015-01-01"
title = "The Road So Far"
author = "Nathan Youngman"
+++

## How It All Began

In the early days of Go, before 1.0 and the compatibility promise, there were weekly releases. In one of those releases, Balazs Lecz provided a new `inotify` package for Linux. Then Hector Chu wrote `winfsnotify` for Windows. Chris Howey began a package called `kevent` for BSD.

There was talk of designing an API that works across systems. Chris took up the challenge -- in the autumn of 2011 `fsnotify` was born.

Fsnotify started by merging these three packages, exposing a single API. Create something on Linux and recompile it on Windows -- it just works.

That's harder than it sounds. File notifications behave differently on each  operating system. Props to Chris for working through *a lot* of edge cases.

## Continuous Feedback

From the beginning, fsnotify had users, with Rob Figueiredo testing it on OS X and later adopting it for [Revel][]. In early 2013, I became one of those users of fsnotify. 

I wanted a tool to automatically run my tests when files change, and a [hackathon][] was the perfect opportunity to build one.

[Looper][] watches entire subtrees, running tests for the package that changed. When you create a new package, it will automatically start watching that subdirectory as well. I was pretty pleased.

## Extending Fsnotify

This recursive watcher was something I built for Looper. As I looked around, I saw I wasn't alone. Maybe I could extract that logic into a little package other people could use and develop? There could be other useful extensions too, like the ability to coalesce duplicate events. 

As I was learning, I discovered that Windows and OS X can support recursive watches natively, OS X can even coalesce duplicates!

To not take advantage of the underlying OS would be such a missed opportunity. But to do so, I couldn't just build an extension on top of fsnotify, I would need to dig into the project itself.

## Virtual Machines

This was September 2013, and I had no idea what I was getting myself into. 

Before I could change fsnotify, the first obvious problem was how to test it across BSD, Linux, OS X and Windows.

Fortunately, we live in the modern era of virtual machines. With [Vagrant Gopher][vagrant], I got Go installed under Linux and BSD, and hand-rolled a Windows image for VMWare Fusion.

Now I could build things and `go test` to my hearts content. Huzzah!

## Pipe Dream

I had a plan. Maybe ingenious, maybe misguided.

If I built my recursive watcher into fsnotify, later on we could optimize it away on systems that have native support.

Not only that, my generalized [event processing pipeline][pipeline]&trade;
 could coalesce events, filter out uninteresting files, and prepare breakfast in the morning.\*

I worked on it for the remainder of the year, but never merged it.

## Standard Library 

Before the release of Go 1.0, the inotify, winfsnotify and fsnotify packages were shuffled off to [exp][].

The Go Team, predominantly Russ Cox, [remain interested][osfsnotify] in a file system monitoring API in the standard library. Just over a year ago, Russ released a [proposal][] to use fsnotify to speed up the `go` tool itself.

It's quite the read. To think, the Go compiler and toolchain are so fast,  looking for changes with `Stat` is a bottleneck. There's also mention of potentially adding a `-watch` flag, like having [Looper][] built in. Awesome!

At the same time, Russ Cox started an [API sketch][sketch] for `os/fsnotify`, which I used as the basis for an [API design document][api].

From the surrounding discussion, I gained insight into designing APIs, and in particular, the kind of API that would one day *feel at home* in the Go standard library. 
 
## A Friendly Fork

There are quite literally [hundreds of packages][importers] that use Chris Howey's fsnotify. Before changing the API, I made a fork and put up a moving notice. 

In retrospect, the fork may not have been entirely necessary. Using [gopkg.in][] has allowed me to keep an API compatible version in the same repository as the new API.

## Less Is Less

Besides the surface-level changes, one of the first things I did was *remove a feature*.

Maybe your app is interested in events for newly created files but not deletions. One way to handle this is to interrogate every event you receive -- just ignore deletion events. 

Alternatively, it *was* possible to tell fsnotify to only send certain events. 

The API was reminiscent of inotify and kqueue, which can tell the operating system kernel which events to subscribe to. This is great in that it provides a performance benefit.

Unfortunately inotify, kqueue and Windows each behave differently. Instead, fsnotify did a lot of internal bookkeeping to filter out uninteresting events just before forwarding them on.

The bookkeeping code was a little buggy, and it never actually told the kernel which events to send, so there was really no benefit.

My solution for now -- remove the feature entirely.

Being able to give the kernel hints to improve performance is valuable. It is a feature that may make a [comeback][]. 

## The Great Unknown

If all we wanted was inotify, kqueue and ReadDirectoryChangesW, the current API might not be far off. But that's not the case.

Sam Jacobson has been doing some good work on [FSEvents][].

Peter Krnjevic recently informed me of [Windows USN Journals][usn] -- it could be worth exploring. Then there is [FEN][] for Solaris -- we haven't even started implementing that.

All of this will determine what fsnotify becomes. Though I don't know what it will look like in the end, I have some plans for getting there. 

But that, my friend, will have to wait for another post.  
Happy New Year!


[Looper]: https://github.com/nathany/looper
[howeyc]: https://github.com/howeyc/fsnotify
[pipeline]: https://github.com/howeyc/fsnotify/pull/65
[changelog]: https://github.com/go-fsnotify/fsnotify/blob/master/CHANGELOG.md
[exp]: https://godoc.org/golang.org/x/exp
[osfsnotify]: https://github.com/golang/go/issues/4068
[hackathon]: http://startupedmonton.com/events/
[Revel]: http://revel.github.io/
[vagrant]: https://github.com/nathany/vagrant-gopher

[proposal]: http://golang.org/s/go13fsnotify
[sketch]: https://codereview.appspot.com/48310043/
[api]: http://goo.gl/MrYxyA

[importers]: http://godoc.org/github.com/howeyc/fsnotify?importers
[gopkg.in]: http://labix.org/gopkg.in
[comeback]: https://github.com/go-fsnotify/fsnotify/issues/7

[usn]: https://github.com/go-fsnotify/fsnotify/issues/53
[fsevents]: https://github.com/go-fsnotify/fsevents
[fen]: https://github.com/go-fsnotify/fsnotify/issues/12

