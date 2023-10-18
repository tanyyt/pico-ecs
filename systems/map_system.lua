MapSystem=System({Map,Pos},function(ent)
 local map,pos=ent[Map],ent[Pos]
 SubmitMap(
  SingletonEntity[DrawSystemData],
  map.cellX,
  map.cellY,
  pos.x,
  pos.y,
  map.cellWidth,
  map.cellHeight,
  map.layer,
  map.layers
 )
end)