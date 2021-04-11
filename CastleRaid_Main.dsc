CastleRaid_Main_Events:
    type: world
    events:
        on dropped_item spawns:
        - determine cancelled

        on player drops item priority:-1:
        - determine cancelled

        on player picks up item:
        - determine cancelled passively
        - playeffect <context.location.add[0,-0.3,0]> effect:SMOKE quantity:10 data:0 offset:0.0
        - remove <context.entity>

        on player respawns:
        - if <player.has_flag[Team]>:
            - determine <server.flag[Teams.<player.flag[Team]>.Spawn_Locs].as_list.random>
        - determine <world[world].spawn_location>

        on player quits:
        - teleport <player> <world[world].spawn_location>

CastleRaid_Main_Remove_World_Task:
    type: task
    definitions: world_name
    script:
    - narrate <world[<[world_name]>]||null>
    - if <world[<[world_name]>]||null> != null:
        - inject Main_Controller_End_Task
    - if <world[<[world_name]>]||null> == null && <server.list_files[../../<[world_name]>]||null> != null:
        - createworld <[world_name]> generator:VoidGenerator:Forest worldtype:FLAT
    - if <world[<[world_name]>]||null> != null:
        - define wrl <world[<[world_name]>]>
        - teleport <[wrl].players> <world[world].spawn_location>
        - wait 1t
        # - announce <server.notables[cuboids]>
        - foreach <server.notables[cuboids]>:
            - define note_name <[value].note_name||null>
            - if <[note_name]> != null:
                - if <[value].world.name||null> == <[wrl].name>:
                    - note remove as:<[note_name]>
                    - define room_area <cuboid[world,<world[world].spawn_location.with_y[255].xyz>,<world[world].spawn_location.with_y[255].xyz>]>
                    - note <[room_area]> as:<[note_name]>
        # - announce <server.notables[cuboids]>
        - adjust <world[<[world_name]>]> destroy

CastleRaid_Main_Reload_World_Task:
    type: task
    script:
    - define world_name world_castleraid
    - announce format:util_ff "<&7>Generating new game..."
    - inject CastleRaid_Main_Remove_World_Task
    - createworld <[world_name]> generator:VoidGenerator:Forest worldtype:FLAT copy_from:world
    - foreach <server.online_players>:
        - teleport <player> <world[<[world_name]>].spawn_location>