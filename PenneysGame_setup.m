%--------------------------------------------------------------------------
% Author: Shahid Mallick
%
% Monte Carlo simulation of Penney's Game. 
%   This program introduces Penney's game and asks for user input.
%   It accepts any number of players and each player's desired sequence (of any length)
%
% It is executed in PenneysGame_runs by simply calling PenneysGame_setup
%--------------------------------------------------------------------------

numPlayers = 0; %resetting the number of players to 0
defaultNumPlayers = 2; %default player number if user does not assign
%defaultSeqLength = 3; %default length of coin flip sequence if user does not assign

%gets user input for how many players/sequences to run
prompt = 'Let''s flip some coins! How many players? ';
numPlayers = input(prompt);
if isempty(numPlayers)
    fprintf('%d sounds good.\n',defaultNumPlayers);
    numPlayers = defaultNumPlayers;
end

%accepts heads-tails sequences from each player
sequence = {}; %cell array b/c string input
for i=1:numPlayers
    prompt = sprintf('Player %d, pick a sequence (HH, HT, TTH, etc): ',i);
    sequence{i} = input(prompt, 's');
%     if isempty(sequence{i})
%         fprintf('No problem, I''ll assign you a string\n');
%         defaultSeq = randi([0,1],1,defaultSeqLength);
%         binSeq(i,:) = defaultSeq;
%         disp(defaultSeq);
%     end
end

%asks user to predict which sequence has the highest probability of winning
prompt = 'Which player do you think has the best chance of winning? ';
winnerGuess = input(prompt);