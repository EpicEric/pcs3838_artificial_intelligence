use "collections"

class val State
  let left_side: SetIs[Character] val
  let right_side: SetIs[Character] val

  new val create(
    left_side': SetIs[Character] val,
    right_side': SetIs[Character] val)
  =>
    left_side = left_side'
    right_side = right_side'

  fun is_valid(): Bool =>
    // let all_sides: SetIs[Character] = all_sides.create(4)
    // all_sides .> set(Shepard) .> set(Wolf) .> set(Sheep) .> set(Cabbage)
    // if ((left_side.size() + right_side.size()) == 4)
    //   and ((left_side or right_side) == all_sides)
    // then
    if (left_side xor right_side).size() == 4 then
      if left_side.contains(Shepard)
        or (not left_side.contains(Sheep))
        or (not left_side.contains(Wolf) or not left_side.contains(Cabbage))
      then
        return right_side.contains(Shepard)
          or (not right_side.contains(Sheep))
          or (not right_side.contains(Wolf) or not right_side.contains(Cabbage))
      end
    end
    false

  fun is_initial(): Bool =>
    (left_side.size() == 4) and (right_side.size() == 0)

  fun is_final(): Bool =>
    (left_side.size() == 0) and (right_side.size() == 4)

  fun string(): String iso^ =>
    let s = recover String(29) end
    for l in left_side.values() do
      s.append(l.string())
      s.append(" ")
    end
    s.append("<>")
    for r in left_side.values() do
      s.append(" ")
      s.append(r.string())
    end
    consume s
