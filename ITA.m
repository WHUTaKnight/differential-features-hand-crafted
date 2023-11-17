clc;clear;

%   img_1= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G000.png'));%%%4
%   img_2= im2double(imread('b11-w100-s000-m000-r000-l050-C050-G000.png'));%%%6
%   img_1= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G000.png'));%%%0
%   img_2= im2double(imread('b11-w000-s100-m000-r000-l050-C050-G000.png'));%%%10
%  img_1= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G000.png'));%%%0
%  img_2= im2double(imread('b11-w000-s000-m100-r000-l050-C050-G000.png'));%%%10
%  img_1= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G000.png'));%%%0
%  img_2= im2double(imread('b11-w000-s000-m000-r100-l050-C050-G000.png'));%%%10
 img_1= im2double(imread('b11-w000-s000-m000-r000-l000-C050-G000.png'));%%%15
 img_2= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G000.png'));%%%0
%  img_1= im2double(imread('b11-w000-s000-m000-r000-l050-C000-G000.png'));%%9
%  img_2= im2double(imread('b11-w000-s000-m000-r000-l050-C100-G000.png'));%%6
% img_1= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G000.png'));%%%4
% img_2= im2double(imread('b11-w000-s000-m000-r000-l050-C050-G100.png'));%%%6
% img_1=im2double(imread('images/b11-w000-s000-m000-r000-l100-C050-G000.png'));%%%0
% img_2=im2double(imread('images/b11-w000-s100-m000-r000-l050-C050-G000.png'));%%%15
lab_1=rgb2lab(img_1);
lab_2=rgb2lab(img_2);
l_1=lab_1(:,:,1);a_1=lab_1(:,:,2);b_1=lab_1(:,:,3);
l_2=lab_2(:,:,1);a_2=lab_2(:,:,2);b_2=lab_2(:,:,3);

ita_1=(atan((l_1-50)./b_1))*180/3.1415926;
ita_2=(atan((l_2-50)./b_2))*180/3.1415926;


dis_lab=getalt_lab(img_1,img_2);
dis_lgra=getalt_rgra(lab_1,lab_2);
dis_agra=getalt_ggra(lab_1,lab_2);
dis_bgra=getalt_bgra(lab_1,lab_2);


[l_Gmag_1, l_Gdir_1] = imgradient(l_1,'prewitt');[a_Gmag_1, a_Gdir_1] = imgradient(a_1,'prewitt');[b_Gmag_1, b_Gdir_1] = imgradient(b_1,'prewitt');
[l_Gmag_2, l_Gdir_2] = imgradient(l_2,'prewitt');[a_Gmag_2, a_Gdir_2] = imgradient(a_2,'prewitt');[b_Gmag_2, b_Gdir_2] = imgradient(b_2,'prewitt');
%%%lab brightness channel
hist_lab=histogram((dis_lab-mean(dis_lab(:)))/std(dis_lab(:)),64);
vector_lab=hist_lab.Values;


hist_ita_1=histogram((ita_1-mean(ita_1(:)))/std(ita_1(:)),64);
vector_ita_1=hist_ita_1.Values;


hist_ita_2=histogram((ita_2-mean(ita_2(:)))/std(ita_2(:)),64);
vector_ita_2=hist_ita_2.Values;


%%%%%%l gradient channel
hist_lgra=histogram((dis_lgra-mean(dis_lgra(:)))/std(dis_lgra(:)),64);
vector_lgra=hist_lgra.Values;


hist_l_Gmag_1=histogram((l_Gmag_1-mean(l_Gmag_1(:)))/std(l_Gmag_1(:)),64);
vector_l_Gmag_1=hist_l_Gmag_1.Values;


hist_l_Gmag_2=histogram((l_Gmag_2-mean(l_Gmag_2(:)))/std(l_Gmag_2(:)),64);
vector_l_Gmag_2=hist_l_Gmag_2.Values;

%%%%%%a gradient channel
hist_agra=histogram((dis_agra-mean(dis_agra(:)))/std(dis_agra(:)),64);
vector_agra=hist_agra.Values;


hist_a_Gmag_1=histogram((a_Gmag_1-mean(a_Gmag_1(:)))/std(a_Gmag_1(:)),64);
vector_a_Gmag_1=hist_a_Gmag_1.Values;


hist_a_Gmag_2=histogram((a_Gmag_2-mean(a_Gmag_2(:)))/std(a_Gmag_2(:)),64);
vector_a_Gmag_2=hist_a_Gmag_2.Values;

%%%%%%b gradient channel
hist_bgra=histogram((dis_bgra-mean(dis_bgra(:)))/std(dis_bgra(:)),64);
vector_bgra=hist_bgra.Values;


hist_b_Gmag_1=histogram((b_Gmag_1-mean(b_Gmag_1(:)))/std(b_Gmag_1(:)),64);
vector_b_Gmag_1=hist_b_Gmag_1.Values;


hist_b_Gmag_2=histogram((b_Gmag_2-mean(b_Gmag_2(:)))/std(b_Gmag_2(:)),64);
vector_b_Gmag_2=hist_b_Gmag_2.Values;

vector_dis=[vector_lab,vector_lgra,vector_agra,vector_bgra];
vector_1=[vector_ita_1,vector_l_Gmag_1,vector_a_Gmag_1,vector_b_Gmag_1];
vector_2=[vector_ita_2,vector_l_Gmag_2,vector_a_Gmag_2,vector_b_Gmag_2];
%%%KL divergence

KL_1=(vector_dis./sum(vector_dis)).*log((vector_dis./sum(vector_dis))./(vector_1./sum(vector_1)));

KL_2=(vector_dis./sum(vector_dis)).*log((vector_dis./sum(vector_dis))./(vector_2./sum(vector_2)));
%%%%EM distribution
f_range=[1:64];

w_dis=vector_lab/sum(vector_lab);
w_1=vector_ita_1/sum(vector_ita_1);w_2=vector_ita_2/sum(vector_ita_2);

[em_1 dis_1]=emd(f_range',f_range',w_dis',w_1',@gdf);

[em_2 dis_2]=emd(f_range',f_range',w_dis',w_2',@gdf);

w_l_dis=vector_lgra/sum(vector_lgra);
w_l_1=vector_l_Gmag_1/sum(vector_l_Gmag_1);w_l_2=vector_l_Gmag_2/sum(vector_l_Gmag_2);

[em_11 dis_11]=emd(f_range',f_range',w_l_dis',w_l_1',@gdf);

[em_22 dis_22]=emd(f_range',f_range',w_l_dis',w_l_2',@gdf);

w_a_dis=vector_agra/sum(vector_agra);
w_a_1=vector_a_Gmag_1/sum(vector_a_Gmag_1);w_a_2=vector_a_Gmag_2/sum(vector_a_Gmag_2);

[em_111 dis_111]=emd(f_range',f_range',w_a_dis',w_a_1',@gdf);

[em_222 dis_222]=emd(f_range',f_range',w_a_dis',w_a_2',@gdf);

w_b_dis=vector_bgra/sum(vector_bgra);
w_b_1=vector_b_Gmag_1/sum(vector_b_Gmag_1);w_b_2=vector_b_Gmag_2/sum(vector_b_Gmag_2);

[em_1111 dis_1111]=emd(f_range',f_range',w_b_dis',w_b_1',@gdf);

[em_2222 dis_2222]=emd(f_range',f_range',w_b_dis',w_b_2',@gdf);

% cell_lab=mat2cell(vector_lab,ones(1,1),ones(1,64));
% 
% cell_ita_1=mat2cell(vector_ita_1,ones(1,1),ones(1,64));
%%%KL-EM 
for i=1:1:64
   feat_1{i}=log((vector_lab(i)/sum(vector_lab))./(vector_ita_1/sum(vector_ita_1)))*(vector_lab(i)/sum(vector_lab)).*(em_1(i*64-63:i*64))';
   feat_1{i}(isinf(feat_1{i}))=0;
   feat_1{i}(isnan(feat_1{i}))=0;
   kl_em_1{i}=sum(feat_1{i});

   feat_2{i}=log((vector_lab(i)/sum(vector_lab))./(vector_ita_2/sum(vector_ita_2)))*(vector_lab(i)/sum(vector_lab)).*(em_2(i*64-63:i*64))';
   feat_2{i}(isinf(feat_2{i}))=0;
   feat_2{i}(isnan(feat_2{i}))=0;
   kl_em_2{i}=sum(feat_2{i});

   feat_3{i}=log((vector_lgra(i)/sum(vector_lgra))./(vector_l_Gmag_1/sum(vector_l_Gmag_1)))*(vector_lgra(i)/sum(vector_lgra)).*(em_11(i*64-63:i*64))';
   feat_3{i}(isinf(feat_3{i}))=0;
   feat_3{i}(isnan(feat_3{i}))=0;
   kl_em_3{i}=sum(feat_3{i});

   feat_4{i}=log((vector_lgra(i)/sum(vector_lgra))./(vector_l_Gmag_2/sum(vector_l_Gmag_2)))*(vector_lgra(i)/sum(vector_lgra)).*(em_22(i*64-63:i*64))';
  feat_4{i}(isinf(feat_4{i}))=0;
   feat_4{i}(isnan(feat_4{i}))=0;
   kl_em_4{i}=sum(feat_4{i});

   feat_5{i}=log((vector_agra(i)/sum(vector_agra))./(vector_a_Gmag_1/sum(vector_a_Gmag_1)))*(vector_agra(i)/sum(vector_agra)).*(em_111(i*64-63:i*64))';
   feat_5{i}(isinf(feat_5{i}))=0;
   feat_5{i}(isnan(feat_5{i}))=0;
   kl_em_5{i}=sum(feat_5{i});

   feat_6{i}=log((vector_agra(i)/sum(vector_agra))./(vector_a_Gmag_2/sum(vector_a_Gmag_2)))*(vector_agra(i)/sum(vector_agra)).*(em_222(i*64-63:i*64))';
   feat_6{i}(isinf(feat_6{i}))=0;
   feat_6{i}(isnan(feat_6{i}))=0;
   kl_em_6{i}=sum(feat_6{i});

   feat_7{i}=log((vector_bgra(i)/sum(vector_bgra))./(vector_b_Gmag_1/sum(vector_b_Gmag_1)))*(vector_bgra(i)/sum(vector_bgra)).*(em_1111(i*64-63:i*64))';
   feat_7{i}(isinf(feat_7{i}))=0;
   feat_7{i}(isnan(feat_7{i}))=0;
   kl_em_7{i}=sum(feat_7{i});

   feat_8{i}=log((vector_bgra(i)/sum(vector_bgra))./(vector_b_Gmag_2/sum(vector_b_Gmag_2)))*(vector_bgra(i)/sum(vector_bgra)).*(em_2222(i*64-63:i*64))';
   feat_8{i}(isinf(feat_8{i}))=0;
   feat_8{i}(isnan(feat_8{i}))=0;
   kl_em_8{i}=sum(feat_8{i});
end

kl_em_left=[kl_em_1,kl_em_3,kl_em_5,kl_em_7];
kl_em_right=[kl_em_2,kl_em_4,kl_em_6,kl_em_8];



