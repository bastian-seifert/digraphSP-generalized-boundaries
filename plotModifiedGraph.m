% ----------------------------------------------------------------------- %
% FUNCTION "plotModifiedGraph" plots a graph where edges have been added  %
% to destroy the Jordan blocks of it.                                     %
%                                                                         %
%   Input parameters:                                                     %
%       - oldAdjacency: The adjacency matrix of the original digraph.     %
%       - additionalEdges:  The edges, which are new.                     %
%       - varargin:     (Optional) Parameters to change Layout.           %
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
function [graphicHandle] = plotModifiedGraph(oldAdjacency, additionalEdges, varargin)
%PLOTMODIFIEDGRAPH 
p = inputParser;
addParameter(p,'ColorRange',[-1,1]);
addParameter(p,'OuterMarkerSize',5);
addParameter(p,'InnerMarkerSize',3);
addParameter(p,'Layout','auto');
addParameter(p,'XData',zeros(size(oldAdjacency)));
addParameter(p,'YData',zeros(size(oldAdjacency)));
parse(p,varargin{:});
figure;
D = digraph(oldAdjacency+additionalEdges);
if sum(p.Results.XData) ~= 0
	graphicHandle = plot(D,...
        'MarkerSize',p.Results.OuterMarkerSize,'ArrowPosition', 0.99, 'EdgeColor','black',...
        'NodeColor','black','EdgeAlpha',1, ...
        'XData',p.Results.XData,'YData',p.Results.YData);
    hold on;
    plot(D,'EdgeAlpha',0,'NodeColor','white','MarkerSize',p.Results.InnerMarkerSize,'NodeLabel',[], ...
        'XData',p.Results.XData,'YData',p.Results.YData);
else
    graphicHandle = plot(D,...
        'MarkerSize',p.Results.OuterMarkerSize,'ArrowPosition', 0.99, 'EdgeColor','black',...
        'NodeColor','black','EdgeAlpha',1, ...
        'Layout', p.Results.Layout);
    hold on;
    plot(D,'EdgeAlpha',0,'NodeColor','white','MarkerSize',p.Results.InnerMarkerSize,'NodeLabel',[], ...
        'Layout', p.Results.Layout);
end
graphicHandle.NodeLabel = [];
linewidths = (0.25*oldAdjacency+0.5*additionalEdges)';
graphicHandle.LineWidth = linewidths(find(linewidths));
arrowsizes = (6*oldAdjacency+6.5*additionalEdges)';
graphicHandle.ArrowSize = arrowsizes(find(arrowsizes));
[rN,rC] = find(additionalEdges);
highlight(graphicHandle,rN,rC,'Linestyle','--','EdgeColor','blue');
end

