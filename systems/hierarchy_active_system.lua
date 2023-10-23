local function syncActive(hierarchy)
 if(not hierarchy.isDirty)return
 local parentHierarchy=hierarchy.parent and hierarchy.parent[Hierarchy]
 if(parentHierarchy)syncActive(parentHierarchy)
 hierarchy.isActiveHierarchy,hierarchy.isDirty=hierarchy.isActiveSelf and (not parentHierarchy or parentHierarchy.isActiveHierarchy)
end
function HierarchyActiveSystem()
 local filtered=QueryWorld{Hierarchy}
 for _,ent in next,filtered do
  ent[Hierarchy].isDirty=true
 end
 for _,ent in next,filtered do
  local hierarchy=ent[Hierarchy]
  syncActive(hierarchy)
  ent.isActive=hierarchy.isActiveHierarchy
 end
end