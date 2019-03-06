imgDir = dir('*.png');
for i = 1:length(imgDir)
    img = imread([imgDir(i).name]);
    img = imresize(img,[512,512]);
    imwrite(img,imgDir(i).name);
end