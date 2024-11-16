# My Dev Toolbox

> This image is meant to be used with the toolbox-create(1) command.

Since I started using [Fedora Silverblue] I've switched my workflow to use toolbox to set up my dev environments,
instead of overlaying packages, trying to keep my deployments as clean as possible.

As I was learing my ways around it, I kept having to re-create my toolboxes and had to run multiple commands everytime
to set them up as I wanted it to.

Eventually, I wrote a bash script, which worked fine.

But recently I came across the **Custom Images** section of the [Toolbx Documentation], where it describes how one can
go on to create their own custom Toolbx image and use that.

This repo is set up to track my Containerfile of my custom image for dev work, as well as notes and scripts related to
it.

The relevant GitHub Actions were set up in order to build a new image everytime there are changes either in the
 Containerfile or the files in the `files` directory.

## Versioning

The latest version of image _should_ always be available as `ghcr.io/elromanos/dev-toolbox:latest`.

A cron job is defined to run and update it once a week, with the latest Fedora repo updates. The tag for such images is
set as **YY.WW** where **YY** is the last two digits of the year and **WW** the week number it was build. So, **24.45**
is the image build on the 45th week of 2024.

## Setup

In order for the custom image to be loaded by default when I create a new toolbox, I need to override toolbox's default
settings. To do so, I had to create the `~/.config/containers/toolbox.conf` file with the following TOML content:

```toml
[general]
image = "ghcr.io/elromanos/dev-toolbox:latest"
```

## F.A.Q.

- **Q: Why Podman and not Docker?** [Fedora Silverblue] comes with Podman pre-installed. As I want to keep my base
  image as close to the defaults as possible, I decided to keep using Podman. For the simple needs of this exercise,
  Docker and Podman _should_ be interchangable/compatible.

[Fedora Silverblue]: https://fedoraproject.org/atomic-desktops/silverblue/
[Toolbx Documentation]: https://containertoolbx.org/doc/
[Red Hat Actions]: https://github.com/redhat-actions
