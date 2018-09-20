use "collections"

interface val Action
  fun string(): String
  fun apply(state': State): State ?

primitive WolfRight is Action
  fun string(): String => "Wolf to the right"

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Wolf)?
    right_side .> set(Shepard) .> set(Wolf)
    State(consume left_side, consume right_side)

primitive WolfLeft is Action
  fun string(): String => "Wolf to the left"

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Wolf)?
    left_side .> set(Shepard) .> set(Wolf)
    State(consume left_side, consume right_side)

primitive SheepRight is Action
  fun string(): String => "Sheep to the right"

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Sheep)?
    right_side .> set(Shepard) .> set(Sheep)
    State(consume left_side, consume right_side)

primitive SheepLeft is Action
  fun string(): String => "Sheep to the left"

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Sheep)?
    left_side .> set(Shepard) .> set(Sheep)
    State(consume left_side, consume right_side)

primitive CabbageRight is Action
  fun string(): String => "Cabbage to the right"

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Cabbage)?
    right_side .> set(Shepard) .> set(Cabbage)
    State(consume left_side, consume right_side)

primitive CabbageLeft is Action
  fun string(): String => "Cabbage to the left"

  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Cabbage)?
    left_side .> set(Shepard) .> set(Cabbage)
    State(consume left_side, consume right_side)

primitive ApplyAllActions
  fun apply(state: State): MapIs[Action, State] iso^ =>
    let map: MapIs[Action, State] iso = recover map.create(6) end
    try map.update(WolfRight, WolfRight(state)?) end
    try map.update(WolfLeft, WolfLeft(state)?) end
    try map.update(SheepRight, SheepRight(state)?) end
    try map.update(SheepLeft, SheepLeft(state)?) end
    try map.update(CabbageRight, CabbageRight(state)?) end
    try map.update(CabbageLeft, CabbageLeft(state)?) end
    consume map
