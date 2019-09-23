Biome: Fish Edition
===================

Manage isolated environment variables


Installation
------------

Using [fisher][1]:

```fish
fisher add codeindulgence/biome-fish
```


Usage
-----

Create a .biome file in a folder somewhere:

```sh
echo "export MYVAR=myvalue" > .biome
```

Whenever you `cd` into this folder (or any of its children), the variables will
be set.

Whenever you `cd` out of this folder (or any of its children), the variables
will be unset or restored to their previous values.


[1]: https://github.com/jorgebucaran/fisher
