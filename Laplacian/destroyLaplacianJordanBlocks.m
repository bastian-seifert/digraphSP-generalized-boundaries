% ----------------------------------------------------------------------- %
%   Versions:                                                             %
%       - v1.0.:    (13/10/2020)                                          %
% ----------------------------------------------------------------------- %
%       - Author:   Bastian Seifert                                       %
%       - Date:     13/10/2020                                            %
%       - Version:  1.0                                                   %
%       - E-mail:   bastian.seifert (at) inf.ethz.ch                      %
%                                                                         %
%       Advanced Computing Laboratory                                     %  
%       Department of Computer Science, ETH Zurich, Switzerland           %
% ----------------------------------------------------------------------- %
function [fixedAdj,edgesToAdd] = destroyLaplacianJordanBlocks(laplacian,varargin)
%FIXSPECTURMNUMERICAL Fixes the spectrum of adajacency
p = inputParser;
addParameter(p,'SpaceTolerance',deg2rad(1));
addParameter(p,'RankTolerance',1e-6);
parse(p,varargin{:});
tolSpace = p.Results.SpaceTolerance;
tolRank = p.Results.RankTolerance;

laplacian = full(laplacian);
[rightVecs,d,leftVecs] = eig(laplacian,'nobalance');
edgesToAdd = zeros(size(laplacian));
c = 0;
while rank(rightVecs,tolRank) < length(diag(d))
    [badR, badL] = findLargestBadEigenvectorsCoarse(rightVecs, leftVecs,d,'SpaceTolerance',tolSpace);
    B = findLaplacianEdgeToAdd(badL,badR,laplacian);
    if sum(sum(B-diag(B))) == 0
        disp('Oh oh');
        error('No edge to add found!')
    end
    edgesToAdd = edgesToAdd + B;
    laplacian = laplacian + B;
    [rightVecs,d,leftVecs] = eig(laplacian,'nobalance');   
    disp('Added ');
    c = c +1;
    disp(c);  
end
fixedAdj = laplacian;
end

