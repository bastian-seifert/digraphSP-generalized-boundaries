function [adj] = createErdoesRenyiGraph(nNodes,pSuccess)
    function [adj] = createErdoesRenyiAdjacency()        
        adj = sparse(binornd(1,pSuccess,[nNodes nNodes]));
        %remove self-loops
        adj(1:1+size(adj):end) = 0;
    end
    adj = createErdoesRenyiAdjacency();
    % if the number of edges allows the graph to be connected,
    % we always return a connected graph
    while ~graphConnected(adj)
        adj = createErdoesRenyiAdjacency();
    end
end

