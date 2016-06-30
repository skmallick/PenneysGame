%--------------------------------------------------------------------------
% Author: Shahid Mallick
%
% Monte Carlo simulation of Penney's Game. 
%   This program simulates one trial of Penney's game for x players, with any sequence length (determined in PenneysGame_setup).
%   It determines the number of flips required for each sequence to appear, and which player won the game.
%
% It is executed within PenneysGame_runs by simply calling PenneysGame
%--------------------------------------------------------------------------

n = 500; %number of coin flips in each trial

%reinstantiating variables
i=1;
coin = [];

coin = randi([0,1],1,n); %random binary assortment of n coin flips, 1=heads, 0=tails


seq = char(sequence); %converts string cell array to character array for easy conversion to binary
[p,q] = size(seq);
binSeq = zeros(p,q); %declares binary array to replace character array

%converts character arrays into binary arrays
for x=1:p
    for y=1:q
        if seq(x,y) == 'H' || seq(x,y) == 'h'
            binSeq(x,y) = 1;
        elseif seq(x,y) == 'T' || seq(x,y) == 't'
            binSeq(x,y) = 0;
        else
            binSeq(x,y) = -1;
        end
    end
end


flips = zeros(numPlayers,1); %stores flips it takes for each player's sequence to emerge

%compares the players' sequences with the fair coin flips
%stores the number of flips when the sequences first appear
for i=1:n-q+1
    for x=1:p
        sqLngth = length(sequence{x});
        if coin(i:i+sqLngth-1) == binSeq(x,1:sqLngth)
            if flips(x) == 0
                flips(x) = i+sqLngth-1;
            end
        end
    end
end

%outputs a warning if a sequence did not emerge in this trial of coin flips
for i=1:length(flips)
    if flips(i) == 0;
        fprintf('%s did not appear in this trial. Please try again.\n',sequence{i});
    end
end

%determines which flip yielded a winner and ended the game
winFlip = 0; %the number of flips that occurred before a winner emerged
windex = 0; %the player that won the game
flips(~flips) = inf; %if the sequence did not appear, zeros are set to inf
[winFlip windex] = min(flips); %returns the sequence that emerged in the fewest number of flips

%outputs a warning that a trial ended in a tie. The code favors lower-numbered players in the case of a tie
allMin = find(flips == min(flips(:)));
if length(allMin) > 1
    fprintf('This trial ended in a tie between players ');
    for i=1:length(allMin)
         fprintf('%d; ',allMin(i));
    end
    fprintf('\n');
end
