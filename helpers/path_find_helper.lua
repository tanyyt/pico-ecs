--[[
    map:
    o o o o o
    o o x o o
    o o x o o
    o o x o o
    local maps={}
    for i=1,5 do
     maps[i]={}
     for j=1,4 do
      local map={x=i,y=j,f=9999}
      if(i==3 and j==2 or i==3 and j==3 or i==3 and j==4)map.isBlock=true
      maps[i][j]=map
     end
    end
    local path=AStarPathFind(maps,maps[1][3],maps[4][3])
]]
local neighbor=split"1,0,0,1,-1,0,0,-1"
local function caculateG(node)
 local g,t=1,node
 while t.parent do
  g+=1
  t=t.parent
 end
 return g
end
local function calculateF(currentNode,parentNode,targetNode)
 return caculateG(parentNode)+abs(targetNode.x-currentNode.x)+abs(targetNode.y-currentNode.y)
end
function AStarPathFind(maps,node,targetNode)
 local open,close,isFound={},{}
 add(open,node)
 while #open>0 do
  if(IsExist(open,targetNode))isFound=true break
  local minF,minNode=9999
  for o in all(open) do
   if o.f<minF or not minNode then
    minF,minNode=o.f,o
   end
  end
  add(close,del(open,minNode))
  for i=1,#neighbor-1,2 do
   local nX,nY=minNode.x+neighbor[i],minNode.y+neighbor[i+1]
   local column=maps[nX]
   if column then
    local nNode=column[nY]
    if nNode and not IsExist(close,nNode) and not nNode.isBlock then
     local f=calculateF(nNode,minNode,targetNode)
     if not IsExist(open,nNode) then
      add(open,nNode)
      nNode.f,nNode.parent=f,minNode
     elseif f<nNode.f then
      nNode.f,nNode.parent=f,minNode
     end
    end
   end
  end
 end
 if isFound then
  local path,t={},targetNode
  while t.parent do
   add(path,t)
   t=t.parent
  end
  return path
 end
end