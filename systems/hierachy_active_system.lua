local function syncActive(hierachy)
 if(not hierachy.isDirty)return
 local parentHierachy=hierachy.parent and hierachy.parent[Hierachy]
 syncActive(parentHierachy)
 hierachy.isActiveHierachy,hierachy.isDirty=hierachy.isActiveSelf and (not parentHierachy or parentHierachy.isActiveHierachy)
end
function HierachyActiveSystem()
 local filtered=QueryWorld{Hierachy}
 for _,ent in next,filtered do
  ent[Hierachy].isDirty=true
 end
 for _,ent in next,filtered do
  local hierachy=ent[Hierachy]
  syncActive(hierachy)
  ent.isActive=hierachy.isActiveHierachy
 end
end