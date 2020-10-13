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
function [badRight,badLeft] = findLargestBadEigenvectorsCoarse(rightEigvecs,leftEigvecs,eigVals,varargin)
%FINDBADEIGENVECTOR Finds the most bad behaving eigenvector
p = inputParser;
addParameter(p,'SpaceTolerance',1e-2);
parse(p,varargin{:});
tolSpace = p.Results.SpaceTolerance;
pairDists = acos(abs(rightEigvecs'*rightEigvecs));
pairDists(1:1+size(pairDists,1):end) = 0;
[~,badIdx] =max(arrayfun(@(x)length(find(pairDists(x,:)<tolSpace)), 1:length(eigVals)));
badRight = rightEigvecs(:,badIdx(1));
badLeft = leftEigvecs(:,badIdx(1));
end

