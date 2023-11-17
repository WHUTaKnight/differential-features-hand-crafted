

function getalt_lab=getalt_lab(img_1,img_2)

k=3;kk=3;ker_size=1;
im_1=im2double(img_1);
im_2=im2double(img_2);
im_diff=im_1-im_2;
%figure;imagesc(im_diff);

part_1=zeros(ker_size,size(im_1,2)+2*ker_size,size(im_1,3));
part_2=zeros(size(im_1,1),ker_size,size(im_1,3));

im_1=[part_1;part_2,im_1,part_2;part_1];
im_2=[part_1;part_2,im_2,part_2;part_1];

r_1=im_1(:,:,1);
g_1=im_1(:,:,2);
c_1=im_1(:,:,3);
r_2=im_2(:,:,1);
g_2=im_2(:,:,2);
c_2=im_2(:,:,3);

lab_1=rgb2lab(im_1);
lab_2=rgb2lab(im_2);
l_1=lab_1(:,:,1);
a_1=lab_1(:,:,2);
b_1=lab_1(:,:,3);
l_2=lab_2(:,:,1);
a_2=lab_2(:,:,2);
b_2=lab_2(:,:,3);



for i=ker_size+1:1:(size(im_1,1)-ker_size)
    for j=ker_size+1:1:(size(im_1,2)-ker_size)
      e{i,j}=0;q{i,j}=0;
      for m=-ker_size:1:ker_size
        for n=-ker_size:1:ker_size
         
       e{i,j}=k*exp(-((sqrt((l_1(i,j)-l_1(i-m,j-n))^2+(a_1(i,j)-a_1(i-m,j-n))^2+(b_1(i,j)-b_1(i-m,j-n))^2))/7+sqrt(m^2+n^2)/kk))*k*exp(-((sqrt((l_2(i,j)-l_2(i-m,j-n))^2+(a_2(i,j)-a_2(i-m,j-n))^2+(b_2(i,j)-b_2(i-m,j-n))^2))/7+sqrt(m^2+n^2)/kk))*(abs(r_1(i-m,j-n)-r_2(i-m,j-n))+abs(g_1(i-m,j-n)-g_2(i-m,j-n))+abs(c_1(i-m,j-n)-c_2(i-m,j-n)))+e{i,j};
       q{i,j}=k*exp(-((sqrt((l_1(i,j)-l_1(i-m,j-n))^2+(a_1(i,j)-a_1(i-m,j-n))^2+(b_1(i,j)-b_1(i-m,j-n))^2))/7+sqrt(m^2+n^2)/kk))*k*exp(-((sqrt((l_2(i,j)-l_2(i-m,j-n))^2+(a_2(i,j)-a_2(i-m,j-n))^2+(b_2(i,j)-b_2(i-m,j-n))^2))/7+sqrt(m^2+n^2)/kk))+q{i,j};
      
        end
      end
    end
end



  ee=e(ker_size+1:size(e,1),ker_size+1:size(e,2));
  qq=q(ker_size+1:size(e,1),ker_size+1:size(e,2));
  mat1=cell2mat(ee);
  mat2=cell2mat(qq);
  getalt_lab=mat1./mat2;
%   figure;
%   imagesc(mat_e);
