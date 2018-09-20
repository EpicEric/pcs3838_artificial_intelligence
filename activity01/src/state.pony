use "collections"

class val State
  """
  Representation of a state in the problem.

  A state is valid if and only if each side has distinct characters between each
  other, for a total of 4 characters on both, and if the shepard is in the same
  margin as the sheep, or if the sheep is alone on its side.

  The initial state has all characters on the left side, and the final state,
  on the right side.
  """

  let left_side: SetIs[Character] val
  let right_side: SetIs[Character] val

  new val create(
    left_side': SetIs[Character] val,
    right_side': SetIs[Character] val)
  =>
    left_side = left_side'
    right_side = right_side'

  fun eq(that: State): Bool =>
    (left_side == that.left_side) and (right_side == that.right_side)

  fun ne(that: State): Bool =>
    not(this == that)

  fun hash(): USize =>
    if left_side.contains(Shepard) then 1 << 0 else 0 end or
    if left_side.contains(Wolf) then 1 << 1 else 0 end or
    if left_side.contains(Sheep) then 1 << 2 else 0 end or
    if left_side.contains(Cabbage) then 1 << 3 else 0 end or
    if right_side.contains(Shepard) then 1 << 4 else 0 end or
    if right_side.contains(Wolf) then 1 << 5 else 0 end or
    if right_side.contains(Sheep) then 1 << 6 else 0 end or
    if right_side.contains(Cabbage) then 1 << 7 else 0 end

  fun is_initial(): Bool =>
    (left_side.size() == 4) and (right_side.size() == 0)

  fun is_final(): Bool =>
    (left_side.size() == 0) and (right_side.size() == 4)

  fun is_valid(): Bool =>
    if (left_side xor right_side).size() == 4 then
      if left_side.contains(Shepard) or
        (not left_side.contains(Sheep)) or
        (left_side.size() == 1)
      then
        return right_side.contains(Shepard) or
          (not right_side.contains(Sheep)) or
          (right_side.size() == 1)
      end
    end
    false

  fun string(): String iso^ =>
    let s = recover String(29) end
    for l in left_side.values() do
      s.append(l.string())
      s.append(" ")
    end
    s.append("<>")
    for r in right_side.values() do
      s.append(" ")
      s.append(r.string())
    end
    consume s

primitive InitialState
  fun apply(): State =>
    let left_side: SetIs[Character] iso = recover left_side.create(4) end
    let right_side: SetIs[Character] iso = recover right_side.create(1) end
    left_side .> set(Shepard) .> set(Wolf) .> set(Sheep) .> set(Cabbage)
    State(consume left_side, consume right_side)

primitive FinalState
  fun apply(): State =>
    let left_side: SetIs[Character] iso = recover left_side.create(1) end
    let right_side: SetIs[Character] iso = recover right_side.create(4) end
    right_side .> set(Shepard) .> set(Wolf) .> set(Sheep) .> set(Cabbage)
    State(consume left_side, consume right_side)
