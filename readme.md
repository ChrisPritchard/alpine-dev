# Alpine build environment

When you need to make tooling for those trickier docker containers you've landed on

Build with:

`docker build -t alpine-dev .`

Then run with (which also maps where you run from as an accessible folder):

`docker run -v "$(pwd)":/workspace -it alpine-dev`
