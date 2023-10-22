local function insertDrawCommand(dcs,dc)
 local insertIndex=#dcs+1
 for i=1,#dcs do
  if(dcs[i].layer>dc.layer)insertIndex=i break
 end
 add(dcs,dc,insertIndex)
end
function SubmitDraw(ent,cb,layer)
 insertDrawCommand(ent[DrawSystemData].dcs,{cb=cb,layer=layer})
end