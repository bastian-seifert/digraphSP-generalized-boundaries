function [adj] = createWattsStrogatzGraph(nNodes,nEdges,pRewiring)
    function [adj] = createWattsStrogatzAdjacency()        
        % Connect each node to its K next and previous neighbors. This constructs
        % indices for a ring lattice.
        s = repelem((1:nNodes)',1,nEdges);
        t = s + repmat(1:nEdges,nNodes,1);
        t = mod(t-1,nNodes)+1;

        % Rewire the target node of each edge with probability beta
        for source=1:nNodes    
            	switchEdge = rand(nEdges, 1) < pRewiring;
                newTargets = rand(nNodes, 1);
                newTargets(source) = 0;
                newTargets(s(t==source)) = 0;
                newTargets(t(source, ~switchEdge)) = 0;
    
                [~, ind] = sort(newTargets, 'descend');
                t(source, switchEdge) = ind(1:nnz(switchEdge));
        end
        adj = adjacency(digraph(s,t));
        %remove self-loops
        adj(1:1+size(adj):end) = 0;
    end
    adj = createWattsStrogatzAdjacency();
    % if the number of edges allows the graph to be connected,
    % we always return a connected graph
    while ~graphConnected(adj)
        adj = createWattsStrogatzAdjacency();
    end
end

