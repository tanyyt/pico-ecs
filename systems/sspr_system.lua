SsprSystem=System({Sspr,Pos},function(ent)
 local ssprComp,pos=ent[Sspr],ent[Pos]
 if(not ssprComp.enable)return
 SubmitDraw(QueryWorldSingle{DrawSystemData},function()
  sspr(ssprComp.x,ssprComp.y,ssprComp.width,ssprComp.height,pos.x,pos.y,ssprComp.destWidth>0 and ssprComp.destWidth or ssprComp.width,ssprComp.destHeight>0 and ssprComp.destHeight or ssprComp.height,ssprComp.flipX,ssprComp.flipY)
 end,ssprComp.layer)
end)