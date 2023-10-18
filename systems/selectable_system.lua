local function getDistance(pos,targetPos,dir)
 local dis,extraDis=dir==⬅️ and pos.x-targetPos.x or dir==➡️ and targetPos.x-pos.x or dir==⬆️ and pos.y-targetPos.y or dir==⬇️ and targetPos.y-pos.y or 0,(dir==⬅️ or dir==➡️) and abs(targetPos.y-pos.y) or (dir==⬆️ or dir==⬇️) and abs(targetPos.x-pos.x) or 0
 return dis<=0 and 9999 or dis+extraDis
end
local function moveSelectable(selectingSelectable,allSelectableEntities,pos,dir)
 local neareastDistance,neareastSelectableEnt=9999
 for _,ent in next,allSelectableEntities do
  if ent.isActive and ent[Selectable].interactable then
   local distance=getDistance(pos,ent[Pos],dir)
   if distance<neareastDistance and ent~=selectingSelectable.selectingEnt then
    neareastSelectableEnt,neareastDistance=ent,distance
   end
  end
 end
 if(neareastSelectableEnt) selectingSelectable.selectingEnt=neareastSelectableEnt
end
SelectableSystem=System({SelectingSelectable},function(ent)
 local selectingSelectable,selectableEntities=ent[SelectingSelectable],QueryWorld{Selectable,Pos}
 local selectingEnt,toSelect=selectingSelectable.selectingEnt
 for _,ent in next,selectableEntities do
  if ent.isActive then
   local selectable=ent[Selectable]
   selectable.isODown,selectable.isXDown=nil
   if(selectable.interactable)toSelect=ent
  end
 end
 if selectingEnt and selectingEnt.isActive then
  local selectable=selectingEnt[Selectable]
  if(selectable.interactable) then
   selectable.isODown,selectable.isXDown=btnp(🅾️),btnp(❎)
   local selectingPos=selectingEnt[Pos]
   if btnp(⬅️) then
    moveSelectable(selectingSelectable,selectableEntities,selectingPos,⬅️)
   end
   if btnp(➡️) then
    moveSelectable(selectingSelectable,selectableEntities,selectingPos,➡️)
   end
   if btnp(⬆️) then
   moveSelectable(selectingSelectable,selectableEntities,selectingPos,⬆️)
   end
   if btnp(⬇️) then
    moveSelectable(selectingSelectable,selectableEntities,selectingPos,⬇️)
   end
   return
  end
 end
 selectingSelectable.selectingEnt=toSelect
end)