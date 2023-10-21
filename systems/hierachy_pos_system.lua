local function calculatePos(hierachy,pos)
 if(not pos.isDirty)return
 local parentX,parentY=0,0
 if(hierachy.parent)then
  local parentPos,parentHierachy=hierachy.parent[Pos],hierachy.parent[Hierachy]
  calculatePos(parentHierachy,parentPos)
  parentX,parentY=parentPos.x,parentPos.y
 end
 if(WORLD_CHANGE==pos.changeType) then
  pos.localX,pos.localY=pos.x-parentX,pos.y-parentY
 else
  pos.x,pos.y=parentX+pos.localX,parentY+pos.localY
 end
 pos.changeType,pos.isDirty=LOCAL_CHANGE
end
local update=System({Hierachy,Pos},function(ent)
 calculatePos(ent[Hierachy],ent[Pos])
end)
function HierachyPosSystem()
 local filtered=QueryWorld{Hierachy,Pos}
 for _,ent in next,filtered do
  ent[Pos].isDirty=true
 end
 update()
end