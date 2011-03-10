


clear all
close all

startintlab

%tic

%Defines model, starts and subdivides tree, and computes the adjacency
%matrix so that the dynamics are on the torus.

interval_map = @(x,y) standard_int_image(x, y);
wrap_it_up
TOTAL = [];
   
% Searching for candidates for periodic orbits.
   % Period 1 boxes.
     p1 = find(diag(P));
     TOTAL = [TOTAL p1];
     
     candidates = {};
     candidates{1} = find(diag(P));
     max_period = 2;

% Collect candidates for periodic orbits up to period max_period

% for i = 2 : max_period    
%     candidates{i} = find(diag(P^i));
%     TOTAL = union(TOTAL, candidates{i});
%     for k = 1 : (i-1)        
%         if (rem(i,k) == 0)            
%             candidates{i} = setdiff(candidates{i},candidates{k});            
%         end        
%     end    
% end

periods = {};
cycles = [];
neighborhoods = [];

%Compute all different periodic orbits with their cycles and store them in
% TOTAL.

% for i = 1 : max_period    
%     if (length(candidates{i}) ~= 0)    
%     cycles = cycle(tree, candidates{i}(1), P, i);
%     TOTAL = [TOTAL cycles];
%     neighborhoods = grow_iso_raf(TOTAL, P, ADJACENCY);        
%     for k = 2 : length(candidates{i})        
%         check_candidate = cycle(tree, candidates{i}(k), P, i);
%         check_nhood = grow_iso_raf(check_candidate, P, ADJACENCY);        
%         if (length(intersect(check_nhood, neighborhoods)) == 0)            
%             TOTAL = [TOTAL check_candidate];
%             neighborhoods = grow_iso_raf(TOTAL, P, ADJACENCY);        
%         end        
%     end    
%     end    
% end

% Make all possible connections. Is this efficient? I could connect as I
% find periodic orbits, but I'll try this first.

TOTALS = [];
periodic_orbits = TOTAL;

% for i = 1 : length(TOTAL)    
%     for k = 1 : length(TOTAL)   
%         if (TOTAL(k) ~= TOTAL(i))        
%         connection = dijkstra(P, TOTAL(i), TOTAL(k));            
%         if (length(setdiff(connection, TOTAL)) ~= 0)            
%             TOTALS = [TOTALS connection];            
%         end        
%         end        
%     end    
% end
% 
% TOTAL = union(TOTALS, TOTAL);

 %Growing an isolating neighborhood for S.
       I = grow_iso_raf(p1(1), P, ADJACENCY);%grow_isolated(candidates{1}, P, tree, depth);
 % Constructing an index pair (X, A).
       [X, A] = build_ip_raf(I, P, ADJACENCY); %build_ip(tree, depth, I, P);%

%INDEX_PAIRS = union(X,A);
% left_over = setxor(INDEX_PAIRS, MAX_SET);

 % Show index pair

       figure(1);
       b = tree.boxes(depth); 
       show2(b(:,X)', 'y');
       show2(b(:,A)', 'r');
       %show2(b(:,TOTAL)', 'g');
       hold on

toc
       
%NOW I'LL TRY TO GET SOMETHING OUT OF THE PARTS OF THE ATTRACTOR WHICH ARE
%LEFT OVER LOOKING FOR ORBITS STARTING WITH PERIODS FROM max_period + 1 to
%high_period

% high_period = 9;
% left_candidates = [];
% 
% previous_total = TOTAL;
% new_orbits = [];
% 
% for i = (max_period + 1) : high_period
%     
%     left_candidates = find(diag(P^i));
%     left_candidates = intersect(left_candidates, left_over);
% 
%     if (length(left_candidates)>0)
%     
%         while (length(left_candidates) > 0)
%             
%             addition = cycle(tree, left_candidates(1), P, i);
%             left_candidates = setdiff(left_candidates, addition);
%             
%             if (length(setdiff(addition,INDEX_PAIRS)) == i)
%                 
%                 %This may be expensive, but I want to check if the orbit is
%                 %next to the index pairs already. If so, they will not be
%                 %used in order to isolate new orbits in the gaps.
%                 
%                 check_adjacency = 0;
%                 
%                 for q = 1 : length(INDEX_PAIRS)
%                     for p = 1 : length(addition)
%                         check_adjacency = check_adjacency + ADJACENCY(addition(p), INDEX_PAIRS(q));
%                         
%                         if (length(new_orbits) ~= 0)
%                         for n = 1 : length(new_orbits)
%                             check_adjacency = check_adjacency + ADJACENCY(addition(p), new_orbits(n));
%                         end
%                         end
%                         
%                     end
%                 end
%                 
%                 if (check_adjacency == 0)
%                     new_orbits = [new_orbits addition];
%                 end
%                 
%             end
%             
%         end
%         
%     end
%     
% end
% 
% progress_made = setdiff(new_orbits, previous_total);
% length(progress_made)
% 
% if (length(progress_made) ~= 0)
% 
% clear TOTALS
% TOTALS = [];
% 
% for i = 1 : length(periodic_orbits)
%     for k = 1 : length(new_orbits)   
%         if (periodic_orbits(i) ~= new_orbits(k))
%         connection = dijkstra(P, periodic_orbits(i), new_orbits(k));            
%         if (length(setdiff(connection, TOTAL)) > 3)
%             TOTALS = [TOTALS connection];
%         end        
%         end        
%     end    
% end
% 
% TOTAL = union(TOTALS, TOTAL);
% 
% end

% Now we check if these orbits which are on the gaps are next to any part
% of the index pairs using the adjacency matrix. If they are, they will be
% removed

 %Growing an isolating neighborhood for S.
       %I = grow_iso_raf(TOTAL, P, ADJACENCY);
    
 % Constructing an index pair (X, A).
       %[X, A] = build_ip(tree, depth, I, P);
   
 % Show index pair

%        figure(2);
%        b = tree.boxes(depth); 
%        show2(b(:,X)', 'b');
%        show2(b(:,A)', 'g');
 
 % Finding the image, [Y, B], of [X, A] under P.
        n = tree.count(depth);
        FX = find(P*flags(X,n));               
        Y = union(X,FX);
        B = setdiff(Y,I);
%  
%  % Save sets, map t
% % Now we check if these orbits which are on the gaps are next to any part
% % of the index pao files.
            b = tree.boxes(depth);
            box2cub(b(:,X),'henon-X.dat')
            box2cub(b(:,A),'henon-A.dat')
            box2cub(b(:,Y),'henon-Y.dat')
            box2cub(b(:,B),'henon-B.dat')
            empty_boxes = tm2map(tree, depth, X, Y, P, 'henon.map');
% %        
%       !homcubes -a -i henon.map henon-X.dat henon-A.dat henon-Y.dat henon-B.dat -R > savefile
       !homcubes -a -i henon.map henon-X.dat henon-A.dat henon-Y.dat henon-B.dat -R       
% % 
% %        toc
% %        
%        parsecubes
%        topological_entropy = log(max(abs(eig(transition))))      
% %        
% %        toc       
%        
