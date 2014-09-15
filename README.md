### fsnotify.org

The content for fsnotify.org.

Symlink public to GitHub Pages repo:

```
ln -s $GOPATH/src/github.com/go-fsnotify/go-fsnotify.github.io $GOPATH/src/github.com/go-fsnotify/fsnotify.org/public
```

Running the server:

```bash
hugo server --theme=hyde --buildDrafts --watch
```

