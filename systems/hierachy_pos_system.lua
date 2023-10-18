local function calculatePos(hierachy, pos)
 if(not pos.isDirty)return
 pos.isDirty=false
 local x,y,localX,localY=pos.x,pos.y,pos.localX,pos.localY
 if(not hierachy.parent) then
  if(WORLD_CHANGE==pos.changeType) then
   pos.localX,pos.localY=x,y
  else
   pos.x,pos.y=localX,localY
  end
 else
  local parentPos,parentHierachy=hierachy.parent[Pos],hierachy.parent[Hierachy]
  calculatePos(parentHierachy,parentPos)
  local parentX,parentY=parentPos.x,parentPos.y
  if(WORLD_CHANGE==pos.changeType) then
   pos.localX,pos.localY=x-parentX,y-parentY
  else
   pos.x,pos.y=parentX+localX,parentY+localY
  end
 end
 pos.changeType=LOCAL_CHANGE
end
local update=System({Hierachy,Pos},function(ent)
 calculatePos(ent[Hierachy],ent[Pos])
end)
function HierachyPosSystem()
 local filtered=QueryWorld{Hierachy, Pos}
 for _,ent in next,filtered do
  if(ent.isActive) ent[Pos].isDirty=true
 end
 update()
end