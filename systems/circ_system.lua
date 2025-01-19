CircSystem=System({Circ,Pos},function(ent)
 local circComp,pos=ent[Circ],ent[Pos]
 if(not circComp.enable)return
  SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  if circComp.isFill then
   circfill(pos.x+circComp.x,pos.y+circComp.y,circComp.r,circComp.col)
  else
   circ(pos.x+circComp.x,pos.y+circComp.y,circComp.r,circComp.col)
  end
 end,circComp.layer)
end)