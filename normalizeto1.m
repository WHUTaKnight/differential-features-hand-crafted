function out_img = normalizeto1( in_img )
%NORMALIZETO255 Summary of this function goes here
%   Detailed explanation goes here
ymax=1;ymin=0;
xmax=max(max(in_img));
xmin=min(min(in_img));
out_img=round((ymax-ymin)*(in_img-xmin)/(xmax-xmin)+ymin);

end

