# git past-amend #

Quickly amend code in past commits.

This is a simple tool to make the following workflow easier: You're working on a feature, and it involves 3 separate commits: `A -> B -> C`. You have commit `C` checked out, and then you realize that you need to do a little change to code in commits `A` or `B`. Instead of having to reset/rebase/cherry-pick yourself, this tool lets you do it in one line.


# How to use #

You have changes in your working tree that you want to add to the parent of the parent of `HEAD`.

Run this: 

    git past-amend 2
    
Use `3` for the parent of the parent of the parent, etc.

*Alternatively,* you can choose the past commit that should be amended:

    git past-amend 377eb99d

That's it, the commit has been amended, your other commits were rebased and you can continue working.



# WARNING! You may lose your code! #

`git past-amend` is a tiny open-source project with very minimal testing. It might delete all of your code. Please have full backups to all of your code before using this tool.


# How to install #

Just download the `git-past-amend` file from this repo and put it someplace on your path, like `~/bin/`


# Questions #

**Do I need to stage the changes?** No, they should not be staged, and `git past-amend` will stage them automatically.

**What's the license?** MIT license.

**What if there's a rebase conflict?** In that case you can resolve it manually like any other rebase conflict, do `rebase --continue` when you're done and the `past-amend` action will be completed.