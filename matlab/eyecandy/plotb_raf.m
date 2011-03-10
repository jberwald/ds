function h = plotb(tree, para1, para2, para3);
%
% plotb   2d or 3d box plot.
%    plotb(TREE), where TREE is a tree object, plots the boxes of TREE 
%    on depth -1. The default colour is red. 
%    If TREE has dimension two, then the plot is 2d, for higher dimensions
%    it is 3d. In this case only the first three components of the respective 
%    model are considered.
%
%    plotb(TREE, D), where D is an integer, plots the boxes of TREE 
%    on depth D.
%
%    plotb(TREE, COL), where COL is a character string made from an element 
%    of the following column, plots the boxes of TREE on depth -1 in the 
%    respective colour.   
%           y     yellow        
%           m     magenta       
%           c     cyan          
%           r     red           
%           g     green        
%           b     blue          
%           w     white         
%           k     black  
%
%    plotb(TREE, COMPONENTS), where COMPONENTS is a 2d or 3d vector , plots 
%    the boxes of TREE on depth -1 and considers the components as specified 
%    in the COMPONENTS vector.
%    EXAMPLES: 
%    plotb(TREE, [1 2 4]) plots the first two components against the 
%    fourth component of the respective model.
%    plotb(TREE, [2 3]) plots the second against the third component. 
%    The resulting plot is therefore only 2d instead of 3d.
%
%    NOTE: all three parameters D, COL, COMPONENTS can be combined in a 
%    deliberately chosen sequence.
%    EXAMPLES: 
%    plotb(TREE, D, COL) 
%    plotb(TREE, COL, COMPONENTS, D)
%    
%    An error message is given if the first input argument is not a tree 
%    object or if the chosen parameters are of the same kind (e.g. two 
%    colour strings). 
%
 

      depth = -1;
      colour = 'r';
      ix = 1;
      iy = 2;
      iz = 3;
      dim = tree.dim;
     dummy = [0 0 0];

if isa(tree, 'Tree')

  if nargin == 2;
      if isa(para1, 'double')
           if length(para1) == 1;
               depth = para1;
            elseif length(para1) == 2;
	          dim = 2;
                  ix = para1(1);
                  iy = para1(2);
            elseif length(para1) >= 3;
                  dim = 3;
                  ix = para1(1);
                  iy = para1(2);
	          iz = para1(3);
             end
      elseif isa(para1, 'char')
         colour = para1;
      end

  elseif nargin == 3;
      if isa(para1, 'double')
            if length(para1) == 1;
                depth = para1;
                dummy(1) = 1;
            elseif length(para1) == 2;
	        dim = 2;
                dummy(2) = 1;
                ix = para1(1);
                iy = para1(2);
            elseif length(para1) >= 3;
                dim = 3;
                dummy(2) = 1;
                ix = para1(1);
                iy = para1(2);
	        iz = para1(3);
            end;
      elseif isa(para1, 'char')
          colour = para1;
          dummy(3) = 1;
      end;

      if isa(para2, 'double')
            if length(para2) == 1;
                if dummy(1) == 0;
                   depth = para2;
                else error('Usage plotb(tree, [depth, axes, colour]).');
                end;
            elseif length(para2) == 2;
                if dummy(2) == 0;
                    dim = 2;
                    ix = para2(1);
                    iy = para2(2);
                else error('Usage plotb(tree, [depth, axes, colour]).');
                end;
            elseif length(para2) >= 3; 
                 if dummy(2) == 0;
                     dim = 3;
                     ix = para2(1);
                     iy = para2(2);
	             iz = para2(3);
                 else error('Usage plotb(tree, [depth, axes, colour]).');
                 end;
            end;
      elseif isa(para2, 'char')
           if dummy(3) == 0;
              colour = para2; 
           else error('Usage plotb(tree, [depth, axes, colour]).');
           end;
      end;

  elseif nargin == 4;
      if isa(para1, 'double')
            if length(para1) == 1;
                dummy(1) = 1;
                depth = para1;
            elseif length(para1) == 2;
                dummy(2) = 1;
	        dim = 2;
                ix = para1(1);
                iy = para1(2);
            elseif length(para1) >= 3;
                 dummy(2)=1;                  
                  dim = 3;
                  ix = para1(1);
                  iy = para1(2);
	          iz = para1(3);
            end;
       elseif isa(para1, 'char')
        dummy(3) = 1;
          colour = para1;
       end;

       if isa(para2, 'double')
            if length(para2) == 1;
               if dummy(1) == 0;
                  dummy(1) = 1;
                  depth = para2;
               else error('Usage plotb(tree, [depth, axes, colour]).');
               end;

            elseif length(para2) == 2;
                if dummy(2) == 0;
                   dummy(2) = 1;
                   dim = 2;
                   ix = para2(1);
                   iy = para2(2);
               else error('Usage plotb(tree, [depth, axes, colour]).');
               end;
            elseif length(para2) >= 3;
                if dummy(2) == 0;
                   dummy(2) = 1;
                   dim = 3;
                   ix = para2(1);
                   iy = para2(2);
	           iz = para2(3);
                else error('Usage plotb(tree, [depth, axes, colour]).');
                end;
            end;
       elseif isa(para2, 'char') 
             if dummy(3) == 0;
                dummy(3) = 1;
                colour = para2;
             else error('Usage plotb(tree, [depth, axes, colour]).');
             end;
       end;

       if isa(para3, 'double')
            if length(para3) == 1;
               if dummy(1) == 0;
                  depth = para3;
               else error('Usage plotb(tree, [depth, axes, colour]).');
               end;
            elseif length(para3) == 2;
                if dummy(2) == 0;
	           dim = 2;
                   ix = para3(1);
                   iy = para3(2);
                else error('Usage plotb(tree, [depth, axes, colour]).');
                end;
            elseif length(para3) >= 3;
                if dummy(2) == 0;
                   dim = 3;
                   ix = para3(1);
                   iy = para3(2);
	           iz = para3(3);
                else error('Usage plotb(tree, [depth, axes, colour]).');
                end;
             end;
        elseif isa(para3, 'char')
               if dummy(3) == 0;
                  colour = para3;
               else error('Usage plotb(tree, [depth, axes, colour]).');
               end;
        end;

   end;

  if depth > tree.depth
      error ('Chosen depth exceeds current depth.of tree.');
  end  
  if  dim == 2
    
    %% ------------ NEW CODE -----------------
    
    boxes = tree.boxes(depth);
    box = tree.first_box(depth);
    box_size = box(3:4)'*2;

    % find the size of the region, and add some padding
    tree_botleft = [min(boxes(1,:)) min(boxes(2,:))] - box_size/2; % corner
    tree_topright = [max(boxes(1,:)) max(boxes(2,:))] + box_size/2; % corner
    tree_size = round((tree_topright - tree_botleft) ./ box_size) % size in "pixels"
    
    output = repmat('.',[tree_size(2),tree_size(1)]);
    
    while (~isempty(box))
      % find the array entry for this box
      pos = round((box(1:2)'-box(3:4)'-tree_botleft) ./ box_size);
      output(tree_size(2)-pos(2),pos(1)+1) = 'O';		% color
      box = tree.next_box(-1);
    end
    
    disp(output);
    
    %% ---------------------------------------
    
%    h = showdim2(tree.boxes(depth)',colour, tree.dim, ix, iy);
% xlabel('x');
% ylabel('y');				
%     zoom on;
elseif dim > 2
  error('Can only display two-dimensional systems');
%     h = showdim3(tree.boxes(depth)', colour, tree.dim, ix, iy, iz);
% xlabel('x');
% ylabel('y');
% zlabel('z');
%     rotate3d on;
  end;

else error('Tree-object expected as first input argument.'); 
end;

%
% Subfunction 2-dimensional box plot
%

function g = showdim2(b, col, d, ix, iy)
if nargin < 3
  ix = 1;
  iy = 2;
   d = 2;
end
x=[b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y=[b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d)];
g=patch(x',y',col);


%
% Subfunction 3-dimensional box plot
%

function g = showdim3(b,color,d, ix, iy, iz)


  if nargin < 3
     d = 3;
    ix = 1;
    iy = 2;
    iz = 3;
  end

xmax = max(b(:,ix));
xmin = min(b(:,ix));
ymax = max(b(:,iy));
ymin = min(b(:,iy));
zmax = max(b(:,iz));
zmin = min(b(:,iz));

xr = b(1,ix+d);
yr = b(1,iy+d);
zr = b(1,iz+d);

axis([xmin-xr-0.000,xmax+xr+0.000,ymin-yr-0.000,ymax+yr+0.000,zmin-zr-0.000,zmax+zr+0.000])
hold on
x=[b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y=[b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d)];
z=[b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d) b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d)];
patch(x',y',z',color);
x=[b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y=[b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d)];
z=[b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d) b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d)];
patch(x',y',z',color);
x=[b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d)];
y=[b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)-b(:,iy+d)];
z=[b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d) b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d)];
patch(x',y',z',color);
x=[b(:,ix)-b(:,ix+d) b(:,ix)-b(:,ix+d) b(:,ix)-b(:,ix+d) b(:,ix)-b(:,ix+d)];
y=[b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)-b(:,iy+d)];
z=[b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d) b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d)];
patch(x',y',z',color);
x=[b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y=[b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d)];
z=[b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d) b(:,iz)+b(:,iz+d)];
patch(x',y',z',color);
x=[b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y=[b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d)];
z=[b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d) b(:,iz)-b(:,iz+d)];
g = patch(x',y',z',color);



