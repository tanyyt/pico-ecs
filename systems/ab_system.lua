AbSystem=System({Ab,Pos},function(ent)
 local abs,ab,pos=QueryWorld({Ab,Pos}),ent[Ab],ent[Pos]
 if ab.enable then
  local xMin,xMax,yMin,yMax=ab.x0+pos.x,ab.x1+pos.x,ab.y0+pos.y,ab.y1+pos.y
  for _,ent2 in next,abs do
   local ab2,pos2=ent2[Ab],ent2[Pos]
   if ent2.isActive and ab2.enable and ent~=ent2 then
    local xMin2,xMax2,yMin2,yMax2=ab2.x0+pos2.x,ab2.x1+pos2.x,ab2.y0+pos2.y,ab2.y1+pos2.y
    if xMax>=xMin2 and xMax2>=xMin and yMax>=yMin2 and yMax2>=yMin then
     add(ab.intersects,ent2)
    end
   end
  end
 end
 QueueCb(function() ab.intersects={} end)
end)