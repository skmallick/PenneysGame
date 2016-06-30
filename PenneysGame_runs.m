%--------------------------------------------------------------------------
% Author: Shahid Mallick
%
% Monte Carlo simulation of Penney's Game. 
%   This program simulates Penney's game for x players, with any sequence length, over n trials.
%   It outputs the average number of flips required for each sequence to appear, and the respective win probability.
%   It also graphically shows how win probabilities diverge for various heads-tails patterns.
%
% To run, simply call PenneysGame_runs
%--------------------------------------------------------------------------



PenneysGame_setup; %collects user input

runs = 5000; %total number of trials or games that are played

windexTracker = zeros(1,runs); %stores the numbers of the winning player in each game
flipsTracker = zeros(numPlayers,runs); %the number of flips required in each trial for each player's sequence to emerge
winCount = zeros(numPlayers, runs); %tracks how many games each player wins
winPrcnt = zeros(numPlayers, runs); %tracks the percentage of games each player wins

%executes all the trials by calling the game script
for a=1:runs
    PenneysGame; %game script, executes a single game
    windexTracker(1,a) = windex; %stores the number of the winning player
    winCount(windex,a)= 1; %tracks which games each player wins
    
    %for each trial, goes through the players to record the flips they needed, and calculates their current win percentage
    for b=1:numPlayers
        flipsTracker(b,a) = flips(b); 
        winPrcnt(b,a) = (sum(winCount(b,1:a))/a)*100;
    end
    
end

%outputs the player that won the most games and calls on others to respect him/her
winner = mode(windexTracker);
if winner == winnerGuess
    fprintf('Congrats! You predicted correctly that, on average, Player %d would win.\n', winner);
else
    fprintf('Player %d won the most games! Bow down before Player %d''s greatness. \n', winner, winner);
end

%outputs the average number of required flips and the calculated win probability for each sequence
meanFlips = mean(flipsTracker,2); %average number of flips required for each sequence to emerge
for i=1:numPlayers
    fprintf('On average, it took Player %d''s sequence (%s) %.2f flips to appear. In %d trials, the probability of Player %d winning was %.2f. \n',i,sequence{i},meanFlips(i),runs,i,winPrcnt(i,runs));
    
end

%switches rows and colums to make it easy to plot
winPrcnt2 = permute(winPrcnt,[2,1]);

%plots the percentage of games each sequence won over the course of the entire simulation
figure
winPlot = plot(winPrcnt2, 'Marker', 'x', 'MarkerSize', 4);
t = sprintf('Win Probability over %d Games', runs);
title(t);
xlabel('Games');
ylabel('Percentage of Games Won');
legend(sequence, 'FontSize', 10);

%outputs the win percentage of each sequence to the right of the plot, with an arrow pointing at the correct curve
for i=1:numPlayers    
    p(i) = winPrcnt(i,runs);
    txt1 = sprintf('%.2f',p(i));
    txt2 = strcat('\leftarrow',txt1);
    text(runs, p(i), txt2);
end

