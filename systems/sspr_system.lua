SsprSystem=System({Sspr,Pos},function(ent)
 local sspr,pos=ent[Sspr],ent[Pos]
 if(not sspr.enable)return
 SubmitSspr(
  QueryWorld{DrawSystemData}.first,
  sspr.x,
  sspr.y,
  sspr.width,
  sspr.height,
  pos.x,
  pos.y,
  sspr.layer,
  sspr.destWidth>0 and sspr.destWidth or sspr.width,
  sspr.destHeight>0 and sspr.destHeight or sspr.height,
  sspr.flipX,
  sspr.flipY)
end)