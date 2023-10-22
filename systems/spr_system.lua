SprSystem=System({Spr,Pos}, function(ent)
 local sprComp,pos=ent[Spr],ent[Pos]
 if(not sprComp.enable)return
 SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  spr(sprComp.id,pos.x,pos.y,sprComp.width,sprComp.height,sprComp.flipX,sprComp.flipY)
 end,sprComp.layer)
end)