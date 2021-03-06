% Script demonstrating usage of the cbpdnjnt function.
%
% Author: Brendt Wohlberg <brendt@lanl.gov>  Modified: 2016-07-01
%
% This file is part of the SPORCO library. Details of the copyright
% and user license can be found in the 'Copyright' and 'License' files
% distributed with the library.


% Load dictionary
load([sporco_path '/Data/ConvDict.mat']);
dmap = containers.Map(ConvDict.Label, ConvDict.Dict);
D = dmap('12x12x36');


% Load test image
s = single(stdimage('lena'))/255;
if isempty(s),
  error('Data required for demo scripts has not been installed.');
end

% Highpass filter test image
npd = 16;
fltlmbd = 5;
[sl, sh] = lowpass(s, fltlmbd, npd);

% Compute representation
lambda = 1e-2;
mu = 1e-3;
opt = [];
opt.Verbose = 1;
opt.MaxMainIter = 500;
opt.rho = 100*lambda + 1;
opt.RelStopTol = 1e-3;
opt.AuxVarObj = 0;
opt.HighMemSolve = 1;
[X, optinf] = cbpdnjnt(D, sh, lambda, mu, opt);

% Compute reconstruction
DX = squeeze(ifft2(sum(bsxfun(@times, fft2(D, size(X,1), ...
             size(X, 2)), fft2(X)),3), 'symmetric'));


figure;
subplot(1,3,1);
plot(optinf.itstat(:,2));
xlabel('Iterations');
ylabel('Functional value');
subplot(1,3,2);
semilogy(optinf.itstat(:,6));
xlabel('Iterations');
ylabel('Primal residual');
subplot(1,3,3);
semilogy(optinf.itstat(:,7));
xlabel('Iterations');
ylabel('Dual residual');


figure;
imagesc(squeeze(sum(abs(X),3)));
title('Sum of absolute value of coefficient maps');


figure;
subplot(1,3,1);
imdisp(s);
title('Original image');
subplot(1,3,2);
imdisp(DX + sl);
title(sprintf('Reconstructed image (SNR: %.2fdB)', snr(s, DX + sl)));
subplot(1,3,3);
sdf = DX + sl - s;
sdf = sdf - min(sdf(:));
sdf = sdf / max(sdf(:));
imagesc(sdf);
axis image; axis off;
title('Difference');
