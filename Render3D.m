%Rendering of Data
function Render3D(Nodes, Elems,Fixed, Force)
    %Param 1 - for rendering before calculations
    %Param 2 - rendering after calculations

    view(3);

    if nargin == 2

        figure(1);
        hold on

        for i = 1:size(Elems,1)
              plot3(Nodes(Elems(i,:),1), Nodes(Elems(i,:), 2), Nodes(Elems(i,:), 3), 'b'); 
              plot3(Nodes(Elems(i,[1 4]),1), Nodes(Elems(i,[1 4]), 2), Nodes(Elems(i,[1 4]),3), 'b');
              plot3(Nodes(Elems(i,[5 8]),1), Nodes(Elems(i,[5 8]), 2), Nodes(Elems(i,[5 8]),3), 'b');
              plot3(Nodes(Elems(i,[1 6]),1), Nodes(Elems(i,[1 6]), 2), Nodes(Elems(i,[1 6]),3), 'b');%
              plot3(Nodes(Elems(i,[3 8]),1), Nodes(Elems(i,[3 8]), 2), Nodes(Elems(i,[3 8]),3), 'b');%
              plot3(Nodes(Elems(i,[2 7]),1), Nodes(Elems(i,[2 7]), 2), Nodes(Elems(i,[2 7]),3), 'b');
        end
        
        xlim([min(Nodes(:,1)) - 0.5, max(Nodes(:,1)) + 0.5]);
        ylim([min(Nodes(:,2)) - 0.5, max(Nodes(:,2)) + 0.5]);
        zlim([min(Nodes(:,3)) - 0.5, max(Nodes(:,3)) + 0.5]);
        
        for i = 1:size(Nodes,1)
            text(Nodes(i,1), Nodes(i,2), Nodes(i,3), int2str(i));
        end
        hold off

    elseif nargin == 4
        
        figure(2);
        
        view(3);

        hold on
        for i = 1:size(Elems,1)
              plot3(Nodes(Elems(i,:),1), Nodes(Elems(i,:), 2), Nodes(Elems(i,:), 3), 'g'); 
              plot3(Nodes(Elems(i,[1 4]),1), Nodes(Elems(i,[1 4]), 2), Nodes(Elems(i,[1 4]),3), 'g');
              plot3(Nodes(Elems(i,[5 8]),1), Nodes(Elems(i,[5 8]), 2), Nodes(Elems(i,[5 8]),3), 'g');
              plot3(Nodes(Elems(i,[1 6]),1), Nodes(Elems(i,[1 6]), 2), Nodes(Elems(i,[1 6]),3), 'g');%
              plot3(Nodes(Elems(i,[3 8]),1), Nodes(Elems(i,[3 8]), 2), Nodes(Elems(i,[3 8]),3), 'g');%
              plot3(Nodes(Elems(i,[2 7]),1), Nodes(Elems(i,[2 7]), 2), Nodes(Elems(i,[2 7]),3), 'g');
        end
        
        for i = 1:size(Fixed,2)
            scatter3(Nodes(Fixed(i),1), Nodes(Fixed(i),2), Nodes(Fixed(i),3), "blue");
        end
        
        
        for i = 1:size(Force,1)
            scatter3(Nodes(Force(i),1), Nodes(Force(i),2), Nodes(Force(i),3), "red", 'filled');
        end
        
        xlim([min(Nodes(:,1)) - 0.5, max(Nodes(:,1)) + 0.5]);
        ylim([min(Nodes(:,2)) - 0.5, max(Nodes(:,2)) + 0.5]);
        zlim([min(Nodes(:,3)) - 0.5, max(Nodes(:,3)) + 0.5]);
        
        hold off
        
    end
end