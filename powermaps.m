clc;clear;

load('FTH/results/dis_lab.mat');
load('FTH/results/dis_lgra.mat');
load('FTH/results/dis_agra.mat');
load('FTH/results/dis_bgra.mat');


dis_lab=dis_hsv;
dis_lgra=dis_rgra;
dis_agra=dis_ggra;


left=importdata('left.txt');
right=importdata('right.txt');
img_num=size(left,1);


for k=2501:1:3500

name_1{k}=strcat('FTH/leftimages/left (',num2str(k),').jpg');
name_2{k}=strcat('FTH/rightimages/right (',num2str(k),').jpg');

img_1{k}=im2double(imread(num2str(name_1{k})));
img_2{k}=im2double(imread(num2str(name_2{k})));


lab_1{k}=rgb2lab(img_1{k});
lab_2{k}=rgb2lab(img_2{k});
l_1{k}=lab_1{k}(:,:,1);a_1{k}=lab_1{k}(:,:,2);b_1{k}=lab_1{k}(:,:,3);
l_2{k}=lab_2{k}(:,:,1);a_2{k}=lab_2{k}(:,:,2);b_2{k}=lab_2{k}(:,:,3);

ita_1{k}=(atan((l_1{k}-50)./b_1{k}))*180/3.1415926;
ita_2{k}=(atan((l_2{k}-50)./b_2{k}))*180/3.1415926;



[l_Gmag_1{k}, l_Gdir_1{k}] = imgradient(l_1{k},'prewitt');[a_Gmag_1{k}, a_Gdir_1{k}] = imgradient(a_1{k},'prewitt');[b_Gmag_1{k}, b_Gdir_1{k}] = imgradient(b_1{k},'prewitt');
[l_Gmag_2{k}, l_Gdir_2{k}] = imgradient(l_2{k},'prewitt');[a_Gmag_2{k}, a_Gdir_2{k}] = imgradient(a_2{k},'prewitt');[b_Gmag_2{k}, b_Gdir_2{k}] = imgradient(b_2{k},'prewitt');
%%%lab brightness channel
hist_lab{k}=histogram((dis_lab{k}-mean(dis_lab{k}(:)))/std(dis_lab{k}(:)),64);
vector_lab{k}=hist_lab{k}.Values;


hist_ita_1{k}=histogram((ita_1{k}-mean(ita_1{k}(:)))/std(ita_1{k}(:)),64);
vector_ita_1{k}=hist_ita_1{k}.Values;


hist_ita_2{k}=histogram((ita_2{k}-mean(ita_2{k}(:)))/std(ita_2{k}(:)),64);
vector_ita_2{k}=hist_ita_2{k}.Values;


%%%%%%l gradient channel
hist_lgra{k}=histogram((dis_lgra{k}-mean(dis_lgra{k}(:)))/std(dis_lgra{k}(:)),64);
vector_lgra{k}=hist_lgra{k}.Values;


hist_l_Gmag_1{k}=histogram((l_Gmag_1{k}-mean(l_Gmag_1{k}(:)))/std(l_Gmag_1{k}(:)),64);
vector_l_Gmag_1{k}=hist_l_Gmag_1{k}.Values;


hist_l_Gmag_2{k}=histogram((l_Gmag_2{k}-mean(l_Gmag_2{k}(:)))/std(l_Gmag_2{k}(:)),64);
vector_l_Gmag_2{k}=hist_l_Gmag_2{k}.Values;

%%%%%%a gradient channel
hist_agra{k}=histogram((dis_agra{k}-mean(dis_agra{k}(:)))/std(dis_agra{k}(:)),64);
vector_agra{k}=hist_agra{k}.Values;


hist_a_Gmag_1{k}=histogram((a_Gmag_1{k}-mean(a_Gmag_1{k}(:)))/std(a_Gmag_1{k}(:)),64);
vector_a_Gmag_1{k}=hist_a_Gmag_1{k}.Values;


hist_a_Gmag_2{k}=histogram((a_Gmag_2{k}-mean(a_Gmag_2{k}(:)))/std(a_Gmag_2{k}(:)),64);
vector_a_Gmag_2{k}=hist_a_Gmag_2{k}.Values;

%%%%%%b gradient channel
hist_bgra{k}=histogram((dis_bgra{k}-mean(dis_bgra{k}(:)))/std(dis_bgra{k}(:)),64);
vector_bgra{k}=hist_bgra{k}.Values;


hist_b_Gmag_1{k}=histogram((b_Gmag_1{k}-mean(b_Gmag_1{k}(:)))/std(b_Gmag_1{k}(:)),64);
vector_b_Gmag_1{k}=hist_b_Gmag_1{k}.Values;


hist_b_Gmag_2{k}=histogram((b_Gmag_2{k}-mean(b_Gmag_2{k}(:)))/std(b_Gmag_2{k}(:)),64);
vector_b_Gmag_2{k}=hist_b_Gmag_2{k}.Values;



%%%%EM distribution
f_range=[1:64];

w_dis{k}=vector_lab{k}/sum(vector_lab{k});
w_1{k}=vector_ita_1{k}/sum(vector_ita_1{k});w_2{k}=vector_ita_2{k}/sum(vector_ita_2{k});

[em_1{k} dis_1{k}]=emd(f_range',f_range',w_dis{k}',w_1{k}',@gdf);

[em_2{k} dis_2{k}]=emd(f_range',f_range',w_dis{k}',w_2{k}',@gdf);

w_l_dis{k}=vector_lgra{k}/sum(vector_lgra{k});
w_l_1{k}=vector_l_Gmag_1{k}/sum(vector_l_Gmag_1{k});w_l_2{k}=vector_l_Gmag_2{k}/sum(vector_l_Gmag_2{k});

[em_11{k} dis_11{k}]=emd(f_range',f_range',w_l_dis{k}',w_l_1{k}',@gdf);

[em_22{k} dis_22{k}]=emd(f_range',f_range',w_l_dis{k}',w_l_2{k}',@gdf);

w_a_dis{k}=vector_agra{k}/sum(vector_agra{k});
w_a_1{k}=vector_a_Gmag_1{k}/sum(vector_a_Gmag_1{k});w_a_2{k}=vector_a_Gmag_2{k}/sum(vector_a_Gmag_2{k});

[em_111{k} dis_111{k}]=emd(f_range',f_range',w_a_dis{k}',w_a_1{k}',@gdf);

[em_222{k} dis_222{k}]=emd(f_range',f_range',w_a_dis{k}',w_a_2{k}',@gdf);

w_b_dis{k}=vector_bgra{k}/sum(vector_bgra{k});
w_b_1{k}=vector_b_Gmag_1{k}/sum(vector_b_Gmag_1{k});w_b_2{k}=vector_b_Gmag_2{k}/sum(vector_b_Gmag_2{k});

[em_1111{k} dis_1111{k}]=emd(f_range',f_range',w_b_dis{k}',w_b_1{k}',@gdf);

[em_2222{k} dis_2222{k}]=emd(f_range',f_range',w_b_dis{k}',w_b_2{k}',@gdf);

% cell_lab=mat2cell(vector_lab,ones(1,1),ones(1,64));
% 
% cell_ita_1=mat2cell(vector_ita_1,ones(1,1),ones(1,64));
%%%KL-EM 
for i=1:1:64
   feat_1{k}{i}=log((vector_lab{k}(i)/sum(vector_lab{k}))./(vector_ita_1{k}/sum(vector_ita_1{k})))*(vector_lab{k}(i)/sum(vector_lab{k})).*(em_1{k}(i*64-63:i*64))';
   feat_1{k}{i}(isinf(feat_1{k}{i}))=0;
   feat_1{k}{i}(isnan(feat_1{k}{i}))=0;
   kl_em_1{k}{i}=sum(feat_1{k}{i});

   feat_2{k}{i}=log((vector_lab{k}(i)/sum(vector_lab{k}))./(vector_ita_2{k}/sum(vector_ita_2{k})))*(vector_lab{k}(i)/sum(vector_lab{k})).*(em_2{k}(i*64-63:i*64))';
   feat_2{k}{i}(isinf(feat_2{k}{i}))=0;
   feat_2{k}{i}(isnan(feat_2{k}{i}))=0;
   kl_em_2{k}{i}=sum(feat_2{k}{i});

   feat_3{k}{i}=log((vector_lgra{k}(i)/sum(vector_lgra{k}))./(vector_l_Gmag_1{k}/sum(vector_l_Gmag_1{k})))*(vector_lgra{k}(i)/sum(vector_lgra{k})).*(em_11{k}(i*64-63:i*64))';
   feat_3{k}{i}(isinf(feat_3{k}{i}))=0;
   feat_3{k}{i}(isnan(feat_3{k}{i}))=0;
   kl_em_3{k}{i}=sum(feat_3{k}{i});

   feat_4{k}{i}=log((vector_lgra{k}(i)/sum(vector_lgra{k}))./(vector_l_Gmag_2{k}/sum(vector_l_Gmag_2{k})))*(vector_lgra{k}(i)/sum(vector_lgra{k})).*(em_22{k}(i*64-63:i*64))';
   feat_4{k}{i}(isinf(feat_4{k}{i}))=0;
   feat_4{k}{i}(isnan(feat_4{k}{i}))=0;
   kl_em_4{k}{i}=sum(feat_4{k}{i});

   feat_5{k}{i}=log((vector_agra{k}(i)/sum(vector_agra{k}))./(vector_a_Gmag_1{k}/sum(vector_a_Gmag_1{k})))*(vector_agra{k}(i)/sum(vector_agra{k})).*(em_111{k}(i*64-63:i*64))';
   feat_5{k}{i}(isinf(feat_5{k}{i}))=0;
   feat_5{k}{i}(isnan(feat_5{k}{i}))=0;
   kl_em_5{k}{i}=sum(feat_5{k}{i});

   feat_6{k}{i}=log((vector_agra{k}(i)/sum(vector_agra{k}))./(vector_a_Gmag_2{k}/sum(vector_a_Gmag_2{k})))*(vector_agra{k}(i)/sum(vector_agra{k})).*(em_222{k}(i*64-63:i*64))';
   feat_6{k}{i}(isinf(feat_6{k}{i}))=0;
   feat_6{k}{i}(isnan(feat_6{k}{i}))=0;
   kl_em_6{k}{i}=sum(feat_6{k}{i});

   feat_7{k}{i}=log((vector_bgra{k}(i)/sum(vector_bgra{k}))./(vector_b_Gmag_1{k}/sum(vector_b_Gmag_1{k})))*(vector_bgra{k}(i)/sum(vector_bgra{k})).*(em_1111{k}(i*64-63:i*64))';
   feat_7{k}{i}(isinf(feat_7{k}{i}))=0;
   feat_7{k}{i}(isnan(feat_7{k}{i}))=0;
   kl_em_7{k}{i}=sum(feat_7{k}{i});

   feat_8{k}{i}=log((vector_bgra{k}(i)/sum(vector_bgra{k}))./(vector_b_Gmag_2{k}/sum(vector_b_Gmag_2{k})))*(vector_bgra{k}(i)/sum(vector_bgra{k})).*(em_2222{k}(i*64-63:i*64))';
   feat_8{k}{i}(isinf(feat_8{k}{i}))=0;
   feat_8{k}{i}(isnan(feat_8{k}{i}))=0;
   kl_em_8{k}{i}=sum(feat_8{k}{i});
end

kl_em_left{k}=[kl_em_1{k},kl_em_3{k},kl_em_5{k},kl_em_7{k}];
kl_em_right{k}=[kl_em_2{k},kl_em_4{k},kl_em_6{k},kl_em_8{k}];
disp(k);
end

save('FTH/results/left_features_4.mat','kl_em_left');
save('FTH/results/right_features_4.mat','kl_em_right');


