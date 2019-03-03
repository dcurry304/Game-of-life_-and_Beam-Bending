%Problem 1 The Game of Life
%David Curry
%ID: 304755606
clear all;
clc;
rng('default');
%create initial matrix with 10% chance of being alive
num_rows = 150;
num_cols = 200;
A = rand(num_rows, num_cols);
for col = 1:num_cols
    for row = 1:num_rows
        if A(row,col) <= 0.9
            A(row,col) = 0;
        else
            A(row,col) = 1;
        end
    end
end
%graph the initial matrix
imagesc(A);
title('1');
figure;
%create a time and alive vector to graph it later
time = 300;
timevec = linspace(0,time,time);
alivevector = zeros(1,time);
%loop thru all time iterations
for k = 1:time
    %loop thru all columns
    alive = 0;
    for col = 1:num_cols
        %loop thru all rows
        for row = 1:num_rows
            A(row, col);
            %define neighbors
            N = row - 1;
            S = row + 1;
            E = col + 1;
            W = col - 1;
            if N < 1
                N = num_rows;
            end
            if S > num_rows
                S = 1;
            end
            if W < 1
                W = num_cols;
            end
            if E > num_cols
                E = 1;
            end
            %calculate sum of neighbors
            neighbors = A(N,W) + A(N,col) + A(N,E) + A(row,W) + A(row,E) + A(S,W) + A(S,col) + A(S,E);
            %change values based on initial rules and update how many are
            %alive
            if A(row,col) == 1
                if neighbors == 2 || neighbors == 3
                    A_new(row,col) = 1;
                    alivevector(k) = alivevector(k) + 1;
                else
                    A_new(row,col) = 0;
                end
            else
                if neighbors == 3
                    A_new(row,col) = 1;
                    alivevector(k) = alivevector(k) + 1;
                else
                    A_new(row,col) = 0;
                end
            end
        end
    end
    %update A
    A = A_new;
    %graph this as a gif
    imagesc(A);
    title(k);
    drawnow;
end
%graph the number alive vs time
figure;
plot(timevec,alivevector);
xlabel('time');
ylabel('Number of alive cells');
title('Number of alive cells versus time');
                