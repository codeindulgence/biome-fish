Biome: Fish Edition
===================

Manage isolated environment variables

- [Install](#installation)
- [Usage](#usage)
- [Configure](#configure)

Installation
------------

Using [fisher][1]:

```fish
fisher add codeindulgence/biome-fish
```


Usage
-----

Add your variables to a file named `.biome` in your project directory.

```sh
mkdir ~/myproject
echo "MYVAR=myvalue" > ~/myproject/.biome
```

**Enter the biome!**

```sh
cd ~/myproject
```

```
Entering biome: myproject
+ MYVAR: myvalue
```

**Exit the biome...**

```sh
cd ~
```

```
Exiting biome: myproject
- MYVAR: myvalue
```

**Sub directories also work!**

```sh
mkdir -p ~/myproject/myfolder
cd ~/myproject/myfolder
```

```
Entering biome: myproject
+ MYVAR: myvalue
```

**Remember previous values!**

```sh
cd ~
MYVAR=myoldvalue
cd ~/myproject
```

```
Entering biome: myproject
- MYVAR: myoldvalue
+ MYVAR: myvalue
```

```sh
cd ~
```

```
Exiting boime: myproject
- MYVAR: myvalue
+ MYVAR: myoldvalue
```

**Guard your secrets!**

```sh
echo API_KEY=mysupersecretapikey0001 >> ~/myproject/.biome
echo DB_PASS=mysupersecretdbpass0002 >> ~/myproject/.biome
echo APP_SECRET=mysupersecretappsecret0003 >> ~/myproject/.biome
cd ~/myproject
```

```
Entering biome: myproject
- MYVAR: myoldvalue
+ MYVAR: myvalue
+ API_KEY: *******************0001
+ DB_PASS: *******************0002
+ APP_SECRET: **********************0003
```

**Guard them both ways!**

```sh
cd ~
API_KEY=mysupersecretapikey0004
cd ~/myproject
```

```
Entering biome: myproject
- MYVAR: myoldvalue
+ MYVAR: myvalue
- API_KEY: *******************0004
+ API_KEY: *******************0001
+ DB_PASS: *******************0002
+ APP_SECRET: **********************0003
```

```sh
cd ~
```

```
Exiting biome: myproject
- MYVAR: myvalue
+ MYVAR: myoldvalue
- API_KEY: *******************0001
+ API_KEY: *******************0004
- DB_PASS: *******************0002
- APP_SECRET: **********************0003
```


Configure
---------

The following options can be changed using `set -g <option> <value>`

- `_biome_mask_char`
  - Sets the character used to mask sensitive values. Want something cool?
    Consider [Nerd Fonts][2]
  - Default: `*`
  - Example: `set -g _biome_mask_char 'x'`

- `_biome_filename`
  - Sets the filename used for biome variables
  - Default: `.biome`
  - Example: `set -g _biome_filename .env`


Contributing
------------
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D


Credits
-------
[Nick Butler](https://github.com/codeindulgence)


[1]: https://github.com/jorgebucaran/fisher
[2]: https://www.nerdfonts.com/
