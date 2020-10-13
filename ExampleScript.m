%% prepare USA graph
fid = fopen('data/directedContiguousUSA.dat');
C = textscan(fid,'%s%s');
fclose(fid);
G = digraph(C{1},C{2});
A = adjacency(G);

%% Examples for the adjacency matrix
addpath('Adjacency')
[ANoJordanBlocks, NewEdges] = destroyJordanBlocks(A);
%plot the new edges
plotModifiedGraph(A,NewEdges)

%% same thing but with the sparse algorithm to kill all zeros
% [ANoZeroEigenvalue, NewEdgesNoZeros] = destroyZeroEigenvalues(A);
% plotModifiedGraph(A,NewEdgesNoZeros)


%% Examples for the Laplacian matrix
% addpath('Laplacian')
% L = graphLaplacian(A);
% [LNoJordanBlocks, NewEdgesLaplacian] = destroyLaplacianJordanBlocks(L);
% %plot the new edges
% NewEdgesL = -NewEdgesLaplacian;
% NewEdgesL(NewEdgesL == -1) = 0;
% plotModifiedGraph(A,NewEdgesL)