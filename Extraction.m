%% Individial Project - Shashank Iyengar (M12934513)
% CMIF Determination

close all
clear all
clc
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 15)
set(0,'defaultlinelinewidth',1)
set(0,'DefaultLineMarkerSize', 6)
set(0,'defaultAxesFontWeight','bold')

load('Rotor2019Data.mat')

%% Data extraction
n = 9;
for p=1:20
    for q=1:20
        H(p,q,:) = UFCELLS{n,1}.DataValues;
        n=n+1;
    end
end

%% CMIF based on all three column of FRF
A2 = zeros(20,20);
for tx = 1:20
    for cnt=1:512
        A2(:,:) = H(:,:,cnt);
        [U2, S2, V2] = svd(A2,'econ');
        singularval2(:,:,cnt) = S2;
    end
end

figure(1)
for cnt1=1:20
    semilogy((0:511)*0.1566,squeeze(singularval2(cnt1,cnt1,:)))
    hold on
end
title('CMIF of FRF matrix')
xlabel(['$ Frequency\;\mathrm{[Hz]} $'],'interpreter','latex')
ylabel(['$ |(H(\omega))|\;\mathrm{} $'],'interpreter','latex')
grid on