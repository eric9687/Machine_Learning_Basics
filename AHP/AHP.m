% A1~A7:judgement matrix
% A1: first layer
% A2: second layer
% A3~A7: alternatives
A1 = [1 3/7;7/3 1];
A2 = [1 3/2; 2/3 1];
A3 = [1 3/4 1; 4/3 1 4/3;1 3/4 1];
A4 = [1 1/2 1/2; 2 1 1 ;2 1 1];
A5 = [1 7/2 7 ;2/7 1 2 ; 1/7 1/2 1];


% weight calculation through function [judge]
w = zeros(3);
[~,w1]= judge(A1);
[~,w2]= judge(A2);
w2 = w1(3) * w2;
w(1, 1 : 3) = w1';
w(1, 3 : 5) = w2';
[~, w(2 : 5, 1)]= judge(A3);
[~, w(2 : 5, 2)]= judge(A4);
[~, w(2 : 5, 3)]= judge(A5);
% [~, w(2 : 5, 4)]= judge(A6);
% [~, w(2 : 5, 5)]= judge(A7);
% w
% score calculation 
score = zeros(1, 4);
for i = 1 : 4
    for j = 1 : 5
        score(i) = score(i) + w(1, j) * w(1 + i, j);
    end
    if i==4
        score % show score for comparing each meathod
    end
end



