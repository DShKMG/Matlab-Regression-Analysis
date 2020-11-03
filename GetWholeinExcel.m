clc
clear
mainFolder = cd("%HOMEPATH%\Desktop\DATA");
cd(mainFolder)
KapName = "kap8";
cd(KapName);
% Here input Name of the Datas and save it as array %
VeriAdlari = ls("*pokus*.dat");
VeriAdlari = string(VeriAdlari);
% Here input Name of the Datas and save it as array %
cd('Evo/');
PLModel = dir('*PLModel.dat');
HBModel = dir('*HBModel.dat');
for i=1:size(PLModel)
    Filename = PLModel(i).name;
    % https://www.mathworks.com/help/matlab/ref/table.html
    % Arrays will create Colomns which will add into the Tables 
    % The String inputs must be in cell format . Ex. A = {'A','B'};
    Table = readtable(Filename);
    A(i) = Table.A;
    B(i) = Table.B;
    GammaMax(i) = Table.MaxGamma;
    GammaMin(i) = Table.MinGamma;
    GoodnessVal(i) = Table.RoundSquare;
    Nr(i) = i;
end
A = transpose(A);B = transpose(B); GammaMax = transpose(GammaMax);GammaMin = transpose(GammaMin);GoodnessVal = transpose(GoodnessVal);Nr = transpose(Nr);
extPLmodel = table(VeriAdlari,A,B,GammaMax,GammaMin,GoodnessVal);
for i=1:size(HBModel)
    Filename = HBModel(i).name;
    % https://www.mathworks.com/help/matlab/ref/table.html
    % Arrays will create Colomns which will add into the Tables 
    % The String inputs must be in cell format . Ex. A = {'A','B'};
    Table = readtable(Filename);
    A(i) = Table.A;
    B(i) = Table.B;
    C(i) = Table.C;
    GammaMax(i) = Table.MaxGamma;
    GammaMin(i) = Table.MinGamma;
    GoodnessVal(i) = Table.RoundSquare;
    Nr(i) = i;
end
%A = transpose(A);B = transpose(B); Gamma = transpose(Gamma);GoodnessVal = transpose(GoodnessVal);Nr = transpose(Nr);
C = transpose(C);
extHBmodel = table(VeriAdlari,A,B,C,GammaMax,GammaMin,GoodnessVal);
writetable(extPLmodel,'PowerLawSum.dat');
writetable(extHBmodel,'HerschelBulkleySum.dat');
writetable(extPLmodel,'PowerLawExcel.xlsx');
writetable(extHBmodel,'HerschelBulkleyExcel.xlsx');