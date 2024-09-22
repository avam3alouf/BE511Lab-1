clear, close all

temps = readtable("num1_analysisdat.csv");
E_r1 = readtable("Lab1_0_trial1.xlsx");
E_r2 = readtable("Lab1_1_trial1.xlsx");
E_r3 = readtable("Lab1_2_trial1.xlsx");

%% Part A

v_range = 2:2:12;
P_max = 50;
I = P_max ./ v_range;
I = cat(1,I,zeros(1,length(v_range)));

v_supply = 10;

R_s = v_supply ./ I(1,:);

plot(I(1,:),v_range,'r', 'LineWidth', 4);

for i=1:length(I)
    hold on
    plot(I(:,i),[0 10],LineWidth=4);
end

ylim([0 12]);
xlim([0 30]);

out{1} = "Max Power (<50 mW)";

for k = 1:length(R_s)
    out{k+1} = sprintf("Rs = %.2f kOhms",R_s(k));
end

legend(out);
xlabel('Current (mA)');
ylabel('Voltage (V)');
title("Maximum Power Line");

% Set font for axes
set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold')

%% Part F Data Analysis (#1)

figure;

% i
plot(temps.MercuryThermometerTemp_degC_,temps.V,'r', 'LineWidth', 4);

title("Thermistor Voltage vs. Thermometer Temp");
xlabel("Thermometer Temp (deg C)");
ylabel("Thermistor Voltage (V)");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold')

% ii
figure 
plot(temps.MercuryThermometerTemp_degC_,temps.R,'r', 'LineWidth', 4);
hold on 
plot(temps.MercuryThermometerTemp_degC_,temps.Expected_R,'k', 'LineWidth', 4);

title("Thermistor Resistance vs. Thermometer Temperature");
xlabel("Thermometer Temp (deg C)");
ylabel("Thermistor Resistance (Ohms)");

legend("Measured Thermistor Resistance","Expected Thermistor Resistance");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold')

% iii
figure 
plot(temps.MercuryThermometerTemp_degC_,temps.ThermisterTemp_degC_,'r', 'LineWidth', 4);
hold on 
plot(temps.MercuryThermometerTemp_degC_,temps.MercuryThermometerTemp_degC_,'k', 'LineWidth', 4);

title("Thermistor Temperature vs. Thermometer Temperature");
xlabel("Thermometer Temp (deg C)");
ylabel("Thermistor temp (deg C)");

legend("Measured Thermistor Temp Relation","Ideal Thermistor Temp Relation");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold')

% iv

resid = temps.ThermisterTemp_degC_ - temps.MercuryThermometerTemp_degC_;

figure 
scatter(temps.MercuryThermometerTemp_degC_,resid,"filled",'k', 'LineWidth', 4);

hold on

p = polyfit(temps.MercuryThermometerTemp_degC_,resid,3);
py = polyval(p,temps.MercuryThermometerTemp_degC_);

plot(temps.MercuryThermometerTemp_degC_,py,'r', 'LineWidth', 4);

title("Temperature Residuals Between Thermistor and Thermometer");
xlabel("Thermometer Temp (deg C)");
ylabel("Residual Difference (deg C)");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold');

%% (#5.) Power Dissipation (P = i^2R)

% R1 = 2.39 kOhms
% R2 = 4.76 kOhms
% R3 = 1.10 kOhms

R_o = 10000;
R_s = [2390 4760 1100];

i_disp = v_supply ./ (R_s + R_o);
P_disp = (i_disp .^ 2) .* R_o;

%% Part F, #6

v_1 = E_r1.Var2(2:end);
v_2 = E_r2.Var2(2:end);
v_3 = E_r3.Var2(2:end);

% useful lambdas
i = @(V,idx) (v_supply - V) ./ R_s(idx);
R_setup = @(V,idx) V ./ i(V,idx);

R1 = R_setup(v_1,1);
R2 = R_setup(v_2,2);
R3 = R_setup(v_3,3);

figure 
plot(R1,v_1,LineWidth=4);
hold on
plot(R2,v_2,LineWidth=4);
hold on
plot(R3,v_3,LineWidth=4);

title("Thermistor Voltage vs. Thermistor Resistance for Different Rs");
xlabel("Thermistor Resistance (Ohms)");
ylabel("Thermistor VOltage (V)");

legend("R_s = 2390 Ohms","R_s = 4760 Ohms","R_s = 1100 Ohms");

set(gca,'FontSize',22,'fontWeight','bold') % Set font for all other text in figure
set(findall(gcf, 'type', 'text'), 'FontSize', 22, 'fontWeight', 'bold');