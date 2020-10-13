function [adj] = createKlemmEguilezGraph(nNodes,sizeSeed,probConnectNonactive)
    function [adj] = createKlemmEguilez()
        adj = sparse(nNodes,nNodes);
        activeNodes = zeros(nNodes,1);
        deactivatedNodes = zeros(nNodes,1);
        nodeDegree = zeros(nNodes,1);
        %create fully connected initial network
        for i = 1:sizeSeed
            activeNodes(i) = 1;
            for j = i+1:sizeSeed
                adj(i,j) = 1;
                adj(j,i) = 1;
                nodeDegree(i) = nodeDegree(i) + 1;
                nodeDegree(j) = nodeDegree(j) + 1;
            end
        end
        %connect remaining nodes
        for i = sizeSeed+1:nNodes
            for j = find(activeNodes)
                if (probConnectNonactive > rand()) || (sum(deactivatedNodes) == 0)
                    adj(i,j) = 1;
                    adj(j,i) = 1;
                    nodeDegree(i) = nodeDegree(i) + 1;
                    nodeDegree(j) = nodeDegree(j) + 1;
                else
                    connected = false;
                    while ~connected
                        j = randsample(find(deactivatedNodes),1);
                        sumDegreeAllDeactivatedNodes = sum(nodeDegree(find(deactivatedNodes)));
                        if nodeDegree(j)/sumDegreeAllDeactivatedNodes > rand()
                            adj(i,j) = 1;
                            adj(j,i) = 1;
                            nodeDegree(i) = nodeDegree(i) + 1;
                            nodeDegree(j) = nodeDegree(j) + 1;
                            connected = true;
                        end
                    end
                end
            end
            activeNodes(i) = 1;
            removedNode = false;
            while ~removedNode
                j = randsample(find(activeNodes),1);
                probDeactivation = (1/nodeDegree(j)) / sum(1./nodeDegree(find(nodeDegree)));
                if probDeactivation > rand()
                    activeNodes(j) = 0;
                    removedNode = true;
                end
            end            
        end
        for i = 1:nNodes
            for j = find(adj(i,:))
                if probConnectNonactive > rand() && (length(find(adj(i,:))) ~= nNodes-1)
                    h = randsample(1:nNodes,1);
                    while (h == i) || (ismember(h,find(adj(i,:))))
                        h = randsample(1:nNodes,1);
                    end
                    adj(i,j) = 0;
                    adj(i,h) = 1;
                end
            end
        end
    end
    adj = createKlemmEguilez();
    % if the number of edges allows the graph to be connected,
    % we always return a connected graph
    while ~graphConnected(adj)
        adj = createKlemmEguilez();
    end
end

