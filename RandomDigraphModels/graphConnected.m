function [isConnected] = graphConnected(adj)
bins = conncomp(digraph(adj), 'Type', 'weak');
isConnected = all(bins == 1);
end

