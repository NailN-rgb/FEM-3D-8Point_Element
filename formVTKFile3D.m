function [b] = formVTKFile3D(Nodes, Elems, DeformNodes, FileName)

    
    path = 'C:\Users\Наиль\Documents\MATLAB\Figures\';

    if nargin == 4
        fileId = fopen(path + FileName + ".txt", 'w');
    else
        fileId = fopen(path + "Figure.txt", 'w');
    end
    

    fprintf(fileId, ['# vtk DataFile Version 4.2 \n' ...
                     'MyFile\n' ...
                     'ASCII\n' ...
                     'DATASET UNSTRUCTURED_GRID\n' ...
                     'POINTS\t' int2str(size(Nodes,1)) '\t float\n' ]);
    
    for i = 1:size(Nodes,1)
        fprintf(fileId, [num2str(Nodes(i,1)) '\t' num2str(Nodes(i,2)) '\t' num2str(Nodes(i,3)) '\n']);
    end

    fprintf(fileId, ['CELLS\t' int2str(size(Elems,1)) '\t' int2str((size(Elems,2) + 1) * (size(Elems,1)))  '\n']);

    for i = 1:size(Elems,1)
        fprintf(fileId, [int2str(size(Elems,2))    '\t']);

        fprintf(fileId, [int2str((Elems(i,1) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,2) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,3) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,4) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,5) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,6) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,7) - 1)) '\t']);
        fprintf(fileId, [int2str((Elems(i,8) - 1)) '\t']);

        fprintf(fileId,'\n');
    end


    fprintf(fileId,['CELL_TYPES\t' int2str(size(Elems,1)) '\n' ]);
    
    for i = 1:size(Elems,1)
        %VTK_HEXAGENDRON
        fprintf(fileId, [int2str(12) '\n']);
    end

    fprintf(fileId, ['POINT_DATA\t' int2str(size(DeformNodes,1)) '\n' ...
                     'VECTORS\tDipslatments\tfloat\n']);

    for i = 1:size(DeformNodes,1)
        fprintf(fileId, [num2str(DeformNodes(i,1) - Nodes(i,1)) ...
             '\t' num2str(DeformNodes(i,2) - Nodes(i,2)) '\t' num2str(DeformNodes(i,3) - Nodes(i,3)) '\n']);
    end

    fclose(fileId); 

%     o = pwd;
%     cd(path);
%     movefile('Figure.txt', 'Figure.vtk', 'f');
%     cd(o);
end