CastleRaid_Main_Data:
    type: data
    config:
        classes:
            Archer:
                material: BOW
                price: 0
                armor: leather
                health: 20
            Knight:
                material: DIAMOND_SWORD
                price: 0
                armor: iron
                health: 50
            Sniper:
                material: ARROW
                price: 750
                armor: leather
                health: 20
            Builder:
                material: IRON_PICKAXE
                price: 750
                armor: leather
                health: 40
            Mage:
                material: STICK
                price: 2250
                armor: leather
                health: 10
            Juggernaut:
                material: DIAMOND_CHESTPLATE
                price: 750
                armor: diamond
                health: 80
            Berserker:
                material: IRON_AXE
                price: 1500
                armor: air
                health: 20
            Spy:
                material: WOODEN_SWORD
                price: 3000
                armor: air
                health: 20
            Nature_Mage:
                material: FEATHER
                price: 750
                armor: leather
                health: 50
            Assassin:
                material: IRON_SWORD
                price: 2250
                armor: leather
                health: 16
            Sentry:
                material: MINECART
                price: 2250
                armor: leather
                health: 10
            Alchemist:
                material: BLAZE_ROD
                price: 1500
                armor: leather
                health: 30

ClassMenu_Events:
    type: world
    events:
        on player clicks in ClassMenu_Menu:
        - determine cancelled passively
        - if !<context.item.has_flag[class]>:
            - stop
        - define title <context.item.flag[class]>
        - if !<list[Archer|Knight].contains[<[title]>]>:
            - if !<player.has_flag[Class_Brought.<[title]>]>:
                - define price <script[CastleRaid_Main_Data].data_key[config.classes.<[title]>.price]>
                - if <player.flag[Coins]||0> >= <[price]>:
                    - flag player Coins:-:<[price]>
                    - flag player Class_Brought.<[title]>
                - else:
                    - narrate format:util_ff "<&7>You don't have enough coins"
                    - stop
        - flag player Chosen_Class:<[title]>
        - narrate format:util_ff "<&7>You have chosen the class: <&b><[title].to_titlecase>"
        # TODO: Remove debug
        - run Class_Loadout_Give_Task def:<[title]>

ClassMenu_Command:
    type: command
    description: Opens the class menu
    usage: /class
    name: class
    script:
    - inventory open d:ClassMenu_Menu

ClassMenu_Menu:
    type: inventory
    inventory: CHEST
    title: <&3>Choose Class
    definitions:
        Wall_A: Control_Panel_Item_Wall_A
        Wall_B: Control_Panel_Item_Wall_B
        Archer: <item[ClassMenu_Item_Archer].with_flag[class:Archer]>
        Knight: <item[ClassMenu_Item_Knight].with_flag[class:Knight]>
        Sniper: <item[ClassMenu_Item_Sniper].with_flag[class:Sniper]>
        Builder: <item[ClassMenu_Item_Builder].with_flag[class:Builder]>
        Mage: <item[ClassMenu_Item_Mage].with_flag[class:Mage]>
        Juggernaut: <item[ClassMenu_Item_Juggernaut].with_flag[class:Juggernaut]>
        Berserker: <item[ClassMenu_Item_Berserker].with_flag[class:Berserker]>
        Spy: <item[ClassMenu_Item_Spy].with_flag[class:Spy]>
        Nature_Mage: <item[ClassMenu_Item_Nature_Mage].with_flag[class:Nature_Mage]>
        Assassin: <item[ClassMenu_Item_Assassin].with_flag[class:Assassin]>
        Sentry: <item[ClassMenu_Item_Sentry].with_flag[class:Sentry]>
        Alchemist: <item[ClassMenu_Item_Alchemist].with_flag[class:Alchemist]>
    slots:
    - "[Wall_A] [Wall_B] [Wall_A] [Wall_B] [Wall_A] [Wall_B] [Wall_A] [Wall_B] [Wall_A]"
    - "[] [Archer] [] [Knight] [] [Sniper] [] [Builder] []"
    - "[] [Mage] [] [Juggernaut] [] [Berserker] [] [Spy] []"
    - "[] [Nature_Mage] [] [Assassin] [] [Sentry] [] [Alchemist] []"
    - "[Wall_A] [Wall_B] [Wall_A] [Wall_B] [Wall_A] [Wall_B] [Wall_A] [Wall_B] [Wall_A]"


Control_Panel_Item_Wall_A:
    type: item
    material: CYAN_STAINED_GLASS_PANE
    display name: <&sp>

Control_Panel_Item_Wall_B:
    type: item
    material: LIGHT_BLUE_STAINED_GLASS_PANE
    display name: <&sp>

ClassMenu_Item_Archer:
    type: item
    material: BOW
    display name: "<&b>Archer"
    lore:
    - "<&7>Free"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Knight:
    type: item
    material: DIAMOND_SWORD
    display name: "<&b>Knight"
    lore:
    - "<&7>Free"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Sniper:
    type: item
    material: ARROW
    display name: "<&b>Sniper"
    lore:
    - "<&7>Cost <&6>750 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Builder:
    type: item
    material: IRON_PICKAXE
    display name: "<&b>Builder"
    lore:
    - "<&7>Cost <&6>750 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Mage:
    type: item
    material: STICK
    display name: "<&b>Mage"
    lore:
    - "<&7>Cost <&6>2250 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Juggernaut:
    type: item
    material: DIAMOND_CHESTPLATE
    display name: "<&b>Juggernaut"
    lore:
    - "<&7>Cost <&6>750 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Berserker:
    type: item
    material: IRON_AXE
    display name: "<&b>Berserker"
    lore:
    - "<&7>Cost <&6>1500 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Spy:
    type: item
    material: WOODEN_SWORD
    display name: "<&b>Spy"
    lore:
    - "<&7>Cost <&6>3000 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Nature_Mage:
    type: item
    material: FEATHER
    display name: "<&b>Nature Mage"
    lore:
    - "<&7>Cost <&6>750 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Assassin:
    type: item
    material: IRON_SWORD
    display name: "<&b>Assassin"
    lore:
    - "<&7>Cost <&6>2250 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Sentry:
    type: item
    material: MINECART
    display name: "<&b>Sentry"
    lore:
    - "<&7>Cost <&6>2250 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES

ClassMenu_Item_Alchemist:
    type: item
    material: BLAZE_ROD
    display name: "<&b>Alchemist"
    lore:
    - "<&7>Cost <&6>1500 <&7>Coins"
    mechanisms:
        hides:
        - HIDE_ENCHANTS
        - HIDE_ATTRIBUTES