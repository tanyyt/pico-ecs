function _init()
 ClearWorld()
 -- entry scene
 InitExampleScene()
end
function _update()
 UpdateWorld()
end
function _draw()
 cls()
 DrawWorld()
 print(time(),0,0,2)
end