function SetParent(parentEntity,childEntity)
 QueueCb(function()
  local parentHierachy,childHierachy=parentEntity[Hierachy],childEntity[Hierachy]
  if(childHierachy) childHierachy.parent=parentEntity
  local children,isFound=parentHierachy.children
  for child in all(children) do
   if(child==childEntity) isFound=true
  end
  if(not isFound) add(parentHierachy.children,childEntity)
  end)
end
function SetHierachyActive(ent,isActive)
 ent[Hierachy].isActiveSelf=isActive
end
function HierachyRemove(ent)
 local hierachy=ent[Hierachy]
 if hierachy and #hierachy.children>0 then
  for i in all(hierachy.children) do
   HierachyRemove(i)
  end
 end
 RemoveEnt(ent)
end