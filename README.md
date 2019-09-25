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

Add your variables to a file named `.biome` in your project directory.

```sh
mkdir ~/myproject
echo "export MYVAR=myvalue" > ~/myproject/.biome
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
export MYVAR=myoldvalue
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
echo export API_KEY=mysupersecretapikey0001 >> ~/myproject/.biome
echo export DB_PASS=mysupersecretdbpass0002 >> ~/myproject/.biome
echo export APP_SECRET=mysupersecretappsecret0003 >> ~/myproject/.biome
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
export API_KEY=mysupersecretapikey0004
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

[1]: https://github.com/jorgebucaran/fisher
