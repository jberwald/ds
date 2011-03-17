function startup

giaopath = '/usr/local/gaio-2.2.8';
intlabpath = '/usr/local/Intlab_V6';

% add GAIO
  addpath(giaopath)
  addpath([giaopath '/matlab'])
  addpath([giaopath '/gaio'])
  addpath([giaopath '/models/i486-libc6/'])

% add Intlab
  addpath(intlabpath)

% add our stuff
  addpath(genpath('matlab'))
  addpath(genpath('help'))

startintlab

