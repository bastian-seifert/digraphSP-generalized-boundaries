function [adj] = createBarabasiAlbertGraph(nNodes,sizeSeed,averageDegree)
    function [adj] = createBarabasiAlbert()
        adj = sparse(nNodes,nNodes);
        edgeCounter = 0;
        for i=1:sizeSeed
            for j=i+1:sizeSeed
                adj(i,j) =1;
                adj(j,i) = 1;
                edgeCounter = edgeCounter + 2;
            end
        end
        % Second add remaining nodes with a preferential attachment
        % bias - rich get richer
        for i=sizeSeed+1:nNodes
            curr_deg =0;
            while(curr_deg<averageDegree)
                sample = setdiff(1:nNodes,[i find(adj(i,:))]);
                j = datasample(sample,1);
                b = sum(adj(j,:))/edgeCounter;
                r = rand(1);
                if(b>r)
                    r = rand(1);
                    if(b>r)
                        adj(i,j) = 1;
                        adj(j,i) = 1;
                        edgeCounter = edgeCounter +2;
                    else
                        adj(i,j) = 1;
                        edgeCounter = edgeCounter +1;
                    end
                else
                    no_connection = 1;
                    while(no_connection)
                        sample = setdiff(1:nNodes,[i find(adj(i,:))]);
                        h = datasample(sample,1);
                        b = sum(adj(h,:))/edgeCounter;
                        r = rand(1);
                        if(b>r)
                            r = rand(1);
                            if(b>r)
                                adj(h,i) = 1;
                                adj(i,h) = 1;
                                edgeCounter = edgeCounter +2;
                            else
                                adj(i,h) = 1;
                                edgeCounter = edgeCounter+1;
                            end
                            no_connection = 0;
                        end
                    end
                end
                curr_deg = sum(adj(i,:));
            end
        end
    end
    adj = createBarabasiAlbert();
    % if the number of edges allows the graph to be connected,
    % we always return a connected graph
    while ~graphConnected(adj)
        adj = createBarabasiAlbert();
    end
end

