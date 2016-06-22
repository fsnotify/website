
## Contributing Articles

First you need [Hugo](http://gohugo.io/) installed and running.

### Setup

* Install the `hugo` binary, download it at [gohugo.io](http://gohugo.io/).

Running the server:

```bash
hugo server -v -D --watch
```

### Creating a New Article

Hugo can create a new post for you:

```console
hugo new post/interview-joe-smith.md  --kind=interview
```

Preview locally and open a pull request once satisfied.

### Deployment

CircleCI automatically deploys the website when changes are merged to master. It takes a minute.

