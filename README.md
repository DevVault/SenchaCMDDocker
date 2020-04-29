# SenchaCMD Docker Images

## Description

[Docker](http://www.docker.com/) image to run [Sencha Cmd](http://www.sencha.com/products/sencha-cmd/#overview).

### What is Sencha Cmd?
Sencha Cmd is the cornerstone for building your Sencha Ext JS and Sencha Touch applications. Sencha Cmd provides a full set of lifecycle management features such as scaffolding, code minification, production build generation, and more, to complement your Sencha projects.
![](https://www.sencha.com/wp-content/uploads/2015/03/sencha-cmd-hero.png)

### Supported tags and respective `Dockerfile` links

- [`6.2.2`](https://github.com/DevVault/SenchaCMDDocker/blob/6.2.2/Dockerfile)
- [`6.5.3.6`](https://github.com/DevVault/SenchaCMDDocker/blob/6.5.3.6/Dockerfile)
- [`6.6.0.13`](https://github.com/DevVault/SenchaCMDDocker/blob/6.6.0.13/Dockerfile)
- [`6.7.0.63`](https://github.com/DevVault/SenchaCMDDocker/blob/6.7.0.63/Dockerfile)
- [`7.0.0.40`](https://github.com/DevVault/SenchaCMDDocker/blob/7.0.0.40/Dockerfile)
- [`7.1.0.15`](https://github.com/DevVault/SenchaCMDDocker/blob/7.1.0.15/Dockerfile)
- [`7.2.0.56`](https://github.com/DevVault/SenchaCMDDocker/blob/7.2.0.56/Dockerfile), [`latest`](https://github.com/DevVault/SenchaCMDDocker/blob/7.2.0.56/Dockerfile)

For more information about the changes in this version please check the [release notes](https://docs-devel.sencha.com/cmd/7.2.0/guides/release_notes.html). This image is updated automatically on each generally available release of Sencha Cmd.

### What's included?

This image is based on [OpenJDK's image](https://hub.docker.com/_/openjdk/) ([`openjdk:8-jre-alpine`](https://github.com/docker-library/openjdk/blob/54c64cf47d2b705418feb68b811419a223c5a040/8-jdk/alpine/Dockerfile)), so it is based on an Alpine Linux distribution.
 
- OpenJDK 8 JRE
- Ruby 2.6
- Sencha Cmd 7.2. with Compass extensions
- Compass 1.0.3
- JsDuck 5.3.4

### How to use this image?

#### Standalone applications

Standalone applications are those where workspace.json is at the root of the app (a single-application workspace).
To run any command over your codebase, just mount it over at `/code`:

```shell
	docker run --rm -it -v /your/local/path:/code devvault/senchamcd sencha [<options>]
```

For example, to generate new ExtJS application `MyFirstApp` on current directory:

```shell
  docker run --rm -it -v "$(pwd)":/code devvault/senchamcd sencha -sdk "$(pwd)/ext-6.2.0" generate app MyFirstApp .
```

#### Multi-application workspace

Besides mounting your workspace at `/code` you'll need to specify the application directory to work on. This is done using the `--workdir` parameter. For example, to build an application located in the `myapp` directory inside the mounted workspace, you'd need to run this command:

```shell
  docker run --rm -it -v /some/local/workspace:/code --workdir=/code/myap devvault/senchamcd sencha app build
``` 

### Including this image in your `Dockerfile`

You can include this image in your `Dockerfile`:
```Dockerfile
    FROM devvault/senchamcd:latest
    COPY . /code
    CMD ['app', 'build']
```    
Or, you can use [Docker Compose](https://docs.docker.com/compose/)'s docker-compose.yml

```yaml
  sencha:
      image: devvault/senchamcd
      volumes:
          - /local/path/to/project:/code
```

And run it via

```shell
  docker-compose run sencha [<options>]
```

### License

Sencha Cmd is licensed commercially for free.<br>See [http://www.sencha.com/legal/sencha-tools-software-license-agreement](http://www.sencha.com/legal/sencha-tools-software-license-agreement) for license terms.

### User feedback

#### Issues 

If you have any problems with or questions about Sencha Cmd, please use our [Forums](https://www.sencha.com/forum/forumdisplay.php?8-Sencha-Cmd) or [Support Portal](https://support.sencha.com/#login).

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/israelroldan/docker-sencha-cmd/issues).

#### Contributing

You are invited to contribute new features, fixes, or updates. We'll do our best to process your pull requests as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/DevVault/SenchaCMDDocker/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

## Requirements

- Docker
