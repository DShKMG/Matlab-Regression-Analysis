clc
clear
mainFolder = cd("%HOMEPATH%\Desktop\DATA\YENI VERILER\Extracts");
cd(mainFolder)
cd("kap4\Evo")
currentFolder = cd;
Filelist = dir('*_details.dat');
ListVal = rand(1,11);
for i=1:length(Filelist)
    Tables = readtable(Filelist(i).name);
    RSqVal = Tables.RSquared;
    ListVal(i) = RSqVal;
end
[maxVal maxIdx] = max(ListVal);
[minVal minIdx] = min(ListVal);
fprintf('\nMaximum Value is %f and Filename =  "%s"\n',maxVal,Filelist(maxIdx).name);
fprintf('\nMinimum Value is %f and Filename =  "%s"\n',minVal,Filelist(minIdx).name);