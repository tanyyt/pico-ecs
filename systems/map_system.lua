MapSystem=System({Map,Pos},function(ent)
 local map,pos=ent[Map],ent[Pos]
 if(not map.enable)return
 SubmitMap(
  QueryWorld{DrawSystemData}.first,
  map.cellX,
  map.cellY,
  pos.x,
  pos.y,
  map.cellWidth,
  map.cellHeight,
  map.layer,
  map.layers)
end)