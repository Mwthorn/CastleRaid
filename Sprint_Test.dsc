Sprint_Test_Events:
    type: world
    events:
        on player starts sprinting:
        - if !<player.has_flag[Class.Passives.Run_Build_Up]>:
            - stop
        - define start 0.8
        - wait 2t
        - define build_up_time 100
        - repeat <[build_up_time]>:
            - if <player.is_sprinting>:
                - adjust <player> walk_speed:<[start].div[<[build_up_time]>].mul[<[value]>].round_to[2].add[0.2]>
                - actionbar "<&e><&l><element[1].div[<[build_up_time]>].mul[<[value]>].mul[100].format_number[###0]> <&pc>"
            - else:
                - actionbar <&7>
                - adjust <player> walk_speed:0.2
                - stop
            - wait 1t

        on player stops sprinting:
        - if !<player.has_flag[Class.Passives.Run_Build_Up]>:
            - stop
        - actionbar <&7>
        - adjust <player> walk_speed:0.2