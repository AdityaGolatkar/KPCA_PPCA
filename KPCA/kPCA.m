function [index] = kPCA(inp,testpoints) 	 			%inp is the input matrix. It is NxM where N is the input dimension. M is the number of observations.

%=================================================
%K computation of the original observations points
%=================================================
M = size(inp,2);                                         %Get the number of observation points.
d = 2;                                                   %d is the order of monomials we want in our PCA.				
for i=1:M;
	for j=1:M;
		%K_nc(i,j) = ((inp(:,i)')*inp(:,j))^d;           %Is a MxM matrix.K of the non centered data in F space.
        K_nc(i,j) = dot(inp(:,i),inp(:,j))^d;
    end
end
one_M = ones(M,M)/M;                                     %1_M matrix on pg.14 of the paper.	
K_c = K_nc - one_M*K_nc - K_nc*one_M + one_M*K_nc*one_M; %K matrix of the centered data in the F space.On page no 14 of the paper.
%=================================================

%========================
%Normalization of alpha's
%========================
[alpha lambda_mat] = eig(K_c);	%alpha and lambda computation.
lambda = sum(lambda_mat,1);
m = find(lambda(:)>0);
for i=1:length(m)
    %norm_coeff(i) = sqrt(lambda(m(i))*((alpha(:,m(i))')*alpha(:,m(i)))); %This is the RHS of the eq. 16 on page 3.This should be equal to 1 for getting normailzesd components.
    %norm_coeff = alpha(:,m(i))'*alpha(:,m(i));
    norm_coeff = sqrt(lambda(m(i)));
    alpha_norm(:,i) = alpha(:,m(i))/norm_coeff; %Normalizing the alpha so that eq 16 holds true.
end
%=========================
pc = zeros(length(m),M);
%==========================================
%Computing Principal Components of the data
%========================================== 
for q =1:M
	for t=1:length(m)
        pc(t,q) = (alpha_norm(:,t)')*K_c(:,q);	%pc will be a MxM matrix.
	end
end
%================================
%Computing PCs for the tetspoints
%================================
%testpoints is a MxL matrix which has l test points.
L = size(testpoints,2);

for w=1:L
	for e=1:M
		K_nc_test(w,e) = (testpoints(:,w)'*inp(:,e)).^d;  %LxM matrix.
	end
end 
one_M_1 = ones(L,M)/M;
K_c_test = K_nc_test - one_M_1*K_nc - K_nc_test*one_M + one_M_1*K_nc*one_M;

pc_test = zeros(length(m),L);
for w=1:L
	for i=1:length(m)
%    for i=1:M
        pc_test(i,w) = (alpha_norm(:,i)')*(K_c_test(w,:)');	%These are the principal components of the test points.This is thus a MxL matrix.
	end
end
%==================================

%pc_mean=zeros(length(m),26);
%for z =1:26
%    pc_mean(:,z) = mean(pc(:,9*(z-1)+1:9*z),2);
%end

%==========================================
%Finding the best match for each test point
%==========================================
size(pc);
size(pc_test(:,1));
index = zeros(1,L);
size(index);
for w=1:L
	diff = bsxfun(@minus,pc,pc_test(:,w));
	sqdiff = diff.*diff;
	ssd = sum(sqdiff,1);
	[mini,ind] = min(ssd(:));
	match(:,w) = inp(:,ind);
    index(1,w) = ind;
end
size(index);
match;