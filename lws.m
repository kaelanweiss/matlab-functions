function out = lws()
% Function to print contents of workspace in human-readable format sorted
% by size on disk. Like "ls -lhS".

D = whos;
fs = [D.bytes];
fn = {D.name};

[~,idx] = sort(fs,'descend');

maxL = 0;
size_lbls = cell(1,length(fn));
size_tags = {' B','kB','MB','GB'};
for i = 1:length(fs)
    if length(fn{i}) > maxL
        maxL = length(fn{i});
    end
    pow10 = floor(log10(fs(i)));
    div10 = floor(pow10/3);
    if div10 == -Inf
        div10 = 0;
    end
    size_lbls{i} = sprintf('%.1f %s',fs(i)/10^(3*div10),size_tags{div10+1});
end

out = ' ';
for i = 1:length(fs)
    ii = idx(i);
    out = [out sprintf('%s\t%8s\n',strjust(sprintf(sprintf('%%%ds',maxL+1),fn{ii}),'left'),size_lbls{ii})];
end
    
    