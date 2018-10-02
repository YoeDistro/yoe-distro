# Git Superproject Management

One of the most controversial decisions in Yoe is the choice of
Git Sumodules vs Repo. Because we need to manage multiple
Git repositories, something is needed. There are a number of
solutions including:

* Git submodules (what we use now)
* Google repo
* Git subtree
* custom scripts

In this document, we will use the OE term "layers" to refer to git
subrepositories (submodules). Superproject is the term that describes
the project that manages all the subprojects (layers).

## Requirements

Yoe is designed formost for product development, or using Yocto/OE to
build software that will be deployed in real products (vs a technology demo
build for a vendors CPU/SOM). It is also designed to be used by people who may
not be embedded Linux/Git experts, but yet want to create builds and make
incremental improvements over the long product lifecycle (can be 5 years or
more). From this, we derive Yoe's requirements (somewhat ordered by priority).

1. know exactly what version of all software (layers) were used in a paticular
   build, and be able to rebuild any version on any machine.
1. all build and configuration files (local.conf, etc) must be stored in git.
1. project structure is obvious and easy to understand. Obscure steps such
   as copying on soft-linking setup scripts that may be modified is minimized.
1. hard to make mistakes such as changing a layer version or config file, and
   then forgetting to record this change.
1. easy to add/remove layers to the build.
1. easy to make changes to layers and submit changes back upstream.
1. easy to fork layers if tweaks need to be made that are not
available upstream.

Every solution has tradeoffs. To accomplish one goal, you
often have to accept compromises on another goal, so it is not likely we can
accomplish all of these goals.

## Git Submodules

* pros
  * super/sub project organization is obvious -- top level git repo is the
    superproject, and subprojects live under it in the directory tree
  * easy to store layer versions and conf file changes in the superproject
  * difficult to forget to record layer versions (git status shows you)
  * well documented in git documentation
  * .gitmodules file is simple and easy to read
  * easy to track development of layers with "git submodule update --remote"
* cons
  * no-branch issue when making changes to a submodule:
    http://bec-systems.com/site/696/git-submodules-what-to-do-when-you-commit-to-no-branch
  * removing submodules can be a little confusing
  * updating a submodule URL requires a "sync" to propogate changes to working
    subodule.

## Google Repo

* pros
  * repo manifest is flexible/powerful
  * repo manifest can include other manifests
  * easy to switch/sync git urls
  * a lot of users due to use in Android build system
  * good at managing large numbers of subprojects
* cons
  * To lock down layers, you have to specify the git hash in the manifest:
    https://github.com/Angstrom-distribution/angstrom-manifest/blob/angstrom-v2018.06-sumo/default.xml#L22. This requires additional tooling to be
    practical for product development.
  * Repo is a separate tool from git that needs to be installed and learned
  * official documentation is sparse
  * manifest file is more complex and harder to read at a glance than
    .gitmodules
  * location of manifest file is somewhat hidden and less obvious how to manage
  * difficult to store both subproject info and other files in the
    superproject.

## Git Subtree

At this point git subtree is not activily being considered as it mixes
all the subprojects into one repo, and likely not optimal for managing layers,
most of which will rarely change during a product lifecycle. It seems to be
a tool for more advanced users.

## Summary

As mentioned before, each solution has tradeoffs. Superproject management is
messy at best, because there are conflicting goals. Changing layer urls and
tracking floating layers is easier in Repo, but locking down layer versions
is easier in git submodules. TODO finish this ...
