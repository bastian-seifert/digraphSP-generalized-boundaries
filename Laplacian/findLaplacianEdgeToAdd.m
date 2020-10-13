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
function [B] = findLaplacianEdgeToAdd(leftEigVec,rightEigVec, laplacian)
%FINDMAXEDGE Finds the edge which corresponds to the maximal entry of u
%tensor v

%define the constraints, here we must use the vectorization approach, since
%Matlab only allows for optimization of vectors
%for this we use that y.B.x is an integer and for any set of matrices one
%has vec(A.B.C) = kron(C',A).vec(B)
%create constraints matrix
[~,indCol] = sort(abs(rightEigVec(:,1)), 'descend');
[~,indRow] = sort(abs(leftEigVec(:,1)), 'descend');
[r,c] = find(~laplacian(indRow,indCol) & (rightEigVec(indRow,1) ~= rightEigVec(indCol,1)),1);
if isempty(r)
    disp('There is no edge, which can be added!');
    B = zeros(size(laplacian));
    return
end
B = zeros(size(laplacian));
B(indRow(r),indCol(c)) = -1;
B(indCol(c),indCol(c)) = 1;
end

