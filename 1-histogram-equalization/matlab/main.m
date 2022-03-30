function main()
addpath('./functions');
format long;
color=imread('color.jpg');
histogramequalization(color,'color');
grey=imread('grey.png');
histogramequalization(grey,'grey');

grey_equalization=imread('grey_equalization.jpg');
histogrammatching(color,'color',grey,'grey');
histogrammatching(color,'color',grey_equalization,'grey_equalization');