function SetParentDelay(parentEntity,childEntity)
 QueueCb(function()
  local parentHierachy,childHierachy=parentEntity[Hierachy],childEntity[Hierachy]
  local originParent=childHierachy.parent
  if originParent then
   del(originParent[Hierachy].children,childEntity)
  end
  add(parentHierachy.children,childEntity)
 end)
end
function SetHierachyActive(ent,isActive)
 ent[Hierachy].isActiveSelf=isActive
end
function HierachyRemoveDelay(ent)
 for i in all(ent[Hierachy].children) do
  HierachyRemoveDelay(i)
 end
 RemoveEntDelay(ent)
end