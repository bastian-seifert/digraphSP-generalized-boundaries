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
function [fixedAdj,edgesToAdd] = destroyJordanBlocks(adjacency,varargin)
%FIXSPECTURMNUMERICAL Fixes the spectrum of adajacency
p = inputParser;
addParameter(p,'SpaceTolerance',deg2rad(1));
addParameter(p,'RankTolerance',1e-6);
parse(p,varargin{:});
tolSpace = p.Results.SpaceTolerance;
tolRank = p.Results.RankTolerance;

adjacency = full(adjacency);
[rightVecs,d,leftVecs] = eig(adjacency,'nobalance');
edgesToAdd = zeros(size(adjacency));
while rank(rightVecs,tolRank) < length(diag(d))
    [badR, badL] = findLargestBadEigenvectorsCoarse(rightVecs, leftVecs,d,'SpaceTolerance',tolSpace);
    B = findMaxEdge(badL,badR,adjacency);
    if sum(sum(B)) == 0
        disp('Oh oh');
        error('No edge to add found!')
    end
    edgesToAdd = edgesToAdd + B;
    adjacency = adjacency + B;
    [rightVecs,d,leftVecs] = eig(adjacency,'nobalance');   
    disp('Added ');
    disp(sum(sum(edgesToAdd)));    
end
fixedAdj = adjacency;
end

