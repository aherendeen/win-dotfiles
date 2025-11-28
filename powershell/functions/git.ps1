# Git Shortcuts
# Common git operations with short aliases

# Status and diff
function gst { git status }
function gd { git diff @args }
function gds { git diff --staged @args }
function gdc { git diff --cached @args }

# Add and commit
function ga { git add @args }
function gaa { git add --all }
function gap { git add -p @args }
function gc { git commit -m @args }
function gca { git commit -a -m @args }
function gcam { git commit --amend }
function gcane { git commit --amend --no-edit }

# Push and pull
function gp { git push }
function gpf { git push --force-with-lease }
function gpl { git pull }
function gplr { git pull --rebase }
function gf { git fetch @args }
function gfa { git fetch --all --prune }

# Branch management
function gb { git branch @args }
function gba { git branch -a }
function gbd { git branch -d @args }
function gbD { git branch -D @args }
function gco { git checkout @args }
function gcb { git checkout -b @args }
function gsw { git switch @args }
function gsc { git switch -c @args }
function gm { git merge @args }

# Log and history
function gl { git log --oneline -15 }
function gla { git log --oneline --all -20 }
function glog { git log --graph --oneline --decorate --all }
function glp { git log -p -1 }

# Stash
function gstash { git stash @args }
function gpop { git stash pop }
function gsl { git stash list }

# Cleanup
function gclean { git clean -fd }
function greset { git reset --hard HEAD }
function grh { git reset HEAD @args }
function grhh { git reset --hard HEAD }

# Remote
function gr { git remote -v }
function gra { git remote add @args }
