% An octave equivalent of 'cluster' function in matlab
%
% By Xuanchong Li (me@xuanchong.li)

function cluster_idx = cluster(tree, method, max_cluster)

%only support method = 'maxclust'

cluster_idx = zeros(size(tree,1)+1,1);

tree_size = size(tree,1);

cluster_num = 1;
centroids = zeros(max_cluster,1);
for i = tree_size+2-max_cluster:tree_size
    for idx = [tree(i,1),tree(i,2)]
        if idx < tree_size*2+3-max_cluster
            centroids(cluster_num,1) = idx;
            cluster_num = cluster_num + 1;
        end
    end
end

cluster_num = 1;

for center_idx = 1:size(centroids,1)
    
    center = centroids(center_idx,1);
    head = 1;
    tail = 1;
    assign_queue = [center];
    tail = tail + 1;
    
    while head < tail
        
        pop = assign_queue(head);
        head = head + 1;

        if pop <= tree_size + 1
            
            cluster_idx(pop,1) = cluster_num;
        else
            assign_queue(tail) = tree(pop-(tree_size+1),1);
            tail = tail + 1;
            assign_queue(tail) = tree(pop-(tree_size+1),2);
            tail = tail + 1;
        end
    end
    cluster_num = cluster_num + 1;
end
