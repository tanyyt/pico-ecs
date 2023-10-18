local function insertDrawCommand(dcs,dc)
 local insertIndex=#dcs+1
 for i=1,#dcs do
  if(dcs[i].layer>dc.layer)insertIndex=i break
 end
 add(dcs,dc,insertIndex)
end
function SubmitSpr(drawSystemData,id,x,y,layer,width,height,flipX,flipY)
 insertDrawCommand(drawSystemData.dcs,{type=DRAW_SPR,id=id,x=x,y=y,layer=layer,width=width,height=height,flipX=flipX,flipY=flipY})
end
function SubmitSspr(drawSystemData,x,y,width,height,destX,destY,layer,destWidth,destHeight,flipX,flipY)
 insertDrawCommand(drawSystemData.dcs,{type=DRAW_SSPR,x=x,y=y,width=width,height=height,destX=destX,destY=destY,layer=layer,destWidth=destWidth,destHeight=destHeight,flipX=flipX,flipY=flipY})
end
function SubmitPrint(drawSystemData,str,x,y,layer,col)
 insertDrawCommand(drawSystemData.dcs,{type=DRAW_PRINT,str=str,x=x,y=y,layer=layer,col=col})
end
function SubmitMap(drawSystemData,cellX,cellY,x,y,cellWidth,cellHeight,layer,layers)
 insertDrawCommand(drawSystemData.dcs,{type=DRAW_MAP,cellX=cellX,cellY=cellY,x=x,y=y,cellWidth=cellWidth,cellHeight=cellHeight,layer=layer,layers=layers})
end