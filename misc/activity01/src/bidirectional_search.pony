use "collections"

class BidirectionalSearch
  let _first: State
  let _last: State
  let _forward: StateTree = _forward.create(1 << 8)
  let _backward: StateTree = _backward.create(1 << 8)
  var _forward_iter: Map[State, State] = _forward_iter.create(1)
  var _backward_iter: Map[State, State] = _backward_iter.create(1)

  new create(first: State, last: State) =>
    _first = first
    _last = last
    _forward_iter(first) = first
    _backward_iter(last) = last

  fun ref apply(): String ? =>
    var prev_forward_size: USize
    var prev_backward_size: USize
    repeat
      prev_forward_size = _forward.size()
      prev_backward_size = _backward.size()
      advance_forward_iter()
      for state in _forward_iter.values() do
        if _backward.contains(state) then
          advance_forward_iter()
          return build_string(state)?
        end
      end
      advance_backward_iter()
      for state in _backward_iter.values() do
        if _forward.contains(state) then
          advance_backward_iter()
          return build_string(state)?
        end
      end
    until
      (_forward.size() == prev_forward_size) or
      (_backward.size() == prev_backward_size)
    end
    error

  fun ref advance_forward_iter() =>
    let forward_iter: Map[State, State] = _forward_iter = _forward_iter.create()
    for (state, prev_state) in forward_iter.pairs() do
      if state.is_valid() and not(_forward.contains(state)) then
        let reachable_states: MapIs[Action, State] val = ApplyAllActions(state)
        _forward(state) = (prev_state, reachable_states)
        for rs in reachable_states.values() do
          _forward_iter(rs) = state
        end
      end
    end

  fun ref advance_backward_iter() =>
    let backward_iter: Map[State, State] = _backward_iter = _backward_iter.create()
    for (state, prev_state) in backward_iter.pairs() do
      if state.is_valid() and not(_backward.contains(state)) then
        let reachable_states: MapIs[Action, State] val = ApplyAllActions(state)
        _backward(state) = (prev_state, reachable_states)
        for rs in reachable_states.values() do
          _backward_iter(rs) = state
        end
      end
    end

  fun build_string(middle_state: State): String ? =>
    let string: String iso = recover String end

    let forward_list: List[String] = forward_list.create()
    var middle_to_first_state: State = middle_state
    repeat
      let prev = _forward(middle_to_first_state)?._1
      let action_map = _forward(prev)?._2
      forward_list.unshift("\n")
      for (action, state) in action_map.pairs() do
        if state == middle_to_first_state then
          forward_list.unshift(action.string())
        end
      end
      forward_list.unshift("\n\n")
      forward_list.unshift(prev.string())
      middle_to_first_state = prev
    until middle_to_first_state == _first end
    for s in forward_list.values() do
      string.append(s)
    end

    string.append(middle_state.string())

    var middle_to_last_state: State = middle_state
    repeat
      let prev = _backward(middle_to_last_state)?._1
      let action_map = _backward(prev)?._2
      string.append("\n\n")
      for (action, state) in action_map.pairs() do
        if state == middle_to_last_state then
          string.append(action.reverse().string())
        end
      end
      string.append("\n")
      string.append(prev.string())
      middle_to_last_state = prev
    until middle_to_last_state == _last end

    consume string
