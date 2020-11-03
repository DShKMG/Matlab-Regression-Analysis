% clc
% clear
EndLen = 200;
KapName = "kap_4";
% Only Change Above
  % Used Formula F(x) = p1*x + p2
% Do not Change Here
pathDir = "%HOMEPATH%\Desktop\DATA\RAWDATA\Pexit\"
fullPath = pathDir+KapName;
cd(fullPath)
Veriler = ls("FIT*");
Veriler = string(Veriler);
A = zeros(1,length(Veriler));
B = zeros(1,length(Veriler));
ApproxDat = zeros(1,length(Veriler));
Result = ApproxDat;
VeriAdlari = transpose(Veriler);
for i=1:length(Veriler)
    Table = readtable(char(Veriler(i)));
    for j=1:5
        A(j,i) = Table.a(j);
        B(j,i) = Table.b(j);
        Result(j,i) = Table.sonuc(j);
        ApproxDat(j,i) = (Table.a(j)*EndLen)+Table.b(j);
    end
end
a = transpose(A);b = transpose(B);result = transpose(Result);ApproxDat = transpose(ApproxDat);
exitPTabl = table(Veriler,a,b,result,ApproxDat);
writetable(exitPTabl,KapName+'_Pexit.xlsx');
writetable(exitPTabl,KapName+'_Pexit.dat');