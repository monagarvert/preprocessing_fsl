subj = 1;
session = 3;
run = 4;            % Change run!

% Change BOLD
% Change MR 
hdr = dicominfo(['/vols/Data/MRdata/mgarvert/F3T_2017_008_00',num2str(session+1),'/bold_mbep2d_MB3P2_TE20_TR1235_11_212/MR.1.3.12.2.1107.5.2.43.66050.2017071215074523948061634'])
st = hdr.Private_0019_1029;

figure; plot(st)

fid=fopen(['/vols/Scratch/mgarvert/ManyMaps/imagingData/Subj_',num2str(subj),'/session_',num2str(session),'/scripts/sliceOrder',num2str(run),'.txt'],'w');
fprintf(fid, '%f\n', st');
fclose(fid);

