Class_Abilities_Events:
    type: world
    events:
        on player right clicks block with:Class_Loadout_Item_Class_Picker:
        - inventory open d:ClassMenu_Menu

        on player shoots Class_Loadout_Item_Sniper_Bow:
        - shoot arrow origin:<player> speed:<context.force.mul[5]>
        - wait 1t
        - remove <context.projectile>

        on player right clicks block with:Class_Loadout_Item_Mage_Wand:
        - if <player.has_flag[Mage_Wand_Cooldown]>:
            - stop
        - flag player Mage_Wand_Cooldown duration:11t
        - define start_loc <player.location>
        - define end_loc <player.precise_target_position[100]||<[start_loc].forward[100]>>
        - playsound <[start_loc]> sound:ENTITY_FIREWORK_ROCKET_LAUNCH volume:1 pitch:2
        - foreach <[start_loc].add[0,-1,0].points_between[<[end_loc]>].distance[4]||<list[]>>:
            - playeffect <[value]> effect:smoke quantity:1 data:0 offset:0.0 visibility:300
            - wait 1t
        - fancyexplosion <[end_loc]> radius:2 force:2 spread:4 breakrate:1.0 throwrate:1.0
        - playsound <[end_loc]> sound:ENTITY_GENERIC_EXPLODE volume:0.5 pitch:1

Test:
    type: task
    script:
    - fancyexplosion <player.cursor_on> radius:5 force:5 spread:5 breakrate:0.5 throwrate:0.5

Class_Loadout_Give_Task:
    type: task
    definitions: class
    script:
    - inventory clear
    - choose <script[CastleRaid_Main_Data].data_key[config.classes.<[class]>.armor]>:
        - case leather:
            - equip <player> head:leather_helmet[unbreakable=true] chest:leather_chestplate[unbreakable=true] legs:leather_leggings[unbreakable=true] boots:leather_boots[unbreakable=true]
        - case iron:
            - equip <player> head:iron_helmet[unbreakable=true] chest:iron_chestplate[unbreakable=true] legs:iron_leggings[unbreakable=true] boots:iron_boots[unbreakable=true]
        - case diamond:
            - equip <player> head:diamond_helmet[unbreakable=true] chest:diamond_chestplate[unbreakable=true] legs:diamond_leggings[unbreakable=true] boots:diamond_boots[unbreakable=true]
        - case air:
            - equip <player> head:air chest:air legs:air boots:air
        - default:
            - debug error "Class <[class]> has invalid armor: <script[CastleRaid_Main_Data].data_key[config.classes.<[class]>.armor]||null>"
    - flag player Class.Chosen:<[class]>
    - flag player Class.Passives:!
    - choose <[class]>:
        - case Archer:
            - give Class_Loadout_Item_Wood_Sword quantity:1
            - give Class_Loadout_Item_Archer_Bow quantity:1
            - give arrow quantity:1
        - case Knight:
            - give Class_Loadout_Item_Knight_Sword quantity:1
            - flag player Class.Passives.Run_Build_Up
        - case Sniper:
            - give Class_Loadout_Item_Sniper_Bow quantity:1
            - give arrow quantity:50
        - case Builder:
            - give Class_Loadout_Item_Wood_Sword quantity:1
            - give Class_Loadout_Item_Builder_Pickaxe quantity:1
            - give stone quantity:50
            - give Class_Loadout_Item_Builder_Toxic_Trap quantity:5
            - give Class_Loadout_Item_Builder_Claymore_Trap quantity:5
        - case Mage:
            - give Class_Loadout_Item_Wood_Sword quantity:1
            - give Class_Loadout_Item_Mage_Wand quantity:1
        - case Juggernaut:
            - give Class_Loadout_Item_Juggernaut_Sword quantity:1
        - case Berserker:
            - give Class_Loadout_Item_Berserker_Axe quantity:1
        - case Spy:
            - give Class_Loadout_Item_Spy_Knife quantity:1
            - give Class_Loadout_Item_Spy_Smoke_Grenade quantity:3
        - case Nature_Mage:
            - give Class_Loadout_Item_Wood_Sword quantity:1
            - give Class_Loadout_Item_Nature_Mage_Wand quantity:1
        - case Assassin:
            - give Class_Loadout_Item_Assassin_Knife quantity:1
        - case Sentry:
            - give Class_Loadout_Item_Wood_Sword quantity:1
            - give Class_Loadout_Item_Sentry_Turret quantity:1
        - case Alchemist:
            - give Class_Loadout_Item_Wood_Sword quantity:1
            - give Class_Loadout_Item_Alchemist_Wand quantity:1
        - default:
            - debug error "Class <[class]> has no gear"
    - cast SPEED remove
    - cast SLOW remove
    - if <[class]> == juggernaut:
        - cast slow amplifier:0 duration:60m
        - adjust <player> walk_speed:0.15
    - else:
        - cast speed amplifier:0 duration:60m
        - adjust <player> walk_speed:0.25
    - adjust <player> max_health:<script[CastleRaid_Main_Data].data_key[config.classes.<[class]>.health]>
    - adjust <player> health:<script[CastleRaid_Main_Data].data_key[config.classes.<[class]>.health]>
    - give Class_Loadout_Item_Class_Picker quantity:1 slot:9

Class_Loadout_Item_Class_Picker:
    type: item
    material: clock
    display name: "<&3>Choose Class"
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Wood_Sword:
    type: item
    material: wooden_sword
    display name: "<&3>Wooden Sword"
    lore:
    - "<&7>Incase of emergency."
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Archer_Bow:
    type: item
    material: BOW
    display name: "<&3>Archer's Bow"
    lore:
    - "<&7>Shoots normal arrows."
    enchantments:
    - ARROW_INFINITE:1
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Knight_Sword:
    type: item
    material: diamond_sword
    display name: "<&3>Knight's Sword"
    lore:
    - "<&7>Best sword."
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Sniper_Bow:
    type: item
    material: BOW
    display name: "<&3>Sniper's Rifle-Bow"
    lore:
    - "<&7>Shoots fast and precise arrows."
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Builder_Pickaxe:
    type: item
    material: iron_pickaxe
    display name: "<&3>Builder's Pickaxe"
    lore:
    - "<&7>Best Miner."
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Builder_Toxic_Trap:
    type: item
    material: stone_pressure_plate
    display name: "<&3>Toxic Trap"
    lore:
    - "<&7>Creates a toxic cloud when stepped on."
    - "<&7>Causes poison, blindless and"
    - "<&7>nausea to enemies in the area."
    mechanisms:
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"


Class_Loadout_Item_Builder_Claymore_Trap:
    type: item
    material: oak_pressure_plate
    display name: "<&3>Claymore"
    lore:
    - "<&7>Causes explosion when stepped on."
    mechanisms:
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Mage_Wand:
    type: item
    material: stick
    display name: "<&3>Mage's Wand"
    lore:
    - "<&7><&dq>Yer a wizard coalminer.<&dq>"
    enchantments:
    - ARROW_DAMAGE:10
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Juggernaut_Sword:
    type: item
    material: iron_sword
    display name: "<&3>Juggernaut's Sword"
    lore:
    - "<&7>Heavy sword for heavy dude."
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Berserker_Axe:
    type: item
    material: iron_axe
    display name: "<&3>Berserker's Axe"
    lore:
    - "<&7>Harder"
    - "<&7>Better"
    - "<&7>Faster"
    - "<&7>Stronger"
    mechanisms:
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Spy_Knife:
    type: item
    material: wooden_sword
    display name: "<&3>Backstabbing Knife"
    lore:
    - "<&7><&l>28 STAB WOUNDS"
    enchantments:
    - ARROW_DAMAGE:10
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES
        unbreakable: true
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Spy_Smoke_Grenade:
    type: item
    material: egg
    display name: "<&3>Smoke Grenade"
    lore:
    - "<&7>Smoke out"
    mechanisms:
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Nature_Mage_Wand:
    type: item
    material: feather
    display name: "<&3>Nature Wand"
    lore:
    - "<&7>Heals allies"
    enchantments:
    - ARROW_DAMAGE:10
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Assassin_Knife:
    type: item
    material: iron_sword
    display name: "<&3>Assassin's Knife"
    lore:
    - "<&7>Ved"
    enchantments:
    - ARROW_DAMAGE:10
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Sentry_Turret:
    type: item
    material: oak_fence
    display name: "<&3>Sentry Turret"
    lore:
    - "<&7>Places you in a turret when placed"
    mechanisms:
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"

Class_Loadout_Item_Alchemist_Wand:
    type: item
    material: blaze_rod
    display name: "<&3>Wither Wand"
    lore:
    - "<&7>Shoots wither skulls"
    enchantments:
    - ARROW_DAMAGE:10
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES
        nbt_attributes:
        - "generic.attackSpeed/mainhand/0/20000"
