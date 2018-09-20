use "collections"

interface val Action
  fun apply(state': State): State ?

primitive WolfRight is Action
  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Wolf)?
    right_side .> set(Shepard) .> set(Wolf)
    State(consume left_side, consume right_side)

primitive WolfLeft is Action
  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Wolf)?
    left_side .> set(Shepard) .> set(Wolf)
    State(consume left_side, consume right_side)

primitive SheepRight is Action
  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Sheep)?
    right_side .> set(Shepard) .> set(Sheep)
    State(consume left_side, consume right_side)

primitive SheepLeft is Action
  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Sheep)?
    left_side .> set(Shepard) .> set(Sheep)
    State(consume left_side, consume right_side)

primitive CabbageRight is Action
  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    left_side .> extract(Shepard)? .> extract(Cabbage)?
    right_side .> set(Shepard) .> set(Cabbage)
    State(consume left_side, consume right_side)

primitive CabbageLeft is Action
  fun apply(state': State): State ? =>
    let left_side: SetIs[Character] iso = recover state'.left_side.clone() end
    let right_side: SetIs[Character] iso = recover state'.right_side.clone() end
    right_side .> extract(Shepard)? .> extract(Cabbage)?
    left_side .> set(Shepard) .> set(Cabbage)
    State(consume left_side, consume right_side)
