function [blocks,widths] = findBlocks(v)
% Function to return the starting and ending indices of blocks of
% uninterrupted/consecutive "true" values in a vector.
%
% [blocks,widths] = findBlocks(v)
%
% Input
%   v: logical vector
%
% Output
%   blocks: (m x 2) matrix where rows correspond to blocks, the first
%       column is the starting index of the true block, and the second
%       column is the ending index (evaluates to true)
%   widths: (m x 1) vector where rows are the lengths of the blocks
%
% KJW
% 14 Sep 2022


n = length(v);
blocks = [];

inBlock = false;
% step through vector
for pos = 1:n
    % not at edge of a block
    if (~v(pos) && ~inBlock) || (v(pos) && inBlock)
        continue
    % at start of block
    elseif v(pos) && ~inBlock
        blocks(end+1,1:2) = [pos nan];
        inBlock = true;
    % at end of block
    elseif ~v(pos) && inBlock
        blocks(end,2) = pos-1;
        inBlock = false;
    end
end

% catch the case where a block stretches to the end of the vector
if inBlock
    blocks(end,2) = pos;
end

% calculate block widths
widths = diff(blocks,1,2)+1;

