addpath('../RandomDigraphModels/')
nNodes = 500;
%% Statistics for Erdoes-Renyi
[nEdgesAddedER,nDiagER,nEdgesInGraphER, tToFixER] = digraphStatistics(nNodes, @(n)createErdoesRenyiGraph(n,0.02));
disp('Erdoes-Renyi finished')
%% Statistics for Watts-Strogatz
% [nEdgesAddedWS,nDiagWS, nEdgesInGraphWS, tToFixWS] = digraphStatistics(nNodes, @(n)createWattsStrogatzGraph(n,10,0.001));
% disp('Watts-Strogatz finished')
%% Statistics for Klemm-Eguilez
% [nEdgesAddedKE,nDiagKE,nEdgesInGraphKE, tToFixKE] = digraphStatistics(nNodes, @(n)createKlemmEguilezGraph(n,5,0.1));
% disp('Klemm-Eguilez finished')
%% Statistics for Barabasi-Albert
% [nEdgesAddedBA,nDiagBA, nEdgesInGraphBA, tToFixBA] = digraphStatistics(nNodes, @(n)createBarabasiAlbertGraph(n,10,10));
% disp('Barabasi-Albert finished.')

%% Function to create the statistics
function [nEdgesAdded, nNotDiad,nEdgesInGraph, tToFix] = digraphStatistics(nNodes, randomGenerator)
    nEdgesAdded = [];
    nNotDiad = [];
    nEdgesInGraph = [];
    nIts = 100; 
    tToFix = [];
    for it = 1:nIts
        A = randomGenerator(nNodes);
        nEdgesInGraph = [nEdgesInGraph, sum(sum(A))];
        tic;
        [~,B] = destroyJordanBlocks(A);
        tToFix = [tToFix, toc];
        edgesAdded = sum(sum(B));
        nEdgesAdded = [nEdgesAdded, edgesAdded];
        if edgesAdded > 0
            nNotDiad = nNotDiad + 1;
        end
    end
end