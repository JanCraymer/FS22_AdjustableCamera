AdjustableCamera = {}

AdjustableCamera.offsetStep = 0.02

function AdjustableCamera.prerequisitesPresent(specializations)
    return true
end

function AdjustableCamera.registerFunctions(vehicleType)
    SpecializationUtil.registerFunction(vehicleType, "adjustCamera", AdjustableCamera.adjustCamera)
end

function AdjustableCamera:adjustCamera(offsetX, offsetY, offsetZ)
    -- print("AdjustableCamera.adjustCamera");
    
    if self.isClient then
        -- print(offsetX, offsetY, offsetZ)
        local spec = self.spec_adjustableCamera
        local cam = self.spec_enterable.activeCamera

        if cam.isInside then
            spec.cameraChanged = true
            
            if spec.origTransX == nil then spec.origTransX = cam.transDirX end
            if spec.origTransY == nil then spec.origTransY = cam.transDirY end
            if spec.origTransZ == nil then spec.origTransZ = cam.transDirZ end

            cam.transDirX = cam.transDirX + offsetX
            cam.transDirY = cam.transDirY + offsetY
            cam.transDirZ = cam.transDirZ + offsetZ
            
            if cam.headTrackingNode ~= nil then
                local htX, htY, htZ = getTranslation(cam.headTrackingNode)
                if spec.origHtX == nil then spec.origHtX = htX end
                if spec.origHtY == nil then spec.origHtY = htY end
                if spec.origHtZ == nil then spec.origHtZ = htZ end
                setTranslation(cam.headTrackingNode, htX + offsetX, htY + offsetY, htZ + offsetZ)
            end
        end
    end
end

function AdjustableCamera:actionEventCameraForward(actionName, inputValue, callbackState, isAnalog)
    -- print("AdjustableCamera.actionEventCameraForward");
    if self.isClient then
        self:adjustCamera(0, 0, AdjustableCamera.offsetStep)
    end
end

function AdjustableCamera:actionEventCameraBackward(actionName, inputValue, callbackState, isAnalog)
    -- print("AdjustableCamera.actionEventCameraBackward");
    if self.isClient then
        self:adjustCamera(0, 0, -AdjustableCamera.offsetStep)
    end
end

function AdjustableCamera:actionEventCameraLeft(actionName, inputValue, callbackState, isAnalog)
    -- print("AdjustableCamera.actionEventCameraLeft");
    if self.isClient then
        self:adjustCamera(AdjustableCamera.offsetStep, 0, 0)
    end
end

function AdjustableCamera:actionEventCameraRight(actionName, inputValue, callbackState, isAnalog)
    -- print("AdjustableCamera.actionEventCameraRight");
    if self.isClient then
        self:adjustCamera(-AdjustableCamera.offsetStep, 0, 0)
    end
end

function AdjustableCamera:actionEventCameraReset()
    -- print("AdjustableCamera.actionEventCameraReset");
    local spec = self.spec_adjustableCamera
    if self.isClient and spec.cameraChanged ~= nil then
        local cam = self.spec_enterable.activeCamera

        if cam.isInside then
            cam.transDirX = spec.origTransX
            cam.transDirY = spec.origTransY
            cam.transDirZ = spec.origTransZ
            
            if cam.headTrackingNode ~= nil then
                setTranslation(cam.headTrackingNode, spec.origHtX, spec.origHtY, spec.origHtZ)
            end
        end
    end
end

function AdjustableCamera:onRegisterActionEvents(isActiveForInput, isActiveForInputIgnoreSelection)
    -- print("AdjustableCamera.onRegisterActionEvents");

    if self.isClient then

        local spec = self.spec_adjustableCamera
        self:clearActionEventsTable(spec.actionEvents)
        AdjustableCamera.actionEvents = {} 

        if self:getIsActiveForInput(true) and spec ~= nil then 

            local _, actionEventId = self:addActionEvent(AdjustableCamera.actionEvents, InputAction.ADJUSTABLE_CAMERA_FORWARD, self, AdjustableCamera.actionEventCameraForward, false, true, false, true, nil)
            g_inputBinding:setActionEventTextPriority(actionEventId, GS_PRIO_LOW)
            _, actionEventId = self:addActionEvent(AdjustableCamera.actionEvents, InputAction.ADJUSTABLE_CAMERA_BACKWARD, self, AdjustableCamera.actionEventCameraBackward, false, true, false, true, nil)
            g_inputBinding:setActionEventTextPriority(actionEventId, GS_PRIO_LOW)
            _, actionEventId = self:addActionEvent(AdjustableCamera.actionEvents, InputAction.ADJUSTABLE_CAMERA_LEFT, self, AdjustableCamera.actionEventCameraLeft, false, true, false, true, nil)
            g_inputBinding:setActionEventTextPriority(actionEventId, GS_PRIO_LOW)
            _, actionEventId = self:addActionEvent(AdjustableCamera.actionEvents, InputAction.ADJUSTABLE_CAMERA_RIGHT, self, AdjustableCamera.actionEventCameraRight, false, true, false, true, nil)
            g_inputBinding:setActionEventTextPriority(actionEventId, GS_PRIO_LOW)
            _, actionEventId = self:addActionEvent(AdjustableCamera.actionEvents, InputAction.ADJUSTABLE_CAMERA_RESET, self, AdjustableCamera.actionEventCameraReset, false, true, false, true, nil)
            g_inputBinding:setActionEventTextPriority(actionEventId, GS_PRIO_LOW)
        end
    end
end

function AdjustableCamera.registerEventListeners(vehicleType)
    -- print("AdjustableCamera.registerEventListeners");    
    -- SpecializationUtil.registerEventListener(vehicleType, "onLoad", AdjustableCamera);
    SpecializationUtil.registerEventListener(vehicleType, "onRegisterActionEvents", AdjustableCamera);
end