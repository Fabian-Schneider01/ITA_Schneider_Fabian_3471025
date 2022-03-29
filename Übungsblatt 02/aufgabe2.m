importdata CompanySalesData.mat

%% vertical
v1 = .2;
v2 = .15;
v3 = .1;
subplot(2,1,1);
set(gca, 'xTickLabels', ['2020'; '2021'; '2022'; '2023'; '2024'])
bar(year, turnover, v1, 'FaceColor', '#0000FF');
hold on
bar(year, costs, v2, 'FaceColor', '#FF0000');
bar(year, profit, v3,'FaceColor', '#00FF00');
title('company sales vertical', 'FontSize', 20)
xlabel('year', 'FontSize',18);
ylabel('mio. in €', 'FontSize', 18);
legend('turnover', 'costs', 'profit');

%% horizontal
h1 = .75;
h2 = .6;
h3 = .45;
subplot(2,1,2);
set(gca, 'yTickLabels', ['2020'; '2021'; '2022'; '2023'; '2024'])
barh(year, turnover, h1, 'FaceColor', '#0000FF');
hold on
barh(year, costs, h2, 'FaceColor', '#FF0000');
barh(year, profit, h3', 'FaceColor', '#00FF00');
title('company sales horizontal', 'FontSize', 20);
xlabel('mio. in €', 'FontSize', 18);
ylabel('year', 'FontSize',18);
legend('turnover', 'costs', 'profit');