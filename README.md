docker-goagent
=================

[Goagent][goagent] for Docker.
[goagent]: https://code.google.com/p/goagent/

## Image Creation

This example creates the image with the tag `mengbo/docker-goagent`, but you can
change this to use your own username.

```
$ docker build -t="mengbo/docker-goagent" .
```

Alternately, you can run the following if you have *make* installed...

```
$ make
```

You can also specify custom variables by change the Makefile.

You can run it by the following command...

```
$ wget https://raw.githubusercontent.com/mengbo/docker-goagent/master/deploy.sh; sh ./deploy.sh
```


## Environment variables

 - `GOAGENT_LISTEN_USERNAME`: Username of goagent proxy. Default: `goagent`
 - `GOAGENT_LISTEN_PASSWORD`: Password of goagent proxy. Default: `goagent`
 - `GOAGENT_GAE_APPID`: Google app engine AppID. Default: `docker-goagent`
 - `GOAGENT_GAE_PASSWORD`: Password of server on GAE. Default: `docker-goagent`
