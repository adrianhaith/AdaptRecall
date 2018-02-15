% compactify_all
clear all
load RecallData_all
d = compactify_data(data);
dCtrl = compactify_data(dataCtrl);
dGrad = compactify_data(dataGrad);
dGradLong = compactify_data(dataGradLong);

 save RecallData_compact d dCtrl dGrad dGradLong