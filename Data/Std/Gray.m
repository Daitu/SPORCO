imgPath = 'C:\Users\zhangqi\Desktop\����ʦ����\SPORCO\sporco-m0.0.9\sporco-m0.0.9\Data\Std\';
imgDir  = dir([imgPath '*.png']);
size(imgDir);
for i = 1 :length(imgDir)
    img = imread([imgPath imgDir(i).name]);
    imgGray = rgb2gray(img);
    imwrite(imgGray,['C:\Users\zhangqi\Desktop\����ʦ����\SPORCO\sporco-m0.0.9\sporco-m0.0.9\Data\Gray\' imgDir(i).name]);
end
