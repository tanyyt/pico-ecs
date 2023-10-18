DrawSystem=System({DrawSystemData},function(ent)
 local drawSystemData=ent[DrawSystemData]
 for dc in all(drawSystemData.dcs) do
  local type=dc.type
  if(type==DRAW_SPR)spr(dc.id,dc.x,dc.y,dc.width,dc.height,dc.flipX,dc.flipY)
  if(type==DRAW_SSPR)sspr(dc.x,dc.y,dc.width,dc.height,dc.destX,dc.destY,dc.destWidth,dc.destHeight,dc.flipX,dc.flipY)
  if(type==DRAW_PRINT)print(dc.str,dc.x,dc.y,dc.col)
  if(type==DRAW_MAP)map(dc.cellX,dc.cellY,dc.x,dc.y,dc.cellWidth,dc.cellHeight,dc.layers)
 end
 drawSystemData.dcs={}
end)