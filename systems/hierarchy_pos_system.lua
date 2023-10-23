local function calculatePos(hierarchy,pos)
 if(not pos.isDirty)return
 local parentX,parentY=0,0
 if(hierarchy.parent)then
  local parentPos,parentHierarchy=hierarchy.parent[Pos],hierarchy.parent[Hierarchy]
  calculatePos(parentHierarchy,parentPos)
  parentX,parentY=parentPos.x,parentPos.y
 end
 if(WORLD_CHANGE==pos.changeType) then
  pos.localX,pos.localY=pos.x-parentX,pos.y-parentY
 else
  pos.x,pos.y=parentX+pos.localX,parentY+pos.localY
 end
 pos.changeType,pos.isDirty=LOCAL_CHANGE
end
local update=System({Hierarchy,Pos},function(ent)
 calculatePos(ent[Hierarchy],ent[Pos])
end)
function HierarchyPosSystem()
 local filtered=QueryWorld{Hierarchy,Pos}
 for _,ent in next,filtered do
  ent[Pos].isDirty=true
 end
 update()
end