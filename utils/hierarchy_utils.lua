function SetParent(parentEntity,childEntity)
 local childHierarchy=childEntity[Hierarchy]
 local originParent=childHierarchy.parent
 if(originParent)del(originParent[Hierarchy].children,childEntity)
 childHierarchy.parent=parentEntity
 if(parentEntity)add(parentEntity[Hierarchy].children,childEntity)
end
function SetHierarchyActive(ent,isActive)
 ent[Hierarchy].isActiveSelf=isActive
end
function HierarchyRemoveDelay(ent)
 for i in all(ent[Hierarchy].children) do
  HierarchyRemoveDelay(i)
 end
 RemoveDelay(ent)
end