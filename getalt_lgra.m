

function getalt_rgra=getalt_rgra(img_1,img_2)

k=5;kk=3;ker_size=1;
im_1=im2double(img_1);
im_2=im2double(img_2);
im_diff=im_1-im_2;
%figure;imagesc(im_diff);

part_1=zeros(ker_size,size(im_1,2)+2*ker_size,size(im_1,3));
part_2=zeros(size(im_1,1),ker_size,size(im_1,3));

im_1=[part_1;part_2,im_1,part_2;part_1];
im_2=[part_1;part_2,im_2,part_2;part_1];

% gray_1=rgb2gray(im_1);
% gray_2=rgb2gray(im_2);
r_1=im_1(:,:,1);
% g_1=im_1(:,:,2);
% b_1=im_1(:,:,3);

r_2=im_2(:,:,1);
% g_2=im_2(:,:,2);
% b_2=im_2(:,:,3);


[r_Gmag_1, r_Gdir_1] = imgradient(r_1,'prewitt');
[r_Gmag_2, r_Gdir_2] = imgradient(r_2,'prewitt');

[r_Gx_1, r_Gy_1] = imgradientxy(r_1);
[r_Gx_2, r_Gy_2] = imgradientxy(r_2);



for i=ker_size+1:1:(size(im_1,1)-ker_size)
    for j=ker_size+1:1:(size(im_1,2)-ker_size)
      e{i,j}=0;q{i,j}=0;
      for m=-ker_size:1:ker_size
        for n=-ker_size:1:ker_size
         
       e{i,j}=k*exp(-((sqrt((r_Gx_1(i,j)-r_Gx_1(i-m,j-n))^2+(r_Gy_1(i,j)-r_Gy_1(i-m,j-n))^2))/3+sqrt(m^2+n^2)/kk))*k*exp(-((sqrt((r_Gx_2(i,j)-r_Gx_2(i-m,j-n))^2+(r_Gy_2(i,j)-r_Gy_2(i-m,j-n))^2))/3+sqrt(m^2+n^2)/kk))*(abs(r_Gmag_1(i-m,j-n)-r_Gmag_2(i-m,j-n)))+e{i,j};
       q{i,j}=k*exp(-((sqrt((r_Gx_1(i,j)-r_Gx_1(i-m,j-n))^2+(r_Gy_1(i,j)-r_Gy_1(i-m,j-n))^2))/3+sqrt(m^2+n^2)/kk))*k*exp(-((sqrt((r_Gx_2(i,j)-r_Gx_2(i-m,j-n))^2+(r_Gy_2(i,j)-r_Gy_2(i-m,j-n))^2))/3+sqrt(m^2+n^2)/kk))+q{i,j};
      
        end
      end
    end
end



  ee=e(ker_size+1:size(e,1),ker_size+1:size(e,2));
  qq=q(ker_size+1:size(e,1),ker_size+1:size(e,2));
  mat1=cell2mat(ee);
  mat2=cell2mat(qq);
  getalt_rgra=mat1./mat2;
%   figure;
%   imagesc(mat_e);
