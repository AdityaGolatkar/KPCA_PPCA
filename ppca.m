function [] = ppca_EA(inp,testpoints)
d = size(inp,1);		%the dimension of the observations.
q = 20;					%the dimension of the latent variables i.e. the desired dimension to which we want reduce our data.
sigma_sq = 1;				%sigma of the epsilon in the gaussian model.
N = size(inp,2);		%this is the number of observations
mu = mean(inp,2);		%computing the mean of the observations.
inp_mu = bsxfun(@minus,inp,mu);		%getting the mean centered observations.
S = (inp_mu*(inp_mu'))/N;			%computing the S matrix.
W = ones(d,q);						%it can be defined to any thing .
I = eye(q);							%identity matrix of dimension qxq
M = W'*W + I*(sigma_sq);		%computing the M matrix.
M_inv = inv(M);						%computing the inverse of M.
W_old = W;
sigma_sq_old = sigma_sq;


while true
	temp = I*(sigma_sq_old) + M_inv*(W')*S*W;
	temp_inv = inv(temp);
	W_new = S*W*temp_inv;

	temp1 = S - S*W_old*M_inv*(W_new');
	sigma_sq_new = trace(temp1)/d;

	diff = W_new-W_old;
	sqdiff = diff.*diff;
	ssd = sum(sqdiff);
	ssd = sum(ssd);

	if ((ssd < 0.001) && (abs(sigma_sq_new-sigma_sq_old) < 0.001))
		break;
	end 

	W_old = W_new;
	sigma_sq_old = sigma_sq_new;
end

inp_pc = M_inv*(W_new')*inp_mu;

tp_pc = zeros(q,size(testpoints,2));
tps = size(testpoints,2);
for i =1:tps
	tp_pc(:,i) = M_inv*(W_new')*(testpoints(:,i)-mu);
end

match = zeros(size(testpoints));
for i=1:tps
	diff1 = bsxfun(@minus,inp_pc,tp_pc(:,i));
	diff1 = diff1.*diff1;
	ssd1 = sum(diff1,1);
	[mini ind] = min(ssd1(:));
	match(:,i) = inp(:,ind);
end
match
