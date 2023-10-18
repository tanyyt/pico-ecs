function IsExist(table,item)
 for i in all(table) do
  if(item==i)then
   return true
  end
 end
 return false
end
function Sort(table,compare)
 for i=1,#table do
  local j=#table
  while j>i do
   local a,b=table[j-1],table[j]
   if(compare(a,b))table[j],table[j-1]=a,b
   j=j-1
  end
 end
end