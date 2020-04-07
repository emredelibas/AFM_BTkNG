function [nwk,tree,sqrfrm] = AFM_BTkNG(ng,percent,filename,nameofSpecies)
tic;
str = extractFileText(filename);
textData = split(str,newline);
numofSpecies=length(textData);
similarity = zeros(numofSpecies,numofSpecies);
for i=1:numofSpecies
   for j=i:numofSpecies
       if (i~=j)
            Si=convertStringsToChars(textData(i));
            Sj=convertStringsToChars(textData(j));
            ngramsSi = nmercount(Si,ng);
            ngramsSj = nmercount(Sj,ng);
            percentValueSi=floor((length(ngramsSi)*percent));
            percentValueSj=floor((length(ngramsSj)*percent));
            for k=1:percentValueSi
                tf = any(~cellfun('isempty',strfind(ngramsSj(1:percentValueSj,1),ngramsSi(k))));
                if tf==1
                    similarity(i,j)=similarity(i,j)+1;
                    similarity(j,i)= similarity(i,j);
                end
            end
       else
           similarity(i,j)=1;
       end
   end
end
toc
simNorm = normalize(similarity);
Z=pdist(simNorm);
sqrfrm=squareform(Z);
tree = seqlinkage(Z,'single',nameofSpecies);
nwk=getnewickstr(tree,'Distances',false);