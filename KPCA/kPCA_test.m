function [] = kPCA_test()
n = 1;
arr = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
for digitno = 1:26
    cd(arr(digitno));
    for imageno = 1:21
        if imageno ~=7
            imagestr = int2str(imageno);
            tempimg = imread(strcat(imagestr,'.png'));
            tempimg = rgb2gray(tempimg);
            inp(:,n) = tempimg(:);
            n = n+1;
        end
    end
        temp = rgb2gray(imread('7.png'));
        testpoints(:,digitno) = temp(:);
        cd ..
end
size(testpoints)
size(inp)
inp = double(inp);
testpoints = double(testpoints);
[index] = kPCA(inp,testpoints);
size(testpoints);
size(index);
floor((index-1)/20)+1
index;
