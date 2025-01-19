SprAnimSystem=System({Anim,Spr},function(ent)
 local anim,spr=ent[Anim],ent[Spr]
 for i=1,#anim.frames do
  if anim.frame==anim.frames[i] then
   spr.id=anim.states[i].id
  end
 end
 if anim.frame==anim.frames[#anim.frames] then
  if anim.isLoop then
   anim.frame=0
  end
  return
 end
 if(anim.isPlaying)anim.frame+=1
end)