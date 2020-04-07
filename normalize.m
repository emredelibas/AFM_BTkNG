%% normalized function 
% input : an array.
% output : normalized array of input.
% NOTE: It ignored the diagonal cells. 

function [ normalizedArray ] = normalize(array)
 [mx,idx] = max(array(:));
    [mn,idn] = min(array(:));
    dim = length(array);
    normalizedArray=ones(dim,dim);
    sz = size(array);
    for row=1:sz(1)
        for col=1:sz(2)
           if(row~=col)
               normalizedArray(row,col)  = (array(row,col)-mn) / (mx-mn);
           end
        end
    end
end