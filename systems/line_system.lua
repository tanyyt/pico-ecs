LineSystem=System({Line,Pos},function(ent)
 local lineComp,pos=ent[Line],ent[Pos]
 if(not lineComp.enable)return
  SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  if lineComp.x1 and lineComp.y1 then
   line(pos.x+lineComp.x0,pos.y+lineComp.y0,pos.x+lineComp.x1,pos.y+lineComp.y1,lineComp.col)
  else
   line(pos.x+lineComp.x0,pos.y+lineComp.y0,lineComp.col)
  end
 end,lineComp.layer)
end)