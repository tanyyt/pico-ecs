function Stop(ent)
 local anim=ent[Anim]
 anim.frame,anim.isPlaying=0
end

function Replay(ent)
 local anim=ent[Anim]
 anim.frame,anim.isPlaying=0,true
end
