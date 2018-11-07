use "collections"

type StateTreeValue is (State, MapIs[Action, State] val)
  """
  Every map value is the previous state and all reachable states with actions.
  """

type StateTree is Map[State, StateTreeValue]
  """
  The map lists reachable states and the next states.
  """
