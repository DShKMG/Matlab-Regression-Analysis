clc
clear
cd("%HOMEPATH%\Desktop\DATA\RAWDATA") 
mainFolder = cd;
cd(mainFolder)
GaugetoPressure = 100000;
CapName = "kap_4";% Change Only Capillary name from here
VeriAdlari = ls(CapName+"*"+"pokus*"); 
VeriAdlari = string(VeriAdlari);
for isim=1:length(VeriAdlari)
% %     fprintf("%d - %s \n",i,VeriAdlari(i));
% % fprintf("Please select a Capillary Data : ")
% % datChoosen = input("\n");
fileID = VeriAdlari(isim);
ProcessFold = cd;
% Table Reading and Assingning the values %
Table = readtable(char(VeriAdlari(isim)));
Time = Table.Var1;
P1 = Table.Var2;
P2 = Table.Var3;
P3 = Table.Var4;
P4 = Table.Var5;
P5 = Table.Var6;
x = Table.Var8;
tArr = 1:length(Time);                                    % Range 2754+3549
% Table Reading and Assingning the values %
plot(tArr,P1,tArr,P2,tArr,P3,tArr,P4,tArr,P5);
filtS = input('Filter Start Point :');
filtE = input('Filter End Point :');
% Table Filtering and Re-Assingning the values %
% Table Filtering and Re-Assingning the values %
PTOTAL = [P1*GaugetoPressure P2*GaugetoPressure P3*GaugetoPressure P4*GaugetoPressure P5*GaugetoPressure];
rangeDiv = floor(abs(filtE-filtS)/5);
G = zeros(1,5); % Pre Allocation
for j=1:5
    G(j) = filtS + (j*rangeDiv);
    %Disp(j) = x(G(j));
end
Distance = [35 70 105 140 165]; % P6 to P1 Find X at 175
Disp = zeros(5,5);
DispT = Disp;
Gamma = zeros(5,5);
TransGamma = zeros(5,5);
for j=1:5 % Row Number
    for k=1:5 % Colomn Number
        Disp(j,k) = Distance(j);
        DispT(j,k) = Distance(k);
        TransGamma(j,k) = PTOTAL(G(j),k); % Will write it in the colomn
        %Gamma(j,k) = PTOTAL(G(7-j),k); % In Case
        % PTOTAL has values in the Rows and indices in colomn
        % Normally it starts from P1 by PTOTAL(G(j),k); Command
        % But since Skocilas demanded from high pressure to low
        % We have to use PTOTAL(G(7-j),k);
    end
end      
% Swapping The Function to Low To High %
for i=1:5
    for j=1:5
        Gamma(i,j) = TransGamma(i,6-j);
    end
end
tGamma = transpose(Gamma);
Transdist = transpose(Distance);
% Swapping The Function to Low To High %
mkdir 'Pexit'
cd('Pexit')
% RAW PLOT STARTED %
plot(Transdist,tGamma,'b.') % Draws The Trendline
title('Pressure - Displacement')
xlabel('X - Displacement');
ylabel('DeltaP - Pressure');
savefig("Pexit"+fileID+"_raw");
% RAW PLOT ENDED %
% FIT AND PLOT VALUES FOR FIT
[F5,V5] = fit(Transdist,tGamma(:,5),'poly1');
[F4,V4] = fit(Transdist,tGamma(:,4),'poly1');
[F3,V3] = fit(Transdist,tGamma(:,3),'poly1');
[F2,V2] = fit(Transdist,tGamma(:,2),'poly1');
[F1,V1] = fit(Transdist,tGamma(:,1),'poly1');
% STARTED PLOTTING
plot(F5,Transdist,tGamma,'b.') % Draws The Trendline
title('Pressure - Displacement')
xlabel('X - Displacement');
ylabel('DeltaP - Pressure');
hold on
plot(F4,Transdist,tGamma,'b.')
hold on
plot(F3,Transdist,tGamma,'b.')
hold on
plot(F2,Transdist,tGamma,'b.')
hold on
plot(F1,Transdist,tGamma,'b.')
savefig("Pexit"+fileID);
hold off
% File Extension Definer
mkdir(CapName)
cd(CapName)
fileExt = ".dat";
% File Extension Definer
% Values Saver for F
FitID = "FITvals_"+fileID+fileExt;
FitValMatrix = [F1.p1,F1.p2,F1.p2+F1.p1*200;F2.p1,F2.p2,F2.p2+F2.p1*200;F3.p1,F3.p2,F3.p2+F3.p1*200;F4.p1,F4.p2,F4.p2+F4.p1*200;F5.p1,F5.p2,F5.p2+F5.p1*200];
FitOutput = array2table(FitValMatrix,'VariableNames',{'a','b','sonuc'});
writetable(FitOutput,FitID);
% Values Saver for V
AdjID = "ADJvals_"+fileID+fileExt;
AdjValMatrix = [V1.rsquare,V1.sse;V2.rsquare,V2.sse;V3.rsquare,V3.sse;V4.rsquare,V4.sse;V5.rsquare,V5.sse];
AdjOutput = array2table(AdjValMatrix,'VariableNames',{'rsquare','sse'});
writetable(AdjOutput,AdjID);
% Approximated Graph Printer %
ApproxDistance = Distance;
ApproxDistance(6) = 200;
SumAverage = 0;
for z=1:length(FitValMatrix)
    plot(ApproxDistance,FitOutput.a(z)*ApproxDistance+FitOutput.b(z));
    title('Pressure - Displacement')
    xlabel('X - Displacement');
    ylabel('DeltaP - Pressure');
    hold on
end
savefig("Pexit"+fileID+"_approxmated");
hold off
cd(ProcessFold)
end