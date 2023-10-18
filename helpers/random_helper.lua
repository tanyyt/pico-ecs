function RndBetween(min,max)
 return rnd(max-min)+min
end
function GetRandomArray(arraySize)
 local arrayRand={}
 for i=1,arraySize do
  arrayRand[i]=i
 end
 for i=1,arraySize do
  local rand=flr(RndBetween(i,arraySize+1))
  arrayRand[i],arrayRand[rand]=arrayRand[rand],arrayRand[i]
 end
 return arrayRand
end
function InitSeedWithRealTime()
 local utcTime=0
 for i=80,85 do
  utcTime+=stat(i)
 end
 srand(utcTime)
end