#! /usr/bin/env node

// this script takes two arguments.
// First argument is the image to be optimized.
// Second argument is the quality of the compression.
// See https://www.npmjs.com/package/imagemin-mozjpeg for more details

var inputFile = process.argv[2];
var outputPath = inputFile.substring(0,inputFile.lastIndexOf("\/")+1); // change for windows to "\\"
var quality = process.argv[3];

console.log('inputFile: ' + inputFile);
console.log('outputPath: ' + outputPath);

var Imagemin = require('imagemin');
var imageminMozjpeg = require('imagemin-mozjpeg');

new Imagemin()
    .src(inputFile)
    .dest(outputPath)
    .use(imageminMozjpeg({quality: quality}))
    .run();
