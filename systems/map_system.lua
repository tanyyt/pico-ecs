MapSystem=System({Map,Pos},function(ent)
 local mapComp,pos=ent[Map],ent[Pos]
 if(not mapComp.enable)return
 SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  map(mapComp.cellX,mapComp.cellY,pos.x,pos.y,mapComp.cellWidth,mapComp.cellHeight,mapComp.layers)
 end,mapComp.layer)
end)