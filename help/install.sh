#!/bin/bash

echo "
--------------------------------------------------------------------
--------------------------------------------------------------------

Well hello there, this is the install script for:

              <insert clever project name here>

To install, you'll need to know where GAIO and Intlab are on your
machine, so have their paths handy.  If you don't know what I'm
talking about, check out setup.txt

So, where is GAIO?  Full path to the directory, please:"
read gaiopath
echo "Ok, $gaiopath, great."
echo "How about Intlab?"
read intlabpath

# write the startup.m script
echo "function startup

giaopath = '$gaiopath';
intlabpath = '$intlabpath';

% add GAIO
  addpath(giaopath)
  addpath([giaopath '/matlab'])
  addpath([giaopath '/models/i486-libc6/'])

% add Intlab
  addpath(intlabpath)

% add our stuff
  addpath(genpath('matlab'))
  addpath(genpath('help'))

startintlab
" > ../startup.m
echo "
Wonderful.

I just wrote writing a startup script (startup.m) for you in the main
directory.  If you messed up the paths for GAIO or Intlab, you can
either run this again or edit the paths in the top of that file.

To begin, start matlab in the main directory (where the startup.m file
is).  You may also want to look at the tutorial before starting, in
the help directory.

May the entropy be with you."
mkdir ../data 2> /dev/null
mkdir ../data/tmp 2> /dev/null