RectSystem=System({Rect,Pos},function(ent)
 local rectComp,pos=ent[Rect],ent[Pos]
 if(not rectComp.enable)return
  SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  if rectComp.isFill then
   rectfill(pos.x+rectComp.x0,pos.y+rectComp.y0,pos.x+rectComp.x1,pos.y+rectComp.y1,rectComp.col)
  else
   rect(pos.x+rectComp.x0,pos.y+rectComp.y0,pos.x+rectComp.x1,pos.y+rectComp.y1,rectComp.col)
  end
 end,rectComp.layer)
end)