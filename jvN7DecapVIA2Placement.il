/* jvN7DecapM2Placement.il
 *
 *
 * Author       Joel Viray
 * Language     SKILL
 * Date         July 7, 2019
 *
 * After Decap power placement, this scripts helps remove unwated VIA9.  
 * Condition: No M9 and M10 overlaps
 *  
 */


procedure(abGetOverlapShape(overlap)
  if(listp(overlap) then
      abGetOverlapShape(cadr(overlap))
  else
      overlap
  );if
);procedure

cv=geGetEditCellView()

procedure(jvN7DecapVIA2Placement_remove()


    foreach(decap_m2 geGetSelSet()

        decapM2Bbox=decap_m2~>bBox

        x1bbox=xCoord(lowerLeft(decapM2Bbox))
		y1bbox=yCoord(lowerLeft(decapM2Bbox))
        x2bbox=xCoord(upperRight(decapM2Bbox))
		y2bbox=yCoord(upperRight(decapM2Bbox))

        reduced_decapM2Bbox=list(x1bbox+0.0:y1bbox+0.0 x2bbox-0.0:y2bbox-0.0)

        
        M2_overlaps=dbProduceOverlap(cv reduced_decapM2Bbox 32 list("M2" "drawing"))
              


        flattened_M2_overlaps=foreach(mapcar overlap M2_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

       
       


        if(length(flattened_M2_overlaps)<0
            then
            dbDeleteObject(decap_m2)
        );if
      
               
    );foreach

);procedure



