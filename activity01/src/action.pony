use "collections"

interface val Action
  fun string(): String
  fun reverse(): Action
  fun apply(state': State): State ?

primitive ShepardRight is Action
  fun string(): String => "[Shepard -->]"
  fun reverse(): Action => ShepardLeft

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)?
    right_side .> set(Shepard)
    State(consume left_side, consume right_side)

primitive ShepardLeft is Action
  fun string(): String => "[<-- Shepard]"
  fun reverse(): Action => ShepardRight

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)?
    left_side .> set(Shepard)
    State(consume left_side, consume right_side)

primitive WolfRight is Action
  fun string(): String => "[Shepard + Wolf -->]"
  fun reverse(): Action => WolfLeft

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Wolf)?
    right_side .> set(Shepard) .> set(Wolf)
    State(consume left_side, consume right_side)

primitive WolfLeft is Action
  fun string(): String => "[<-- Shepard + Wolf]"
  fun reverse(): Action => WolfRight

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Wolf)?
    left_side .> set(Shepard) .> set(Wolf)
    State(consume left_side, consume right_side)

primitive SheepRight is Action
  fun string(): String => "[Shepard + Sheep -->]"
  fun reverse(): Action => SheepLeft

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Sheep)?
    right_side .> set(Shepard) .> set(Sheep)
    State(consume left_side, consume right_side)

primitive SheepLeft is Action
  fun string(): String => "[<-- Shepard + Sheep]"
  fun reverse(): Action => SheepRight

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Sheep)?
    left_side .> set(Shepard) .> set(Sheep)
    State(consume left_side, consume right_side)

primitive CabbageRight is Action
  fun string(): String => "[Shepard + Cabbage -->]"
  fun reverse(): Action => CabbageLeft

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Cabbage)?
    right_side .> set(Shepard) .> set(Cabbage)
    State(consume left_side, consume right_side)

primitive CabbageLeft is Action
  fun string(): String => "[<-- Shepard + Cabbage]"
  fun reverse(): Action => CabbageRight

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Cabbage)?
    left_side .> set(Shepard) .> set(Cabbage)
    State(consume left_side, consume right_side)

primitive ApplyAllActions
  fun apply(state: State): MapIs[Action, State] iso^ =>
    let map: MapIs[Action, State] iso = recover map.create(8) end
    try map.update(ShepardRight, ShepardRight(state)?) end
    try map.update(ShepardLeft, ShepardLeft(state)?) end
    try map.update(WolfRight, WolfRight(state)?) end
    try map.update(WolfLeft, WolfLeft(state)?) end
    try map.update(SheepRight, SheepRight(state)?) end
    try map.update(SheepLeft, SheepLeft(state)?) end
    try map.update(CabbageRight, CabbageRight(state)?) end
    try map.update(CabbageLeft, CabbageLeft(state)?) end
    consume map
