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
function [fixedAdjacency,edgesToAdd] = destroyZeroEigenvalues(adjacency,varargin)
%KILLALLZEROS Adds edges to adjacency until there is no more eigenvalue 0
p = inputParser;
addParameter(p,'EigTolerance',1e-3);
addParameter(p,'StartZero',1e-6);
parse(p,varargin{:});
tolEig = p.Results.EigTolerance;
startZero = p.Results.StartZero;

[rightVec,d] = eigs(adjacency,1,startZero);
[leftVec,~] = eigs(adjacency',1,startZero);
edgesToAdd = sparse(size(adjacency,1),size(adjacency,2));
while abs(d) < tolEig
	B = findSparseMaxEdge(leftVec,rightVec,adjacency);
    if (sum(sum(B)) == 0)
        disp('Stopping because adding edge was not possible!')
        break;
    end
    edgesToAdd = edgesToAdd + B;    
	adjacency = adjacency + B;     
    disp('Added ')
    disp(sum(sum(edgesToAdd)))
    disp('edges')
    [rightVec,d] = eigs(adjacency,1,startZero);
    [leftVec,~] = eigs(adjacency',1,startZero);
end
fixedAdjacency = adjacency;
end

