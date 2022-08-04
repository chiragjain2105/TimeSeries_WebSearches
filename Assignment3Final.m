multiTime = load('MultiTimeline.txt');
xmonth = multiTime(:,1);
xcv1 = multiTime(:, 2);
xcv2 = multiTime(:,3);
xcv1 = xcv1(~isnan(xcv1));
xcv2 = xcv2(~isnan(xcv2));
z = length(xmonth);
figure
plot(1:1:length(xcv1),xcv1,'r')
xlabel('Month');
ylabel('Washington Post');
pause
figure
plot(1:1:length(xcv2),xcv2,'r')
xlabel('Month');
ylabel('New York Times');
pause
t = 1 : 1 : length(xmonth);
T = 48;
dpoly1 = 1:1:40;
dper1 = 1:1:40;
J1 = zeros(40,40); % Columns for the dpoly value and rows for the dperiodic value
J2 = zeros(40,40);
% Evaluating parameters for data1
for i = 1 : 1 : 40
    for j = 1 : 1 : 40
 
       cls1 = fit(t, xcv1, dpoly1(i), dper1(j),T); % Parameters for Washington Post
        ynet1 = Time(cls1, dpoly1(i), dper1(j), t, T);
        J1(j,i) =  errorTime(xcv1,ynet1);
    end 
end 
L1 = zeros(2,40); % Matrix to store the minimum value and index corresponding to it 
j1 = J1' ; % To evaluate the value for error correspponding to dperiodic
l1 = zeros(2, 40); % Matrix to store the minimum value and index corresponding to it 
for k = 1 : 1 : 40
    [U V] = min(J1(:,k));
    L1(1,k) = U;
    L1(2,k) = V;
end
for k = 1 : 1 : 40
    [u v] = min(j1(:,k));
    l1(1,k) = u;
    l1(2,k) = v;
end

L1
fprintf('\n');
l1
q11 = L1(1, : );
q12 = L1(2, : );
fprintf('\nPlotting for error vs dpoly1 ');
figure 
plot(1 : (numel(q11)), q11, 'o m' )
xlabel('Dpoly for data1');
ylabel('Error corresponding the Dpoly value ' );
pause;
a11 = l1(1, : );
a12 = l1(2, :);
fprintf('\nPlotting for error vs dperiodic1 ');
figure
plot(1 : (numel(a11)), a11, 'o k' )
xlabel('Dperiodic for data1');
ylabel('Error corresponding the Dperiodic value ' );

pause

fprintf('\n');
   [d s] = min(L1(1 , :));
fprintf('\n');  
fprintf('Printing the optimal values of dpoly and dperiodic for data1 for which the mean squared error is minimum:\n');
fprintf('Optimal value of dpoly : ')
s
fprintf('\n');
fprintf('Optimal value of dperiodic : ')
L1(2,s)
fprintf('\n');
dpoly11 = s;
dper11 = L1(2,s);
pause

 % Evaluating parameters for data2

for i = 1 : 1 : 40
    for j = 1 : 1 : 40
        cls2 = fit(t, xcv2, dpoly1(i), dper1(j),T); % Parameters for NYT
        ynet2 = Time(cls2, dpoly1(i), dper1(j), t, T);
        J2(j,i) =  errorTime(xcv2,ynet2);
    end 
end 
L2 = zeros(2,40); % Matrix to store the minimum value and index corresponding to it 
j2 = J2' ; % To evaluate the value for error correspponding to dperiodic
e1 = zeros(2, 40); % Matrix to store the minimum value and index corresponding to it 
for k = 1 : 1 : 40
    [U V] = min(J2(:,k));
    L2(1,k) = U;
    L2(2,k) = V;
end

for k = 1 : 1 : 40
    [u v] = min(j2(:,k));
    e1(1,k) = u;
    e1(2,k) = v;
end
L2
fprintf('\n');
e1
q21 = L2(1, :);
q22 = L2(2, :);
fprintf('\nPlotting for error vs dpoly2');
fprintf('\n');
figure 
plot(1 : (numel(q21)), q21, 'o m' )
xlabel(' Dpoly for data2 ');
ylabel('Error corresponding the Dpoly value ' );
pause;
b11 = e1(1, : );
b12 = e1(2, :);
fprintf('\nPlotting for error vs dperiodic2 ');
figure
plot(1 : (numel(b11)), b11, 'o k' )
xlabel('Dperiodic for data2');
ylabel('Error corresponding the Dperiodic value ' );
pause
fprintf('\n');
   [d s] = min(L2(1 , :));
fprintf('\n');  
fprintf('Printing the optimal values of dpoly and dperiodic for data2 for which the mean squared error is minimum:\n');
fprintf('Optimal value of dpoly : ')
s
fprintf('\n');
fprintf('Optimal value of dperiodic : ')
L2(2,s)
dpoly2 = s;
dper2 = L2(2,s);
fprintf('\n');

 % Plotting trend vs seasonality for the data1
 cls1 = fit(t, xcv1, dpoly11, dper11,T); % Parameters for Washington Post
 ynet1 = Time(cls1, dpoly11, dper11,t, T); % Prediction for Washington Post
pause
figure
plot(1:1:length(xcv1),xcv1,'g')
hold on 
plot(t, ynet1,'r')
xlabel('Month');
ylabel('Washington Post(Pred)vs Original for train data');
legend('Original',' Predicted');
pause
% Computing trend and seasonality for training data2

        cls2 = fit(t, xcv2, dpoly2, dper2,T); % Parameters for NYT
        ynet2 = Time(cls2, dpoly2, dper2, t, T); % Prediction for NYT
figure
plot(1:1:length(xcv2),xcv2,'g')
hold on 
plot(t, ynet2, 'r')
xlabel('Month');
ylabel('New York Times(Pred)vs Original for train data');
legend('Original',' Predicted');
pause


% Evaluation of the prediction for test dataset
data1 = load('multiTimelinetest.txt');
Tmonth = data1(:,1);
Tcv1 = data1(:,2);
Tcv2 = data1(:,3);
Tcv1 = Tcv1(~isnan(Tcv1));
Tcv2 = Tcv2(~isnan(Tcv2));
Tt = 1 : 1 : (length(Tmonth));
ynet1pred = Time(cls1, dpoly11, dper11,Tt, T); % Prediction for Washington Post(test data)
errorpred1 = errorTime(Tcv1,ynet1pred);
fprintf('The squared error in the prediction for Washington Post is:\n');
errorpred1

fprintf('\n');
ynet2pred = Time(cls2, dpoly2, dper2, Tt, T);  % Prediction for NYT(test data)
errorpred2 = errorTime(Tcv2,ynet2pred);
fprintf('The squared error in the prediction for New York Times is:\n');
errorpred2
fprintf('\n');
% Plotting for data1 in test category
figure
plot(Tt,Tcv1,'r')
hold on 
plot(Tt, ynet1pred,'y')
xlabel('Month');
ylabel('Washington Post (test data) ');
legend('Actual test data', 'Predicted value');
pause
% Plotting for data2 in test category

figure
plot(Tt,Tcv2,'r')
hold on 
plot(Tt, ynet2pred, 'y')
xlabel('Month');
ylabel('New York Times(test data)');
legend('Actual test data', 'Predicted value');
pause
fprintf('\n This is the end of the exercise !!!!' );

















