# Git Superproject Management

[up](README.md)

One controversial choice in Yoe is the use of Git Submodules vs Repo. Because we
need to manage multiple Git repositories, something is needed. There are a
number of solutions including:

- Git submodules (what we use now)
- Google repo
- Git subtree
- custom scripts
- Poky style combo repo

In this document, we will use the OE term "layers" to refer to git
subrepositories (submodules). Superproject is the term that describes the
project that manages all the subprojects (layers).

## Requirements

Yoe is designed foremost for product development, or using Yocto/OE to build
software that will be deployed in real products (vs a technology demo build). It
is also designed to be used by people who may not be embedded Linux/Git experts,
but yet want to create builds and make incremental improvements over long
product lifecycles (can be 5 years or more). From this, we derive Yoe's
requirements (somewhat ordered by priority).

1. know exactly what version of all software (layers) were used in a particular
   build, and be able to rebuild any version on any machine.
1. all build and configuration files (local.conf, etc) must be stored in git.
1. project structure is obvious and easy to understand. Obscure steps such as
   copying on soft-linking setup scripts that may be modified is minimized.
1. hard to make mistakes such as changing a layer version or config file, and
   then forgetting to record this change.
1. easy to add/remove layers to the build.
1. easy to make changes to layers and submit changes back upstream.
1. easy to fork layers if tweaks need to be made that are not available
   upstream.

Every solution has tradeoffs. To accomplish one goal, you often have to accept
compromises on another goal, so it is likely no one tools is best to accomplish
all of these goals.

## Git Submodules

- pros
  - super/sub project organization is obvious -- top level git repo is the
    superproject, and subprojects live under it in the directory tree
  - git status gives you status of submodules and files in one command
  - easy to store layer versions and conf file changes in the superproject
  - difficult to forget to record layer versions (git status shows you)
  - well documented in git documentation
  - .gitmodules file is simple and easy to read
  - easy to track development of layers by specifying branch in .gitmodules, and
    updating to latest on branch with "git submodule update --remote"
  - a number of application developers are already using git submodules in
    various projects, where repo is less common except in large build systems
    (like Android)
  - easy to do recursive changelogs into submodules (again, useful for
    production)
  - optimized for development when subprojects are not changing a lot
- cons
  - no-branch issue when making changes to a submodule:
    http://bec-systems.com/site/696/git-submodules-what-to-do-when-you-commit-to-no-branch
  - removing submodules can be a little confusing
  - updating a submodule URL requires a "sync" to propagate changes to working
    submodule.

## Google Repo

- pros
  - repo manifest is flexible/powerful
  - repo manifest can include other manifests
  - easy to switch/sync git urls
  - a lot of users due to use in Android build system
  - good at managing large numbers of subprojects where you own all the
    subprojects (example, repo can apply a tag to all the subprojects). However,
    with Yocto, you are typically using 3rd party layers where you don't own the
    repository and can't push tags to these repositories.
  - optmized for development when subprojects are changing a lot
- cons
  - To lock down layers, you have to specify the git hash in the manifest:
    https://github.com/Angstrom-distribution/angstrom-manifest/blob/angstrom-v2018.06-sumo/default.xml#L22.
    This requires additional tooling to be practical for product development.
  - Repo is a separate tool from git that needs to be installed and learned
  - official documentation is sparse
  - manifest file is more complex and harder to read at a glance than
    .gitmodules
  - location of manifest file is somewhat hidden and less obvious how to manage
  - difficult to store both subproject info and other files in the superproject.

## Git Subtree

At this point git subtree is not activily being considered as it mixes all the
subprojects into one repo, and likely not optimal for managing layers, most of
which will rarely change during a product lifecycle. It seems to be a tool for
more advanced users.

## Poky style combo repo

One popular trend these days are [monorepos](http://danluu.com/monorepo/) which
are popular in various large companies (like Google and Facebook).
[Poky](http://git.yoctoproject.org/cgit/cgit.cgi/poky) is somewhat of a monorepo
in that it contains bitbake, oe-core, and some other things in one git repo.
This makes it easy to checkout one repository and build a demo image if you want
to test Yocto. However, once you want to add other layers, you still have to
deal with multiple repositories or figure out the
[combo-layer](http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/scripts/combo-layer)
tool. Additionally, if you make changes to one of the pieces of Poky, extracting
these changes to submit back upstream is not as easy as if the repositories were
simply split out in their original form. Also, it is less obvious you might
update just one port of the combo repo, but not others.

It seems monorepos are best for projects where a company owns everything in the
repo. With a Yocto build, most of the layers come from third parties. In this
scenario, it seems a superproject type setup is a better fit. We favor the
transparency of showing clearly where each layer came from so it is obvious
where to go for support, etc.

## Summary

As mentioned before, each solution has trade-offs. Superproject management is
messy at best, because there are conflicting goals. Changing layer urls and
tracking floating layers is easier in Repo, but locking down layer versions is
easier in git submodules. With any solution, some amount of tooling will likely
be required to smooth out, or at least document, the pain points.

For the typical Yoe user who is building a product, by far the most common use
of Yoe is simply building iterative releases for a product where very little
changes from release to release except application code. These product cycles
can be 5 years or more with 100's of releases. During this time, the layers may
change from time to time to add new packages, tweak the system files, or update
to a new version of Yocto, but these layer changes are relatively few compared
to the application changes. We want to optimize the experience for this use case
where a developer using Yoe is not a Yocto expert, but knows enough to tweak
recipes, run builds, etc.

The ability to manage both configuration files, documentation, scripts/tools,
and subprojects in a single superproject with git submodules seems like a much
simpler model than repo, where the only thing you can really manage in a repo
manifest is the subproject. This is a simpler setup because everything the user
typically needs to interact with is near the top of the directory tree and easy
to find. Things that change from one iterative build to the next are located in
the top level superproject, so all you need to tag a build is a simple git
add/tag/commit/push of the superproject. Convenience tooling and conf file
changes can easily be made, and it is obvious where they are stored. With repo,
this is often a layer of indirection where local.conf and other files are copied
(or generated) to a temporary build directory and it is not obvious how this
happens, or how to capture changes in git. Additionally, if you want to lock
down layers to a git version, typically tooling is written to add these git
hashes to the manifest file for a release build, and then revert this back to
floating branches for development. This tooling is unnecessary with git
submodules.

There is a cost to complexity. We may be temped to reach for the most powerful
tool at our disposal, but there is a cost if a simpler tool would work. With
tooling, there is no one-size-fits all. We don't pick up a sledge hammer to
drive a tack, nor do we use a tack hammer to bust up concrete, nor do we buy a
robot if we only need to drive a few nails. The best solutions are the simplest
one that does the job well. "Clear" and "obvious" are the best solutions in a
build system. "Neat" and "clever" usually are not.

(Note, I don't claim Yoe meets this lofty goal, but this is the vision.)

It seems git submodules are still a better fit for the use case Yoe was designed
for, however this is not set in stone, but simply where we are at this point. It
is acknowledged that repo may make some things easier for OE/Layer core
developers where who are often modifying and updating layers. So, if repo works
great for you, by all means keep using it. That is the beauty of OE layers --
you can put then together using whatever tools works best for you. Yoe is just
an attempt at keeping things as simple as possible for product developers.
