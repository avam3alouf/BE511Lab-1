clc
clear

C = readcell("Lab1RawData.xlsx");
time = cell2mat(C(2:end, 1));
V1200 = cell2mat(C(2:end,[2 4 6]));
V1200avg = mean(V1200')';
V1200sd = std(V1200')';

V2400 = cell2mat(C(2:end,[8 10 12]));
V2400avg = mean(V2400')';
V2400sd = std(V2400')';

V4800 = cell2mat(C(2:end,[14 16 18]));
V4800avg = mean(V4800')';
V4800sd = std(V4800')';

T1200 = cell2mat(C(2:end,[3 5 7]));
T1200avg = mean(T1200')';
T1200sd = std(T1200')';

T2400 = cell2mat(C(2:end,[9 11 13]));
T2400avg = mean(T2400')';
T2400sd = std(T2400')';

T4800 = cell2mat(C(2:end,[15 17 19]));
T4800avg = mean(T4800')';
T4800sd = std(T4800')';

dV1200 = V1200(1, :) - V1200;
dV2400 = V2400(1, :) - V2400;
dV4800 = V4800(1, :) - V4800;

dT1200 = T1200(1, :) - T1200;
dT2400 = T2400(1, :) - T2400;
dT4800 = T4800(1, :) - T4800;

plot(time, mean(V1200')', 'b', 'LineWidth', 3);
hold on
plot(time, mean(V2400')', 'g', 'LineWidth', 3);
plot(time, mean(V4800')', 'r', 'LineWidth', 3);


patch([time; flip(time)], [mean(V1200')'-std(V1200')'; flip(mean(V1200')'+std(V1200')')], 'b', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(V2400')'-std(V2400')'; flip(mean(V2400')'+std(V2400')')], 'g', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(V4800')'-std(V4800')'; flip(mean(V4800')'+std(V4800')')], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')

xlabel('time (s)');
ylabel('Voltage (V)');
title('Fast Response: Voltage')
legend('Rs = 1100 Ohms', 'Rs = 2390 Ohms', 'Rs = 4760 Ohms', '', '', '');
set(gca,'FontSize',22,'fontWeight','bold');
set(findall(gcf, 'type', 'text'), 'FontSize', 22);

figure();
plot(time, mean(T1200')', 'b', 'LineWidth', 3);
hold on
plot(time, mean(T2400')', 'g', 'LineWidth', 3);
plot(time, mean(T4800')', 'r', 'LineWidth', 3);


patch([time; flip(time)], [mean(T1200')'-std(T1200')'; flip(mean(T1200')'+std(T1200')')], 'b', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(T2400')'-std(T2400')'; flip(mean(T2400')'+std(T2400')')], 'g', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(T4800')'-std(T4800')'; flip(mean(T4800')'+std(T4800')')], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')

xlabel('time (s)');
ylabel('Temperature (ºC)');
title('Fast Response: Temperature')
legend('Rs = 1100 Ohms', 'Rs = 2390 Ohms', 'Rs = 4760 Ohms', '', '', '');
set(gca,'FontSize',22,'fontWeight','bold');
set(findall(gcf, 'type', 'text'), 'FontSize', 22);
figure()

plot(time, mean(dT1200')', 'b', 'LineWidth', 3);
hold on
plot(time, mean(dT2400')', 'g', 'LineWidth', 3);
plot(time, mean(dT4800')', 'r', 'LineWidth', 3);


patch([time; flip(time)], [mean(dT1200')'-std(dT1200')'; flip(mean(dT1200')'+std(dT1200')')], 'b', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(dT2400')'-std(dT2400')'; flip(mean(dT2400')'+std(dT2400')')], 'g', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(dT4800')'-std(dT4800')'; flip(mean(dT4800')'+std(dT4800')')], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')

xlabel('time (s)');
ylabel('\Delta Temperature (ºC)');
title('Fast Response: \DeltaT')
legend('Rs = 1100 Ohms', 'Rs = 2390 Ohms', 'Rs = 4760 Ohms', '', '', '');
set(gca,'FontSize',22,'fontWeight','bold');
set(findall(gcf, 'type', 'text'), 'FontSize', 22);

figure()

plot(time, mean(dV1200')', 'b', 'LineWidth', 3);
hold on
plot(time, mean(dV2400')', 'g', 'LineWidth', 3);
plot(time, mean(dV4800')', 'r', 'LineWidth', 3);

patch([time; flip(time)], [mean(dV1200')'-std(dV1200')'; flip(mean(dV1200')'+std(dV1200')')], 'b', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(dV2400')'-std(dV2400')'; flip(mean(dV2400')'+std(dV2400')')], 'g', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([time; flip(time)], [mean(dV4800')'-std(dV4800')'; flip(mean(dV4800')'+std(dV4800')')], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')

figure

Vs = 10;
 I = @(V, Rs)(Vs-V)./Rs;
 R = @(V, Rs) V./I(V, Rs);

R1200 = R(V1200avg, 1100);
R2400 = R(V2400avg, 2390);
R4800 = R(V4800avg, 4760);

[vun1200, ia1200, ic] = unique(V1200avg);
Rplot1200 = R1200(ia1200);
vsd1200 = V1200sd(ia1200);

[vun2400, ia2400, ic] = unique(V2400avg);
Rplot2400 = R2400(ia2400);
vsd2400 = V1200sd(ia2400);

[vun4800, ia4800, ic] = unique(V4800avg);
Rplot4800 = R4800(ia4800);
vsd4800 = V4800sd(ia4800);

plot(R1200, V1200avg, 'b', 'LineWidth', 3);
hold on
plot(R2400, V2400avg, 'g', 'LineWidth', 3);
plot(R4800, V4800avg, 'r', 'LineWidth', 3);

patch([Rplot1200; flip(Rplot1200)], [vun1200-vsd1200; flip(vun1200+vsd1200)], 'b', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([Rplot2400; flip(Rplot2400)], [vun2400-vsd2400; flip(vun2400+vsd2400)], 'g', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([Rplot4800; flip(Rplot4800)], [vun4800-vsd4800; flip(vun4800+vsd4800)], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')
% 
title("Average Thermistor Voltage vs. Thermistor Resistance for Different Rs Across 3 Trials");
xlabel("Average Thermistor Resistance (Ohms)");
ylabel("Average Thermistor Voltage (V)");

legend("R_s = 1100 Ohms","R_s = 1390 Ohms","R_s = 4760 Ohms");
ylim([0 10]);

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold');




