### fsnotify.org

This is the content for the fsnotify.org web site.

[![Circle CI](https://circleci.com/gh/go-fsnotify/fsnotify.org.svg?style=svg)](https://circleci.com/gh/go-fsnotify/fsnotify.org)

### Setup

* Install the `hugo` binary, download it at [gohugo.io](http://gohugo.io/).

Running the server:

```bash
hugo server --theme=hyde -D --watch
```

### Deployment

CircleCI automatically deploys the website when changes are merged to master. It takes about 20 seconds to deploy.

* [origin.fsnotify.org](http://origin.fsnotify.org/) is a website endpoint on Amazon S3.
* [fsnotify.org](https://fsnotify.org/) is edge-cached on Amazon CloudFront and secured with SNI. It can take a while to update.
