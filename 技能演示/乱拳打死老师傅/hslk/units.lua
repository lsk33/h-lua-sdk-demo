--- Generated by h-lua-sdk(https://github.com/hunzsig-warcraft3/h-lua-sdk)


local skill = hslk_ability({
    Name = "乱拳打死老师傅",
    Ubertip = hcolor.greenLight("乱拳打死老师傅"),
    Hotkey = "Q",
    _parent = "ANcl",
    DataA = { 0 },
    EffectArt = "",
    TargetArt = "",
    CasterArt = "",
    Cool = { 3 },
    DataB = { 1 },
    Cost = { 0 },
    DataD = { 0 },
    DataC = { 1 },
    Rng = { 1000 },
    DataF = { "channel" },
    targs = { "enemies" },
    DataE = { 0 },
    _onSkillEffect = _onSkillEffect(function(evtData)
        local u = evtData.triggerUnit
        local x = hunit.x(u)
        local y = hunit.y(u)
        local ang = hunit.getFacing(u)
        local xy = math.polarProjection(x,y,-300,ang)
        local i = 0
        htime.setInterval(0.3,function(curTimer)
            i = i + 1
            if (i > 20 or his.alive(evtData.targetUnit) == false) then
                curTimer.destroy()
                return
            end
            hskill.missile({
                missile = "war3mapImported\\GiantFireFist.mdx",
                scale = 1,
                hover = math.random(0,500),
                speed = 1000,
                sourceUnit = u,
                targetUnit = evtData.targetUnit,
                startX = xy.x,
                startY = math.random(xy.y - 300,xy.y + 300),
                onEnd = function(trigUnit,tarUnit,_,_)
                    hskill.damage({
                        sourceUnit = trigUnit, --伤害来源(可选)
                        targetUnit = tarUnit, --目标单位
                        damage = hattr.get(trigUnit,"str") * 10, --实际伤害
                        damageSrc = CONST_DAMAGE_SRC.skill,
                        damageType = { CONST_DAMAGE_TYPE.dark }
                    })
                end
            })
        end)
    end)
})

hslk_unit({
    _parent = "hpea",
    Name = "天选勇者",
    HP = 10000,
    abilList = string.implode(",", { skill._id }),
    Builds = ""
})

hslk_unit({
    _parent = "Obla",
    Name = "剑人",
    HP = 10000,
    abilList = string.implode(",", { skill._id }),
})