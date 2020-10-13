function [laplacian] = graphLaplacian(A)
%GRAPHLAPLACIAN Calculates the graph Laplacian
inDeg = sum(A,1);
laplacian = diag(inDeg) - A;
end

