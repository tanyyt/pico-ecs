function SetPos(ent,x,y)
 local pos=ent[Pos]
 pos.x,pos.y,pos.changeType=x,y,WORLD_CHANGE
end
function SetLocalPos(ent,localX,localY)
 local pos=ent[Pos]
 pos.localX,pos.localY,pos.changeType=localX,localY,LOCAL_CHANGE
end