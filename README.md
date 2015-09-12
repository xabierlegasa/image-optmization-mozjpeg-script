
# image-optimization-mozjpeg-script #

optimize-images.sh gives the possibility to optimize all images of a given folder using mozjpeg library by mozzilla.
For each image found, it will ask whether you want to optimize or not.

## Requirements ##

#### Node.js ####
Try `node -v` to see if node it's already installed. If not, the doc is here:
https://docs.npmjs.com/getting-started/installing-node

All info about npm: https://docs.npmjs.com/getting-started/what-is-npm


## Install ##

1. Install npm dependencies, defined in package.json:

`npm install`

2. Install optimizer script, defined in package.json:

`npm link`


## Usage ##

`./optimize-images.sh --folder=./web/images --quality=90`

Default for folder is "./web", and default for quality is 80, so this is also valid, if web folder exists.
`./optimize-images.sh `


So it should look something like this:

```
➜  image-optmization-mozjpeg-script git:(master) ✗ ./optimize-images.sh
Searching for images to be optimized with mozjpeg algorithm...
Folder  = ./web
Quality = 80

found image: ./web/images/google.jpg
 Would you like to optimize the image? [y/N] y
optimizing image...
inputFile: ./web/images/google.jpg
outputPath: ./web/images/
image size is now 20 % less. From 23296 KB to 18692 KB

found image: ./web/images/image.jpg
 Would you like to optimize the image? [y/N] y
optimizing image...
inputFile: ./web/images/image.jpg
outputPath: ./web/images/
image size is now 35 % less. From 93176 KB to 61346 KB

OK. 2 image(s) have been optimized.
```

