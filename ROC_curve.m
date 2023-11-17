
clc;clear;

label(1:350,:)=0;
label(351:750,:)=1;

predict1(1:227,:)=0;
predict1(228:350,:)=1;
predict1(351:610,:)=1;
predict1(611:750,:)=0;

predict2(1:350,:)=0;
predict2(351:750,:)=1;

predict3(1:175,:)=0;
predict3(171:350,:)=1;
predict3(351:560,:)=1;
predict3(561:750,:)=0;

predict4(1:238,:)=0;
predict4(239:350,:)=1;
predict4(351:622,:)=1;
predict4(623:750,:)=0;

predict5(1:325,:)=0;
predict5(326:350,:)=1;
predict5(351:722,:)=1;
predict5(723:750,:)=0;

predict6(1:196,:)=0;
predict6(197:350,:)=1;
predict6(351:575,:)=1;
predict6(576:750,:)=0;


aaa=nonzeros(predict1-label);
bbb=nonzeros(predict2-label);
ccc=nonzeros(predict3-label);
ddd=nonzeros(predict4-label);
eee=nonzeros(predict5-label);
fff=nonzeros(predict6-label);

label(label>=0.5) = 1;  
label(label<0.5) = -1; 

M(:,1)=label;
M(:,2)=predict1;
M(:,3)=predict2;
M(:,4)=predict3;

MM(:,1)=label;
MM(:,2)=predict4;
MM(:,3)=predict5;
MM(:,4)=predict6;

rowrank = randperm(size(M, 1));
N = M(rowrank,:);  

rowrank2 = randperm(size(MM, 1));
NN = MM(rowrank2,:);  

label=N(:,1);
predict1=N(:,2);
predict2=N(:,3);
predict3=N(:,4);

label2=NN(:,1);
predict4=NN(:,2);
predict5=NN(:,3);
predict6=NN(:,4);

[tr1 tp1]=vl_roc(label, predict1) ;
[tr2 tp2]=vl_roc(label, predict2) ;
[tr3 tp3]=vl_roc(label, predict3) ;
[tr4 tp4]=vl_roc(label2, predict4) ;
[tr5 tp5]=vl_roc(label2, predict5) ;
[tr6 tp6]=vl_roc(label2, predict6) ;

figure('color','w');
plot(1-tp1,tr1,'m','LineWidth',2);hold on;
plot(1-tp2,tr2,'c','LineWidth',2);hold on;
plot(1-tp3,tr3,'g','LineWidth',2);hold on;
title('ROC'); legend({'Obejct detection based on YOLOv5','Scene recognition based on VGG16','Scene context recognition based on Hybrid DNN'},'FontSize',8,'Location','SouthEast');
xlabel('False positive rate','FontSize',10);set(gca, 'FontSize', 10);
ylabel('True positive rate','FontSize',10);set(gca, 'FontSize', 10);
grid off;

figure('color','w');
plot(1-tp4,tr4,'m','LineWidth',2);hold on;
plot(1-tp5,tr5,'c','LineWidth',2);hold on;
plot(1-tp6,tr6,'g','LineWidth',2);hold on;
title('ROC'); legend({'Obejct detection based on YOLOv5','Scene recognition based on VGG16','Scene context recognition based on Hybrid DNN'},'FontSize',8,'Location','SouthEast');
xlabel('False positive rate','FontSize',10);set(gca, 'FontSize', 10);
ylabel('True positive rate','FontSize',10);set(gca, 'FontSize', 10);
grid off;

figure('color','w');
plot(1-tp1,tr1,'m','LineWidth',2);hold on;
%plot(1-tp2,tr2,'c','LineWidth',2);hold on;
%plot(1-tp3,tr3,'g','LineWidth',2);hold on;
title('ROC'); 
%legend({'Obejct detection based on YOLOv5','Scene recognition based on VGG16','Scene context recognition based on Hybrid DNN'},'FontSize',8,'Location','SouthEast');
xlabel('False positive rate','FontSize',15);set(gca, 'FontSize', 15);
ylabel('True positive rate','FontSize',15);set(gca, 'FontSize', 15);
grid off;
figure('color','w');

plot(1-tp4,tr4,'m','LineWidth',2);hold on;
%plot(1-tp2,tr2,'c','LineWidth',2);hold on;
%plot(1-tp3,tr3,'g','LineWidth',2);hold on;
title('ROC'); 
%legend({'Obejct detection based on YOLOv5','Scene recognition based on VGG16','Scene context recognition based on Hybrid DNN'},'FontSize',8,'Location','SouthEast');
xlabel('False positive rate','FontSize',15);set(gca, 'FontSize', 15);
ylabel('True positive rate','FontSize',15);set(gca, 'FontSize', 15);
grid off;

% 
% figure('color','w');
% plot(rr3,pp3,'g','LineStyle','-','LineWidth',3);hold on;
% plot(rr2,pp2,'m','LineStyle','-','LineWidth',3);hold on;
% plot(rr4,pp4,'b','LineStyle','-','LineWidth',3);hold on;
% plot(rr5,pp5,'y','LineStyle','-','LineWidth',3);hold on;
% plot(rr1,pp1,'c','LineStyle','-','LineWidth',3);hold on;grid on;
% title('PR','FontSize',10); legend({'Our algorithm','Optical flow','SIFT flow','DASC','Image difference'},'FontSize',10);
% xlabel('Recall','FontSize',10);set(gca, 'FontSize', 10);
% ylabel('Precision','FontSize',10);set(gca, 'FontSize', 10);
% grid off;







