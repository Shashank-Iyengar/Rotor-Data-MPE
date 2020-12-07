%% Individial Project - Shashank Iyengar (M12934513)
% MAC Matrix Determination

close all
clear all
clc
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 15)
set(0,'defaultlinelinewidth',1)
set(0,'DefaultLineMarkerSize', 6)
set(0,'defaultAxesFontWeight','bold')

load('ModeShape.mat')

%% PTD Algorithm
n=8;
for x=1:34
    psi1(x,:) = UFCELLS{n,1}.Node;
    n=n+1;;
end
t=1;
for r=1:17
    psi2(r,:) = psi1(t,:);
    t=t+2;
end
for r=1:17
    for m=1:20
    psi(r,m) = psi2(r,m).Data(1,3);
    end
end
psi = psi';

%% MAC Matrix - PTD Algorithm

for r=1:17
    for y=1:17
        MAC1(r,y) = (psi(:,r)'*psi(:,y)*psi(:,y)'*psi(:,r))/(psi(:,r)'*psi(:,r)*psi(:,y)'*psi(:,y));
        MAC2(r,y) = real(MAC1(r,y));
        if MAC2(r,y) <= 0.001
            MAC2(r,y) = 0;
        end
    end
end
disp('Auto-MAC : PTD Algorithm')
MAC2


%% RFP-Z Algorithm
load('ModeShapeRFP.mat')
n=8;
for x=1:34
    psi11(x,:) = UFCELLS{n,1}.Node;
    n=n+1;;
end
t=1;
for r=1:17
    psi22(r,:) = psi11(t,:);
    t=t+2;
end
for r=1:17
    for m=1:20
    psirfp(r,m) = psi22(r,m).Data(1,3);
    end
end
psirfp = psirfp';

%% MAC Matrix - RFP-Z

for r=1:17
    for y=1:17
        MAC11(r,y) = (psirfp(:,r)'*psirfp(:,y)*psirfp(:,y)'*psirfp(:,r))/(psirfp(:,r)'*psirfp(:,r)*psirfp(:,y)'*psirfp(:,y));
        MAC22(r,y) = real(MAC11(r,y));
        if MAC22(r,y) <= 0.001
            MAC22(r,y) = 0;
        end
    end
end
disp('Auto-MAC : RFP-Z Algorithm')
MAC22

%% CrossMAC
for r=1:17
    for y=1:17
        CMAC1(r,y) = (psi(:,r)'*psirfp(:,y)*psirfp(:,y)'*psi(:,r))/(psi(:,r)'*psi(:,r)*psirfp(:,y)'*psirfp(:,y));
        CMAC2(r,y) = real(CMAC1(r,y));
        if CMAC2(r,y) <= 0.001
            CMAC2(r,y) = 0;
        end
    end
end
disp('Cross MAC')
CMAC2