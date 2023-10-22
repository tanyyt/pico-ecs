function SetParent(parentEntity,childEntity)
 local childHierachy=childEntity[Hierachy]
 local originParent=childHierachy.parent
 if(originParent)del(originParent[Hierachy].children,childEntity)
 childHierachy.parent=parentEntity
 if(parentEntity)add(parentEntity[Hierachy].children,childEntity)
end
function SetHierachyActive(ent,isActive)
 ent[Hierachy].isActiveSelf=isActive
end
function HierachyRemoveDelay(ent)
 for i in all(ent[Hierachy].children) do
  HierachyRemoveDelay(i)
 end
 RemoveDelay(ent)
end