# Working with Git Submodules

[up](README.md)

Git submodules are used in this project to manage the various OE layers for
reasons described in [this document](superproject-management.md). See this
[article](https://www.atlassian.com/git/tutorials/git-submodule) for an
introduction to Git submodules.

There are a few issues that are commonly encountered decsribed below.

## Modifying Submodules

Git submodules are not checked out as branch, but simply a git version. The
first thing you should do when working on a submodule is check out the
appropriate branch, documented in the [.gitmodules](../.gitmodules) file. If you
forget to do this, you may get an error when pushing and then if you run
`git branch`, you'll discover you are on the _(no branch)_ branch. To recover
from this situation, check out the branch you want to work on and then run
`git reflog`. This command will list recent commits which you can then
cherry-pick to your working branch. See this
[article](http://bec-systems.com/site/696/git-submodules-what-to-do-when-you-commit-to-no-branch)
for more information.

## Submodule merge conflicts

If you get a submodule merge conflict, run `git reset \<sources/submodule\>`

## Submodule remote changes

If the remote repository for a submodule changes, run `git submodule sync` to
synchronize the new remote information into your working directory. This problem
is most often noticed when the `git submodule update` command cannot find a
version.
