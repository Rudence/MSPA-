% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

aw = linspace(3.305,3.44,10);
neff = [];
for a = 1:10
% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = aw(a);          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.1;        % grid size (horizontal)
dy = 0.1;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff(a)] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

fprintf(1,'neff = %.6f\n',neff);

for num = 1:nmodes 
    figure(a);
    subplot(121);
    contourmode(x,y,Hx(:,:,num));
%     [xx,yy] = meshgrid(x,y);
%     surf(xx,yy,Hx(:,:,num)')
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy(:,:,num));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

end
% Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)
% 
% [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');
% 
% fprintf(1,'neff = %.6f\n',neff);
% 
% for num = 1:nmodes
%     figure(nmodes+num);
%     subplot(121);
%     contourmode(x,y,Hx(:,:,num));
%     title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end
% 
%     subplot(122);
%     contourmode(x,y,Hy(:,:,num));
%     title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end
% 
% end
end

figure(100)
plot(1:10,neff)
title('neff')
