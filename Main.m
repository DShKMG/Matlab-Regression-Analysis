clc
clear
%This will make Displacement Stay Always in the 8th row
mainFolder = cd("%HOMEPATH%\Desktop\DATA");
cd(mainFolder)
Filelist = dir("kap2/*pokus*.dat"); % Filter Range 7581-7587 % Current Used Filter is = 1957 2067
cd("kap2")
% Get the Values For the Names of the File %
% VeriAdlari = ls("*pokus*.dat"); VeriAdlari = string(VeriAdlari);
% ExperimentDataNames = table(VeriAdlari,'VariableNames',{'n'});
% Get the Values For the Names of the File %
mkdir Evo;
currentFolder = cd;
height = 0.002; % height in [meters]
b = 0.02; % width in [meters]
len = 0.15; %Length in [meters]
% Pre-allocating the array %
sizeMaxLen = length(Filelist);
Filedirs = zeros(1,sizeMaxLen);
% Pre-allocating the array %
for i=1:length(Filelist) %length(Filelist)
    Tables = readtable(Filelist(i).name);
    Time = Tables.t; % Time
    PressureF = Tables.p1*100000; % Pressure 1
    PressureS = Tables.p2*100000; % Pressure 2
    Displacement = Tables.h/1000; % Displacement
    TimeArr = 1:length(Time); % To Find Index Faster
    plot(TimeArr,PressureF,'b-',TimeArr,PressureS,'r-')
    filtStart = input('Filter Start Point :');
    filtEnd = input('Filter End Point :');
    % Applying Range Filtration %
    Time = Time(filtStart:filtEnd);
    PressureF = PressureF(filtStart:filtEnd);
    PressureS = PressureS(filtStart:filtEnd);
    Displacement = Displacement(filtStart:filtEnd);
    % Applying -END- Filtration -END- %
    pfinal = abs(PressureS-PressureF);
    % Go Back to main folder Apply functions %
    cd(mainFolder); 
    velocity = Derivator(Time,Displacement);
    golayFitFrameLength = round_odd(abs(filtEnd-filtStart));
    pfinal = sgolayfilt(pfinal,2,golayFitFrameLength);
    Displacement = sgolayfilt(Displacement,2,golayFitFrameLength);
    velocity = sgolayfilt(velocity,2,golayFitFrameLength);
    % Go Back to main folder Apply functions %
    cd(currentFolder) % Move To File Application Folder
    plot(Time,pfinal);
    plot(Time,Displacement);
    % Saving Output Data %
    %OutputDataAll = [time,disp,pfinal,p1,p2]; % OutputData as All
    %unnecessary forms
    directory = 'Evo/'
    filei= char(string(i));
    extension = '.dat'
    %FinalData Initialization
    SurfacePiston = (power(0.08,2)*pi)/4;
    Volflow = SurfacePiston*velocity; % Getting volume flow rate
    tau = (pfinal*height)/(2*len) ; % Shear Stress
    gamma = (6*Volflow)/(b*power(height,2));
    gamma = transpose(gamma);
    [f,v]= fit(gamma,tau,'a*x^b+c'); % Hershel Bulkley Fluid
    [g,n]= fit(gamma,tau,'a*x^b'); % Power Law Mmodel
    plot(f,gamma,tau);
    [Gval Gpos] = max(gamma);
    [GvalMin GposMin] = min(gamma);
    figExt = '.fig';
    %figName = [directory filei figExt];
    figName = filei;
    savefig(figName);
    % HB MODEL %
    HBExt = '_HBModel';
    HBId = [directory filei HBExt extension];
    HershelBulkleyData = [f.a,f.b,f.c,v.sse,v.rsquare,v.adjrsquare,v.rmse,Gval,Gpos,GvalMin,GposMin,filtEnd,filtStart];
    OutputHBModel = array2table(HershelBulkleyData,'VariableNames',{'A','B','C','SumSquareErr','RoundSquare','AdjecentSquare','RMSErr','MaxGamma','MaxGammaPosition','MinGamma','MinGammaPosition','FilterStart','FilterEnd'});
    writetable(OutputHBModel,HBId); 
    % PowerLaw MODEL %
    PLExt = '_PLModel';
    PLId = [directory filei PLExt extension];
    PowerLawData = [g.a,g.b,n.sse,n.rsquare,n.adjrsquare,n.rmse,Gval,Gpos,GvalMin,GposMin,filtEnd,filtStart];
    OutputPLModel = array2table(PowerLawData,'VariableNames',{'A','B','SumSquareErr','RoundSquare','AdjecentSquare','RMSErr','MaxGamma','MaxGammaPosition','MinGamma','MinGammaPosition','FilterStart','FilterEnd'});
    writetable(OutputPLModel,PLId);
    % Raw Data Save Start %
    velconv = transpose(velocity);
    Rawfilename = [directory filei '_raw' extension];
    OutputData = [Time,velconv,pfinal,gamma,tau];
    OutputTable = array2table(OutputData,'VariableNames',{'Time','Velocity','Pressure','Gamma','Tau'});
    writetable(OutputTable,Rawfilename); % Verilerin ciktisi
    % Raw Data Save End %
end
cd(mainFolder)
% writetable(ExperimentDataNames,'Fnames.dat'); Unused due to function is
% implemented on VeriToplayici
fprintf("\nProcess is completed !\n");
%After showing to skocilas erase p1 and p2 and just make final P form and
%use data from it !!!!