TxtSystem=System({Txt,Pos},function(ent)
 local txt,pos=ent[Txt],ent[Pos]
 if(not txt.enable)return
 SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  print(txt.str,pos.x,pos.y,txt.col)
 end,txt.layer)
end)