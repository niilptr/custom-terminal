# custom-terminal (MacOS)

This repository contains utilities for custom terminal configurations.

## How to set

Make sure that no `$HOME/custom-terminal` already exists. If it does, rename the repository.

Clone this repository in the $HOME directory:

```
git clone
```

Add the following to your `.zshrc`:

```
for f in $HOME/custom-terminal/src/*; do source $f; done
```

This will load:
```
custom-terminal/
 |- aliases.sh
 |- autocompletion.sh
 |- functions.sh
 |- prompt-styling.sh
```

## What it does

It adds the following:
- prompt styling,
- custom shell functions (mostly git shortcuts),
- custom aliases registration,
- autocompletion.

<br>

### Prompt styling
---

The general prompt header will have this format:
```
[user]@[machine] /path/to/dir $
```

When in a git repository instead, /path/to/dir will be relative to the git repository root, showing also the branch:
```
[user]@[machine] ( [branch] [repo]/path/from/root ) $
```

<br>

### Shell functions
---

Currently available:

- `gga()` : git graph all :

    arguments:

        N:  num of entries to display (optional, default=10)

    command:
    
        git log --oneline --graph --all -n $N

    usage:
    
        gga 20

<br/>

--- 

<br/>


- `gg()` : git graph :

    arguments:

        N:  num of entries to display (optional, default=10)

    command:
    
        git log --oneline --graph -n $N

    usage:
    
        gg 20

<br/>

--- 

<br/>

- `gc()` : git checkout :

    arguments:

        B:  branch (optional, default=main, on error try: master)

    command:
    
        git checkout $B
    
    usage:
    
        gc mybranch

<br/>

--- 

<br/>


- `gaac()` : git add and commit :

    arguments:

        C:  commit message (required)

    command:
    
        git add . && git commit -m "$C"

    usage:
    
        gaac "my commit message"

<br/>

--- 

<br/>

- `gcmm()` : git commit -m message:

    arguments:

        C:  commit message (required)

    command:
    
        git commit -m "$C"

    usage:
    
        gcmm "my commit message"

<br/>

--- 

<br/>

- `cdgr()` : cd git root

    arguments:

        none

    command:
    
        cd $(git rev-parse --show-toplevel)

    usage:
    
        cdgr

- `cdl()` : cd and list

    arguments:

        D:  directory (required)

    command:
    
        cd "$D" && ls -al

    usage:
    
        cdl subfolder

<br/>

--- 

<br/>

You can remove the functions you don't need from `custom-terminal/aliases.sh`.

<br>

### Aliases
---

It registers the following aliases:

| alias | command |
|---|---|
| `ll` | `ls -la` |
| `nanozsh` | `nano $HOME/.zshrc` |
| `tree1` | `tree -L 1` |
| `source_zshrc` | `source $HOME/.zshrc` |

You can remove the alias you don't need from `custom-terminal/aliases.sh`.

<br>

### Autocompletion
---

It uses the following to set the autocompletion up:
```
autoload -Uz compinit && compinit
```