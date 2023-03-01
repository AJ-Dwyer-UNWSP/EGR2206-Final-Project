% Author: Amber Kuhn
% Final Project Algorithm 2
% Date: 2/23/2023

% Buy and sell at defined intervals of 17 days. 

close all
clear all
clc

% load the data into the program
load StockData
format bank


% Set up variables
bank = 1000;
portfolio = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

% Define what days you want to check the stocks
for day = 1:17:6067
    % create a random order to check stocks
    y = randperm(28);
    
    % Set up for loop to go through each company
    for i = 1:28
        % find the price of stocks for the specific company 
        com = Stocks.(Companies(y(i),4));
        price = com(day,1);
        % Set up a double to track the price of each company stock for that
        % day
        day_p(i)=price;

        % Check to see if the price exists and or if the day is less than
        % 7 days from the start, Dont buy or sell if this is the case
        if (isnan(price))||(day<=7)
            continue
        end
        
        % Use if statement for the logic behind selling, buying, and
        % holding stocks
        % If the price for the current day is less than the price 7 days
        % prior then sell one stock from that company and add price to bank.
        if (price < com(day-7,1))&&(portfolio(y(i))>=1)
            bank = bank + price;
            portfolio(y(i))=portfolio(y(i))-1;

        % Else if the price is more than the price 7 days prior to the day
        % then buys stocks and subtracts price from bank account
        elseif (price > com(day-7,1))&&(bank>=price)
            bank = bank - price;
            portfolio(y(i)) = portfolio(y(i)) + 1;
            
        % Else if the price or portfolio does not stay with in these bounds
        % then make no change
        else
            bank = bank;
            portfolio = portfolio;
        end
        
    end
    % Calculate the net amount of money "owned"
    net = sum(portfolio.* day_p)+bank;

    % Create figures for the bank amount over time, net amount over time
    % and number of stocks owned at one time for each company (4
    % figures)
    figure(1)
    plot(Dates(day),net,'r.')
    hold on
    
    figure(2)
    plot(Dates(day),bank,'k.')
    hold on
    
    % Use a for loop to only put 7 companies on each figure for number of
    % stocks owned at one time
    for l = 1:length(portfolio)
        if l<=7
            figure(3)
            plot(Dates(day), portfolio(l), '.')
            hold on
        elseif (l>7)&&(l<=14)
            figure(4)
            plot(Dates(day), portfolio(l), '.')
            hold on
        elseif (l>14)&&(l<=21)
            figure(5)
            plot(Dates(day), portfolio(l), '.')
            hold on
        else
            figure(6)
            plot(Dates(day), portfolio(l), '.')
            hold on
        end  
end
       
end

% Add labels to the figures
figure(1)
ylabel('Net Amount')
xlabel('Date')
title('Net Amount over time')

figure(2)
xlabel('Day')
ylabel('Amount in Bank')
title('Amount in Bank every 17 days')

figure(3)
xlabel('Date')
ylabel('Number of stocks owned')
title('Stocks Owned Companies 1-7')
legend(Companies(1:7,1), 'Location','best')

figure(4)
xlabel('Date')
ylabel('Number of stocks owned')
title('Stocks Owned Companies 8-14')
legend(Companies(8:14,1), 'Location','best')

figure(5)
xlabel('Date')
ylabel('Number of stocks owned')
title('Stocks Owned Companies 15-21')
legend(Companies(15:21,1), 'Location','best')

figure(6)
xlabel('Date')
ylabel('Number of stocks owned')
title('Stocks Owned Companies 22-28')
legend(Companies(22:28,1), 'Location','best')

% Print out final results
fprintf('Ammount in Bank: $%.00f\n', bank)
fprintf('Net amount: $%.00f\n',net)
fprintf('%% Gain: %.00f%%\n',((net/1000 -1 )* 100))




