OvalSystem=System({Oval,Pos},function(ent)
 local ovalComp,pos=ent[Oval],ent[Pos]
 if(not ovalComp.enable)return
  SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  if ovalComp.isFill then
   ovalfill(pos.x+ovalComp.x0,pos.y+ovalComp.y0,pos.x+ovalComp.x1,pos.y+ovalComp.y1,ovalComp.col)
  else
   oval(pos.x+ovalComp.x0,pos.y+ovalComp.y0,pos.x+ovalComp.x1,pos.y+ovalComp.y1,ovalComp.col)
  end
 end,ovalComp.layer)
end)