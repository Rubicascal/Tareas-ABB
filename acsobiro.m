function [H,S,D]=acsobiro(X,n,p), 
% Program implemented and improved by A. Cichocki 
% on basis of the classical SOBI algorithm of Belouchrani. 
% Attention for noisy data you should take at least  
% 100 the time-delayed covariance matrices. 
% Robust Second Order Blind Identification SOBI-RO 
% (c)  
% This function was created on the basis of publications  
% of Belouchrani et al., F. Cardoso et al., 
% A. Belouchrani - A. Cichocki, S. Choi - A. Cichocki,  
% S. Cruces, A. Cichocki- S. Amari and P. Georgiev-A. Cichocki. 
% 
%************************************************** 
% Blind identification by joint diagonalization   * 
% of the time-delayed covariance matrices.        * 
%                       			              * 
% ------------------------------------------------* 
% THIS CODE ASSUMES TEMPORALLY CORRELATED SIGNALS * 
%                                                 *  
%************************************************** 
% 
% [H,S]=acsobiro(X,n,p) produces a mixing matrix H of dimension [n by m]  
% and a source signals matrix S of dimension [n by  N] or [m by N].  
% Note:  
% > X: Data matrix X of dimension m by N representing sensor (observed) signals, 
% > m: sensor number, 
% > n: source number by default m=n, 
% > N: sample number, 
% > p: number of the time delay covriance matrices to be diagonalized by default p=100. 
% 
% REFERENCES: 
%  A. Belouchrani, K. Abed-Meraim, J.-F. Cardoso, and E. Moulines, ``Second-order 
%  blind separation of temporally correlated sources,'' in Proc. Int. Conf. on 
%  Digital Sig. Proc., (Cyprus), pp. 346--351, 1993. 
% 
%  A. Belouchrani, and A. Cichocki,  
%  Robust whitening procedure in blind source separation context,  
%  Electronics Letters, Vol. 36, No. 24, 2000, pp. 2050-2053. 
%   
%  A. Cichocki and S. Amari,  
%  Adaptive Blind Signal and Image Processing, Wiley,  2002. 
% 
 [m,N]=size(X); 
if nargin==1, 
   n=m;  
   p=100; % The number of the time delayed covariance matrices to be diagonalized  
end; 
if nargin==2, 
   p=100 ;  
end;  
X=X-(mean(X')'*ones(1,N)); %Removing  mean value 
Rxx=(X(:,1:N-1)*X(:,2:N)')/(N-1); %Estimation of sample covariance matrix  
%for the time delay p=1 in order to reduce influence of a white noise. 
% 
 [Ux,Dx,Vx]=svd(Rxx); 
 Dx=diag(Dx); 
% n=11; 
 if n<m, % under assumption of additive white noise and 
        %when the number of sources are known or can a priori estimated 
  Dx=Dx-real((mean(Dx(n+1:m)))); 
  Q= diag(real(sqrt(1./Dx(1:n))))*Ux(:,1:n)'; 
else    % under assumption of no additive noise and when the  
        % number of sources is unknown 
   n=max(find(Dx>1e-99)); %Detection the number of sources 
   Q= diag(real(sqrt(1./Dx(1:n))))*Ux(:,1:n)'; 
end; 
Xb=Q*X; % prewhitened data 
% Estimation of the time delayed covariance matrices: 
k=1; 
pn=p*n;  
for u=1:n:pn, k=k+1; Rxp=Xb(:,k:N)*Xb(:,1:N-k+1)'/(N-k+1); 
    M(:,u:u+n-1)=norm(Rxp,'fro')*Rxp;  
end; 
% Approximate joint diagonalization: 
eps=1/sqrt(N)/100; encore=1; U=eye(n); 
while encore, encore=0; 
 for p=1:n-1, 
  for q=p+1:n, 
    % Givens rotations: 
    g=[ M(p,p:n:pn)-M(q,q:n:pn)  ; 
        M(p,q:n:pn)+M(q,p:n:pn)  ; 
        i*(M(q,p:n:pn)-M(p,q:n:pn))]; 
   [Ucp,D] = eig(real(g*g')); [la,K]=sort(diag(D)); 
   angles=Ucp(:,K(3));angles=sign(angles(1))*angles; 
   c=sqrt(0.5+angles(1)/2); 
   sr=0.5*(angles(2)-j*angles(3))/c; sc=conj(sr); 
   asr = abs(sr)>eps ; 
   encore=encore | asr ; 
   if asr , %U pdate of the M and U matrices:  
     colp=M(:,p:n:pn);colq=M(:,q:n:pn); 
     M(:,p:n:pn)=c*colp+sr*colq;M(:,q:n:pn)=c*colq-sc*colp; 
     rowp=M(p,:);rowq=M(q,:); 
     M(p,:)=c*rowp+sc*rowq;M(q,:)=c*rowq-sr*rowp; 
     temp=U(:,p); 
     U(:,p)=c*U(:,p)+sr*U(:,q);U(:,q)=c*U(:,q)-sc*temp; 
   end  %% if 
  end  %% q loop 
 end  %% p loop 
end  %% while 
% Estimation of the mixing matrix H and the sources S: 
H= pinv(Q)*U(1:n,1:n); S=[]; 
% 
%W=U(1:n,1:n)'*Q; S= W*X; 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% [m,N]=size(X); 
% if nargin==1, 
%  n=m; % source detection  
% % 
%  p=100; % number of correlation matrices to be diagonalized  
%  end; 
% if nargin==2, 
%  p=100 ; % number of correlation matrices to be diagonalized 
% end;  
% pm=p*m; % for convenience 
%  
% X=X-(mean(X')'*ones(1,N)); %removing  mean value 
%  Rx=(X(:,1:N-1)*X(:,2:N)')/(N-1); 
%   %Rx=X*X'/N; 
%   %[U,D,V]=svd(Rx+eye(m)); 
%   %D=diag(D)-1;  
%   %n=max(find(D>1e-99)); 
%   %sigma=(1e-99)*min(D); 
%   %BL=(U(:,1:n)*diag(real(sqrt(1./(D(1:n)+sigma./D(1:n))))))';  
%   %IBL=pinv(BL); 
% %%%% whitening 
% % Rx=(X*X')/N; 
% if m<n, %assumes white noise 
%   [U,D]=eig(Rx); [puiss,k]=sort(diag(D)); 
%   ibl= sqrt(puiss(n-m+1:n)-mean(puiss(1:n-m))); 
%  bl = ones(m,1) ./ ibl ; 
%   Q=diag(bl)*U(1:n,k(n-m+1:n))'; 
%   IQ=U(1:n,k(n-m+1:n))*diag(ibl); 
% else    %assumes no noise 
%    IQ=sqrtm(Rx); 
%    Q=inv(IQ); 
% end; 
% X=Q*X; 
%  
% %%%correlation matrices estimation 
% k=1; 
% for u=1:m:pm, k=k+1; Rxp=X(:,k:N)*X(:,1:N-k+1)'/(N-k+1); 
%     M(:,u:u+m-1)=norm(Rxp,'fro')*Rxp;  
% end; 
% %%%joint diagonalization 
% seuil=1/sqrt(N)/100; encore=1; V=eye(m); 
% while encore, encore=0; 
%  for p=1:m-1, 
%   for q=p+1:m, 
%    %%% Givens rotations 
%    g=[   M(p,p:m:pm)-M(q,q:m:pm)  ; 
%          M(p,q:m:pm)+M(q,p:m:pm)  ; 
%       i*(M(q,p:m:pm)-M(p,q:m:pm)) ]; 
% 	  [vcp,D] = eig(real(g*g')); [la,K]=sort(diag(D)); 
%    angles=vcp(:,K(3));angles=sign(angles(1))*angles; 
%    c=sqrt(0.5+angles(1)/2); 
%    sr=0.5*(angles(2)-j*angles(3))/c; sc=conj(sr); 
%    oui = abs(sr)>seuil ; 
%    encore=encore | oui ; 
%    if oui , %%%updMte of the M and V matrices  
%     colp=M(:,p:m:pm);colq=M(:,q:m:pm); 
%     M(:,p:m:pm)=c*colp+sr*colq;M(:,q:m:pm)=c*colq-sc*colp; 
%     rowp=M(p,:);rowq=M(q,:); 
%     M(p,:)=c*rowp+sc*rowq;M(q,:)=c*rowq-sr*rowp; 
%     temp=V(:,p); 
%     V(:,p)=c*V(:,p)+sr*V(:,q);V(:,q)=c*V(:,q)-sc*temp; 
%    end%% if 
%   end%% q loop 
%  end%% p loop 
% end%% while 
% %%%estimation of the mixing matrix H and separating matrix W 
% H=IQ*V; %H= pinv(Q)*V; W=V'*Q 
% %W=V'*Q; % estimating separating matrix 
%  
% S=[];


