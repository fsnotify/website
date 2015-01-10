
## Contributing Articles

First you need [Hugo](http://gohugo.io/) installed and running. See the README.

### Setup

* Install the `hugo` binary, download it at [gohugo.io](http://gohugo.io/).

Running the server:

```bash
hugo server --theme=hyde -D --watch
```

### Creating a New Article

Hugo can create a new post for you:

```console
hugo new post/interview-joe-smith.md  --kind=interview
```

Preview locally and open a pull request once satisfied.

### Deployment

CircleCI automatically deploys the website when changes are merged to master. It takes about 20 seconds to deploy.

* [origin.fsnotify.org](http://origin.fsnotify.org/) is a website endpoint on Amazon S3.
* [fsnotify.org](https://fsnotify.org/) is edge-cached on Amazon CloudFront and secured with SNI. It can take a while to update.

