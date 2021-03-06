-- ========== THIS IS AN AUTOMATICALLY GENERATED FILE! ==========

function DroneRangeIncreaseModBegin()--	DroneRangeIncreaseModBegin()-- CreateGameTimeThread function()
	const.CommandCenterMaxRadius = 50
	for i,v in ipairs(DroneHub.properties) do
		local prop = DroneHub.properties[i]
		if prop.id == "UIWorkRadius" then prop.max = 50 end
	end
end

local command_center_search = {
  class = "DroneControl",
  hexradius = 50,
  exec = function(center, building, dist_obj)
    if center.accept_requester_connects then
      if center.work_radius >= HexAxialDistance(dist_obj or building, center) then
        building:AddCommandCenter(center)
      end
    end
  end
}
TaskRequester.ConnectToCommandCenters = function(obj)
  local dome = IsObjInDome(obj)
  if dome then
    for i = 1, #(dome.command_centers or "") do
      local cc = dome.command_centers[i]
      obj:AddCommandCenter(cc)
    end
  else
    command_center_search.area = obj
    ForEach(command_center_search, obj)
    command_center_search.area = false
  end
end


function OnMsg.LoadGame()
	DroneRangeIncreaseModBegin()
end

function OnMsg.PostNewMapLoaded()
	DroneRangeIncreaseModBegin()
end