DrawSystem=System({DrawSystemData},function(ent)
 local drawSystemData=ent[DrawSystemData]
 for dc in all(drawSystemData.dcs) do
  dc.cb()
 end
 drawSystemData.dcs={}
end)