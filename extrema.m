function out = extrema(X)
    MAX = max(X);
    MIN = min(X);
    for i = 1:length(size(X))-1
        MAX = max(MAX);
        MIN = min(MIN);
    end
    out = [MIN MAX];
end