# rb-license

A simple tool because I got tired of manually copy/pasting the MIT license so
many times.

Usage:

    $ cd /usr/local/bin  # or anywhere in your PATH
    $ sudo ln -s /path/to/rb-license/license.rb license

then:

    $ license MIT John Smith  # creates file called LICENSE in current dir

You can also use a "config file" to avoid repeatedly retyping your name:

    $ cat > ~/.rb-license
    Keyboard Fire <andy@keyboardfire.com>
    $ license GPL  # name in ~/.rb-license, if it exists, is used
