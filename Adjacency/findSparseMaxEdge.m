function [B] = findSparseMaxEdge(leftEigVec, rightEigVec, adjacency)
%FINDMAXEDGE Finds the edge which corresponds to the maximal entry of u
%tensor v

%define the constraints, here we must use the vectorization approach, since
%Matlab only allows for optimization of vectors
%for this we use that y.B.x is an integer and for any set of matrices one
%has vec(A.B.C) = kron(C',A).vec(B)
%create constraints matrix
[~,indCol] = sort(abs(rightEigVec(:,1)), 'descend');
[~,indRow] = sort(abs(leftEigVec(:,1)), 'descend');
[r,c] = find(~adjacency(indRow,indCol),1);
if isempty(r)
    disp('There is no edge, which can be added!');
    B = sparse(size(adjacency,1),size(adjacency,1));
    return
end
B = sparse(size(adjacency,1),size(adjacency,1));
B(indRow(r),indCol(c)) = 1;
end

