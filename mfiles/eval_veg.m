function acc=eval_veg(gt, pred)
    % Evaluating Segmentation Results
    gold_im = gt;
    seg_im = pred;

    % TP FP TN FN
    TP = sum(seg_im & gold_im);
    TN = sum(~seg_im & ~gold_im); %Sum all black pixels in seg_im=gold_im
    FP = sum(~seg_im & gold_im);  
    FN = sum(seg_im & ~gold_im); 
    % Intersection over Union (IoU)
    acc = TP/(TP+FP+FN);
end
